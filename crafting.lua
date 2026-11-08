local WORKBENCH = "professions:woodworking_bench"
local S = professions.S
local rules = professions.crafting_rules

local plank_outputs = {
    ["default:wood"] = true,
    ["default:acacia_wood"] = true,
    ["default:aspen_wood"] = true,
    ["default:junglewood"] = true,
    ["default:pine_wood"] = true,
}

local function activity_for_output(name)
    if plank_outputs[name] then
        return "crafting.craft.planks"
    elseif name == "default:stick" then
        return "crafting.craft.sticks"
    elseif name == "default:torch" then
        return "crafting.craft.torches"
    elseif name == "default:chest" then
        return "crafting.craft.chest"
    end
    return rules.default_activity
end

local function tool_rank(name)
    if not core.registered_tools[name] then
        return nil
    end
    for material, rank in pairs(rules.tool_material_ranks) do
        if name:match("_" .. material .. "$") then
            return rank
        end
    end
    return "master"
end

local function required_rank(name)
    local rank = tool_rank(name)
    if rank then
        return rank
    end
    local ability_id = rules.special_abilities[name]
    local ability = ability_id and professions.abilities[ability_id]
    return ability and ability.rank.rank or nil
end

local function can_craft(player, name)
    local ability = rules.special_abilities[name]
    if ability and not professions.can(player, ability) then
        return false
    end
    local rank = required_rank(name)
    return not rank or professions.has_rank(player, "crafting", rank)
end

local function deny_message(player, name)
    local rank = required_rank(name)
    if rank then
        local rank_def = professions.branches.crafting.ranks[
            professions.branches.crafting._rank_indices[rank]]
        core.chat_send_player(player:get_player_name(),
            S("Crafting @1 requires the @2 crafting rank.",
                core.registered_items[name].description, rank_def.title))
    end
end

local function restore_grid(craft_inv, old_craft_grid)
    if not craft_inv then
        return
    end
    craft_inv:set_list("craft", old_craft_grid)
end

core.register_craft_predict(function(itemstack, player)
    if not can_craft(player, itemstack:get_name()) then
        return ItemStack("")
    end
end)

core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
    local output_name = itemstack:get_name()
    if not can_craft(player, output_name) then
        restore_grid(craft_inv, old_craft_grid)
        deny_message(player, output_name)
        return ItemStack("")
    end

    local rank = tool_rank(output_name)
    local activity_id = rank and rules.tool_activities[rank] or activity_for_output(output_name)
    professions.record_activity(player, activity_id, {repetition_key = output_name})
end)
