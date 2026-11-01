local XP_SCALE = 10
local META_PREFIX = "professions:"
local S = professions.S

professions.XP_SCALE = XP_SCALE
professions.branches = {}
professions.qualifications = {}
professions.activities = {}

local function assert_id(value, label)
    assert(type(value) == "string" and value:match("^[a-z][a-z0-9_.-]*$"),
        S("Invalid @1: @2", label or "ID", tostring(value)))
end

local function get_player(player_or_name)
    if type(player_or_name) == "string" then
        return core.get_player_by_name(player_or_name)
    end
    return player_or_name
end

local function player_name(player_or_name)
    if type(player_or_name) == "string" then
        return player_or_name
    end
    return player_or_name and player_or_name:get_player_name() or ""
end

function professions.register_branch(def)
    assert(type(def) == "table", S("Branch definition must be a table"))
    assert_id(def.id, S("branch ID"))
    assert(not professions.branches[def.id], S("Duplicate branch ID: @1", def.id))
    assert(type(def.title) == "string" and def.title ~= "", S("Branch title missing: @1", def.id))
    assert(type(def.ranks) == "table" and #def.ranks > 0, S("Ranks missing: @1", def.id))
    professions.branches[def.id] = def
end

function professions.register_qualification(def)
    assert(type(def) == "table", S("Qualification definition must be a table"))
    assert_id(def.id, S("qualification ID"))
    assert(not professions.qualifications[def.id], S("Duplicate qualification ID: @1", def.id))
    assert(type(def.title) == "string" and def.title ~= "", S("Qualification title missing: @1", def.id))
    professions.qualifications[def.id] = def
end

function professions.register_activity(def)
    assert(type(def) == "table", S("Activity definition must be a table"))
    assert_id(def.id, S("activity ID"))
    assert(not professions.activities[def.id], S("Duplicate activity ID: @1", def.id))
    assert_id(def.branch, S("activity branch ID"))
    assert(type(def.xp) == "number" and def.xp > 0, S("XP must be positive: @1", def.id))
    professions.activities[def.id] = def
end

function professions.validate_config()
    for branch_id, branch in pairs(professions.branches) do
        local previous_xp = -1
        local rank_ids = {}
        for index, rank in ipairs(branch.ranks) do
            assert_id(rank.id, S("rank ID in @1", branch_id))
            assert(not rank_ids[rank.id], S("Duplicate rank @1 in @2", rank.id, branch_id))
            assert(type(rank.title) == "string" and rank.title ~= "",
                S("Rank title missing in @1 at position @2", branch_id, index))
            assert(type(rank.xp) == "number" and rank.xp >= 0 and rank.xp > previous_xp,
                S("Rank XP must increase strictly in @1", branch_id))
            previous_xp = rank.xp
            rank_ids[rank.id] = true
        end
        branch._rank_ids = rank_ids
    end

    for activity_id, activity in pairs(professions.activities) do
        assert(professions.branches[activity.branch], S("Activity @1 references unknown branch @2",
            activity_id, activity.branch))
    end
end

local function xp_key(branch_id)
    return META_PREFIX .. "xp:" .. branch_id
end

function professions.get_xp(player_or_name, branch_id)
    local player = get_player(player_or_name)
    if not player or not professions.branches[branch_id] then
        return 0
    end
    return player:get_meta():get_int(xp_key(branch_id)) / XP_SCALE
end

local function get_scaled_xp(player, branch_id)
    return player:get_meta():get_int(xp_key(branch_id))
end

function professions.set_xp(player_or_name, branch_id, amount)
    local player = get_player(player_or_name)
    assert(player, S("Player must be online"))
    assert(professions.branches[branch_id], S("Unknown branch: @1", tostring(branch_id)))
    assert(type(amount) == "number", S("XP must be a number"))
    local scaled = math.max(0, math.floor(amount * XP_SCALE + 0.5))
    player:get_meta():set_int(xp_key(branch_id), scaled)
    return scaled / XP_SCALE
end

function professions.get_rank(player_or_name, branch_id)
    local branch = professions.branches[branch_id]
    if not branch then
        return nil
    end
    local xp = professions.get_xp(player_or_name, branch_id)
    local result = branch.ranks[1]
    for _, rank in ipairs(branch.ranks) do
        if xp >= rank.xp then
            result = rank
        else
            break
        end
    end
    return result
end

function professions.has_rank(player_or_name, branch_id, rank_id)
    local branch = professions.branches[branch_id]
    if not branch or not branch._rank_ids[rank_id] then
        return false
    end
    local required_xp
    for _, rank in ipairs(branch.ranks) do
        if rank.id == rank_id then
            required_xp = rank.xp
            break
        end
    end
    return professions.get_xp(player_or_name, branch_id) >= required_xp
end

local function qualification_key(qualification_id)
    return META_PREFIX .. "qualification:" .. qualification_id
end

function professions.has_qualification(player_or_name, qualification_id)
    local player = get_player(player_or_name)
    return player ~= nil
        and professions.qualifications[qualification_id] ~= nil
        and player:get_meta():get_int(qualification_key(qualification_id)) == 1
end

function professions.set_qualification(player_or_name, qualification_id, enabled)
    local player = get_player(player_or_name)
    assert(player, S("Player must be online"))
    assert(professions.qualifications[qualification_id],
        S("Unknown qualification: @1", tostring(qualification_id)))
    player:get_meta():set_int(qualification_key(qualification_id), enabled and 1 or 0)
end

function professions.can(player_or_name, ability_id)
    if ability_id == "woodworking_bench.craft" or ability_id == "moreblocks.circular_saw.craft" then
        return professions.has_rank(player_or_name, "crafting", "apprentice")
    elseif ability_id == "woodworking_bench.use" or ability_id == "moreblocks.circular_saw.use" then
        return professions.has_rank(player_or_name, "crafting", "apprentice")
            and professions.has_qualification(player_or_name, "tool_knowledge")
    end
    return false, S("Unknown ability: @1", tostring(ability_id))
end

local function load_activity_state(player)
    local raw = player:get_meta():get_string(META_PREFIX .. "activity_state")
    if raw == "" then
        return {}
    end
    local state = core.deserialize(raw)
    if type(state) ~= "table" then
        return {}
    end
    return state
end

local function save_activity_state(player, state)
    player:get_meta():set_string(META_PREFIX .. "activity_state", core.serialize(state))
end

local function repetition_factor(activity, entry, now)
    local repeat_def = activity.repetition or {}
    local window = repeat_def.window or 3600
    if not entry or now - (entry.last or 0) >= window then
        entry = {count = 0, last = now}
    end

    entry.count = entry.count + 1
    entry.last = now

    local full = repeat_def.full_reward_count or 3
    local factor
    if entry.count <= full then
        factor = 1
    elseif entry.count <= full * 2 then
        factor = 0.5
    elseif entry.count <= full * 3 + 1 then
        factor = 0.25
    else
        factor = repeat_def.minimum_factor or 0.1
    end
    return factor, entry
end

function professions.record_activity(player_or_name, activity_id, context)
    local player = get_player(player_or_name)
    local activity = professions.activities[activity_id]
    if not player or not activity then
        return 0
    end

    context = context or {}
    local state = load_activity_state(player)
    local state_key = activity_id .. ":" .. tostring(context.repetition_key or "default")
    local now = os.time()
    local factor, entry = repetition_factor(activity, state[state_key], now)
    state[state_key] = entry
    save_activity_state(player, state)

    local scaled_reward = math.max(1, math.floor(activity.xp * XP_SCALE * factor + 0.5))
    local old_rank = professions.get_rank(player, activity.branch)
    local new_scaled_xp = get_scaled_xp(player, activity.branch) + scaled_reward
    player:get_meta():set_int(xp_key(activity.branch), new_scaled_xp)
    local new_rank = professions.get_rank(player, activity.branch)

    local name = player_name(player)
    core.chat_send_player(name, S("Crafting: +@1 XP (total @2)",
        string.format("%.1f", scaled_reward / XP_SCALE),
        string.format("%.1f", new_scaled_xp / XP_SCALE)))

    if old_rank and new_rank and old_rank.id ~= new_rank.id then
        core.chat_send_player(name, S("New crafting rank: @1", new_rank.title))
    end
    return scaled_reward / XP_SCALE
end
