local old_new_process = woodcutting.settings.on_new_process_hook
local old_step = woodcutting.settings.on_step_hook
local old_after_dig = woodcutting.settings.on_after_dig_hook
local rules = professions.forestry_rules

local function state(process)
    if not process.professions_forestry then
        process.professions_forestry = {
            tree_nodes = 0,
            has_moretrees = false,
            eligible = true,
            player_placed = false,
            awarded = false,
        }
    end
    return process.professions_forestry
end

woodcutting.settings.on_new_process_hook = function(process)
    if old_new_process and old_new_process(process) == false then
        return false
    end
    state(process)
    return true
end

woodcutting.settings.on_after_dig_hook = function(process, pos, oldnode)
    local progress = state(process)
    progress.tree_nodes = progress.tree_nodes + 1
    progress.player_placed = progress.player_placed or professions.is_player_placed_tree(pos)

    local namespace = oldnode.name:match("^([^:]+):")
    if namespace == rules.advanced_tree_namespace then
        progress.has_moretrees = true
    elseif namespace ~= rules.basic_tree_namespace then
        progress.eligible = false
    end

    if old_after_dig then
        return old_after_dig(process, pos, oldnode)
    end
    return true
end

woodcutting.settings.on_step_hook = function(process)
    if old_step and old_step(process) == false then
        return false
    end

    local progress = state(process)
    if not progress.awarded and progress.tree_nodes > 0 and not next(process.treenodes_hashed) then
        progress.awarded = true
        local player = core.get_player_by_name(process.playername)
        local rank_ok = not progress.has_moretrees
            or professions.has_rank(player, "forestry", "apprentice")
        if player and progress.eligible and not progress.player_placed and rank_ok then
            professions.record_activity(player, rules.fell_activity)
        end
    end
    return true
end
