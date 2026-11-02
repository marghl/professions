local S = professions.S
local DORMANT_KEY = "professions:dormant_sapling"
local PLACED_TREE_PREFIX = "placed_tree:"
local storage = core.get_mod_storage()
local rules = professions.forestry_rules

local function position_key(pos)
    return PLACED_TREE_PREFIX .. string.format("%d,%d,%d", pos.x, pos.y, pos.z)
end

function professions.is_player_placed_tree(pos)
    return storage:get_string(position_key(pos)) == "1"
end

core.register_on_placenode(function(pos, newnode, placer)
    if core.get_item_group(newnode.name, "tree") > 0 then
        storage:set_string(position_key(pos), "1")
    else
        storage:set_string(position_key(pos), "")
    end

    if not placer or not placer:is_player() or core.get_item_group(newnode.name, "sapling") <= 0 then
        return
    end

    local namespace = newnode.name:match("^([^:]+):")
    if rules.basic_saplings[newnode.name] then
        professions.record_activity(placer, rules.basic_plant_activity)
    elseif namespace == rules.advanced_tree_namespace then
        if professions.can(placer, rules.advanced_sapling_ability) then
            professions.record_activity(placer, rules.advanced_plant_activity)
        else
            local meta = core.get_meta(pos)
            meta:set_int(DORMANT_KEY, 1)
            core.get_node_timer(pos):stop()
            core.chat_send_player(placer:get_player_name(),
                S("This Moretrees sapling is dormant. The Apprentice forestry rank is required."))
        end
    end
end)

core.register_on_dignode(function(pos, oldnode)
    if core.get_item_group(oldnode.name, "tree") > 0 then
        storage:set_string(position_key(pos), "")
    end
end)

professions.forestry = {
    dormant_key = DORMANT_KEY,
}
