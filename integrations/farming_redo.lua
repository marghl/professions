local S = professions.S
local rules = professions.farming_rules
local storage = core.get_mod_storage()
local marker_prefix = "farming_crop:"
local mature_crops = {}

local function marker_key(pos)
    return marker_prefix .. core.hash_node_position(pos)
end

local function mark_planted(pos, player_name, crop_name)
    storage:set_string(marker_key(pos), player_name .. "\n" .. crop_name)
end

local function read_marker(pos)
    local value = storage:get_string(marker_key(pos))
    local player_name, crop_name = value:match("^([^\n]+)\n(.+)$")
    return player_name, crop_name
end

local function planted_crop_at(pos, plant)
    local node = core.get_node_or_nil(pos)
    return node and (node.name == plant.seed
        or node.name == plant.crop
        or node.name:sub(1, #plant.crop + 1) == plant.crop .. "_")
end

core.register_on_mods_loaded(function()
    if not farming or farming.mod ~= "redo" or type(farming.registered_plants) ~= "table" then
        core.log("warning", "[professions] Installed farming mod is not Farming Redo; integration skipped")
        return
    end

    for crop_name, ability_id in pairs(rules.crop_abilities) do
        local plant = farming.registered_plants[crop_name]
        if plant then
            local seed_definition = core.registered_items[plant.seed]
            if seed_definition and seed_definition.on_place then
                local old_on_place = seed_definition.on_place
                core.override_item(plant.seed, {
                    on_place = function(itemstack, placer, pointed_thing)
                        if not placer or not professions.can(placer, ability_id) then
                            if placer then
                                core.chat_send_player(placer:get_player_name(),
                                    S("Your farming rank is too low for this crop."))
                            end
                            return itemstack
                        end

                        local before_under, before_above
                        if pointed_thing and pointed_thing.type == "node" then
                            before_under = core.get_node(pointed_thing.under).name
                            before_above = core.get_node(pointed_thing.above).name
                        end
                        local result = old_on_place(itemstack, placer, pointed_thing)
                        if pointed_thing and pointed_thing.type == "node" then
                            if core.get_node(pointed_thing.above).name ~= before_above
                                    and planted_crop_at(pointed_thing.above, plant) then
                                mark_planted(pointed_thing.above,
                                    placer:get_player_name(), plant.crop)
                            elseif core.get_node(pointed_thing.under).name ~= before_under
                                    and planted_crop_at(pointed_thing.under, plant) then
                                mark_planted(pointed_thing.under,
                                    placer:get_player_name(), plant.crop)
                            end
                        end
                        return result
                    end,
                })
            end

            mature_crops[plant.crop .. "_" .. plant.steps] = plant.crop
        end
    end

    core.log("action", "[professions] Farming Redo crops integrated")
end)

core.register_on_dignode(function(pos, oldnode, digger)
    local key = marker_key(pos)
    local owner, crop_name = read_marker(pos)
    storage:set_string(key, "")

    if digger and owner == digger:get_player_name() and mature_crops[oldnode.name] == crop_name then
        professions.record_activity(digger, rules.harvest_activity)
    end
end)
