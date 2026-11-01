local WORKBENCH = "professions:woodworking_bench"
local S = professions.S

local plank_outputs = {
    ["default:wood"] = true,
    ["default:acacia_wood"] = true,
    ["default:aspen_wood"] = true,
    ["default:junglewood"] = true,
    ["default:pine_wood"] = true,
}

local wood_tools = {
    ["default:axe_wood"] = true,
    ["default:pick_wood"] = true,
    ["default:shovel_wood"] = true,
    ["default:sword_wood"] = true,
}

local function activity_for_output(name)
    if plank_outputs[name] then
        return "crafting.craft.planks"
    elseif name == "default:stick" then
        return "crafting.craft.sticks"
    elseif name == "default:torch" then
        return "crafting.craft.torches"
    elseif wood_tools[name] then
        return "crafting.craft.wood_tool"
    elseif name == "default:chest" then
        return "crafting.craft.chest"
    end
end

local function restore_grid(craft_inv, old_craft_grid)
    if not craft_inv then
        return
    end
    craft_inv:set_list("craft", old_craft_grid)
end

core.register_craft_predict(function(itemstack, player)
    if itemstack:get_name() == WORKBENCH and not professions.can(player, "woodworking_bench.craft") then
        return ItemStack("")
    end
end)

core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
    local output_name = itemstack:get_name()
    if output_name == WORKBENCH and not professions.can(player, "woodworking_bench.craft") then
        restore_grid(craft_inv, old_craft_grid)
        core.chat_send_player(player:get_player_name(),
            S("The woodworking bench can only be crafted from the Apprentice crafting rank onward."))
        return ItemStack("")
    end

    local activity_id = activity_for_output(output_name)
    if activity_id then
        professions.record_activity(player, activity_id, {repetition_key = output_name})
    end
end)
