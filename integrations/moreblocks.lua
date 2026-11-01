local SAW = "moreblocks:circular_saw"
local S = professions.S
local saw_def = core.registered_nodes[SAW]

if not saw_def then
    core.log("warning", "[professions] Moreblocks is loaded, but the circular saw was not found")
    return
end

local old_receive_fields = saw_def.on_receive_fields
local old_allow_put = saw_def.allow_metadata_inventory_put
local old_allow_take = saw_def.allow_metadata_inventory_take

local function can_use(player)
    return player ~= nil and professions.can(player, "moreblocks.circular_saw.use")
end

local function deny_use(player)
    if player and player:is_player() then
        core.chat_send_player(player:get_player_name(),
            S("Requires the Apprentice crafting rank and the Tool knowledge qualification."))
    end
end

core.override_item(SAW, {
    on_receive_fields = function(pos, formname, fields, sender)
        if not can_use(sender) then
            deny_use(sender)
            return
        end
        if old_receive_fields then
            return old_receive_fields(pos, formname, fields, sender)
        end
    end,

    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        if not can_use(player) then
            deny_use(player)
            return 0
        end
        if old_allow_put then
            return old_allow_put(pos, listname, index, stack, player)
        end
        return 0
    end,

    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        if not can_use(player) then
            deny_use(player)
            return 0
        end
        if old_allow_take then
            return old_allow_take(pos, listname, index, stack, player)
        end
        return 0
    end,
})

local function restore_grid(craft_inv, old_craft_grid)
    if craft_inv then
        craft_inv:set_list("craft", old_craft_grid)
    end
end

core.register_craft_predict(function(itemstack, player)
    if itemstack:get_name() == SAW and not professions.can(player, "moreblocks.circular_saw.craft") then
        return ItemStack("")
    end
end)

core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
    if itemstack:get_name() ~= SAW or professions.can(player, "moreblocks.circular_saw.craft") then
        return
    end
    restore_grid(craft_inv, old_craft_grid)
    core.chat_send_player(player:get_player_name(),
        S("The circular saw can only be crafted from the Apprentice crafting rank onward."))
    return ItemStack("")
end)

core.log("action", "[professions] Moreblocks circular saw integrated")
