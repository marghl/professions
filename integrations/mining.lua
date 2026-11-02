local rules = professions.mining_rules
local storage = core.get_mod_storage()

local function marker_key(pos)
    return rules.placed_marker_prefix .. string.format("%d,%d,%d", pos.x, pos.y, pos.z)
end

local function activity_for(node_name)
    if rules.rare_ores[node_name] then
        return rules.activities.rare_ore
    end
    if rules.valuable_ores[node_name] then
        return rules.activities.valuable_ore
    end
    if rules.common_ores[node_name] then
        return rules.activities.common_ore
    end
    if core.get_item_group(node_name, "stone") > 0 then
        return rules.activities.stone
    end
end

core.register_on_placenode(function(pos, newnode, placer)
    if placer and placer:is_player() and activity_for(newnode.name) then
        storage:set_string(marker_key(pos), "1")
    end
end)

core.register_on_dignode(function(pos, oldnode, digger)
    local key = marker_key(pos)
    local player_placed = storage:get_string(key) == "1"
    storage:set_string(key, "")

    if not player_placed and digger then
        local activity_id = activity_for(oldnode.name)
        if activity_id then
            professions.record_activity(digger, activity_id)
        end
    end
end)
