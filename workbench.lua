local WORKBENCH_FORM = "professions:woodworking_bench"
local S = professions.S

local function remove_one_wood(inventory)
    local list = inventory:get_list("main") or {}
    for index, stack in ipairs(list) do
        if not stack:is_empty() and core.get_item_group(stack:get_name(), "wood") > 0 then
            stack:take_item(1)
            inventory:set_stack("main", index, stack)
            return true
        end
    end
    return false
end

local function show_workbench(player)
    local formspec = table.concat({
        "formspec_version[4]",
        "size[8,5]",
        "label[0.5,0.5;" .. core.formspec_escape(S("Woodworking bench")) .. "]",
        "textarea[0.5,1.1;7,1.5;;;" .. core.formspec_escape(
            S("One wood block is processed into four practice parts.")) .. "]",
        "button[2,3;4,1;make_part;" .. core.formspec_escape(S("Make parts")) .. "]",
    })
    core.show_formspec(player:get_player_name(), WORKBENCH_FORM, formspec)
end

core.register_node("professions:woodworking_bench", {
    description = S("Woodworking bench"),
    tiles = {"professions_woodworking_bench.png"},
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults(),
    is_ground_content = false,
    on_rightclick = function(pos, node, clicker)
        if not professions.can(clicker, "woodworking_bench.use") then
            core.chat_send_player(clicker:get_player_name(),
                S("Requires the Apprentice crafting rank and the Tool knowledge qualification."))
            return
        end
        show_workbench(clicker)
    end,
})

core.register_node("professions:practice_part", {
    description = S("Practice part"),
    tiles = {"default_wood.png^[brighten"},
    groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
    sounds = default.node_sound_wood_defaults(),
    is_ground_content = false,
})

core.register_craft({
    output = "professions:woodworking_bench",
    recipe = {
        {"group:wood", "group:wood", "group:wood"},
        {"group:wood", "default:steel_ingot", "group:wood"},
        {"group:wood", "group:wood", "group:wood"},
    },
})

core.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= WORKBENCH_FORM or not fields.make_part then
        return false
    end
    if not professions.can(player, "woodworking_bench.use") then
        core.chat_send_player(player:get_player_name(), S("Permission denied."))
        return true
    end

    local inventory = player:get_inventory()
    if not remove_one_wood(inventory) then
        core.chat_send_player(player:get_player_name(), S("One wood block is required."))
        return true
    end

    local leftover = inventory:add_item("main", "professions:practice_part 4")
    if not leftover:is_empty() then
        core.add_item(player:get_pos(), leftover)
    end
    core.chat_send_player(player:get_player_name(), S("Four practice parts were made."))
    return true
end)
