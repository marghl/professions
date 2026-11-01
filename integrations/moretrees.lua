local S = professions.S
local dormant_key = professions.forestry.dormant_key
local rules = professions.forestry_rules

local function activate(pos, player)
    local meta = core.get_meta(pos)
    if meta:get_int(dormant_key) ~= 1 then
        return false
    end
    if not professions.can(player, rules.advanced_sapling_ability) then
        core.chat_send_player(player:get_player_name(),
            S("The Apprentice forestry rank is required to activate this sapling."))
        return true
    end
    local name = player:get_player_name()
    if core.is_protected(pos, name) then
        core.record_protection_violation(pos, name)
        return true
    end
    meta:set_int(dormant_key, 0)
    core.get_node_timer(pos):start(300)
    professions.record_activity(player, rules.activate_activity)
    core.chat_send_player(name, S("The Moretrees sapling is now active."))
    return true
end

core.register_on_mods_loaded(function()
    for node_name, definition in pairs(core.registered_nodes) do
        if node_name:match("^moretrees:") and core.get_item_group(node_name, "sapling") > 0 then
            local old_timer = definition.on_timer
            local old_rightclick = definition.on_rightclick
            core.override_item(node_name, {
                on_timer = function(pos, elapsed)
                    if core.get_meta(pos):get_int(dormant_key) == 1 then
                        return false
                    end
                    if old_timer then
                        return old_timer(pos, elapsed)
                    end
                end,
                on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                    if activate(pos, clicker) then
                        return itemstack
                    end
                    if old_rightclick then
                        return old_rightclick(pos, node, clicker, itemstack, pointed_thing)
                    end
                    return itemstack
                end,
            })
        end
    end
end)
