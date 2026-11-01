local S = professions.S

core.register_privilege("professions_admin", {
    description = S("Can manage profession XP and qualifications"),
    give_to_singleplayer = true,
    give_to_admin = true,
})

local function online_player(name)
    local player = core.get_player_by_name(name)
    if not player then
        return nil, S("Player @1 must be online.", name)
    end
    return player
end

core.register_chatcommand("professions_status", {
    params = "[player]",
    description = S("Shows crafting progress"),
    func = function(name, param)
        local target = param:match("^%s*(.-)%s*$")
        if target == "" then
            target = name
        elseif target ~= name and not core.check_player_privs(name, {professions_admin = true}) then
            return false, S("Viewing another player's status requires professions_admin.")
        end
        local player, err = online_player(target)
        if not player then
            return false, err
        end
        local rank = professions.get_rank(player, "crafting")
        local qualification = professions.has_qualification(player, "tool_knowledge") and S("yes") or S("no")
        return true, S("@1: Crafting @2 XP, rank @3, Tool knowledge: @4",
            target, string.format("%.1f", professions.get_xp(player, "crafting")), rank.title, qualification)
    end,
})

core.register_chatcommand("professions_set_xp", {
    params = "<player> <xp>",
    description = S("Sets crafting XP for the minimal test"),
    privs = {professions_admin = true},
    func = function(_, param)
        local target, amount = param:match("^(%S+)%s+([%d%.]+)%s*$")
        amount = tonumber(amount)
        if not target or not amount then
            return false, S("Usage: /professions_set_xp <player> <xp>")
        end
        local player, err = online_player(target)
        if not player then
            return false, err
        end
        local result = professions.set_xp(player, "crafting", amount)
        return true, S("Crafting XP for @1 set to @2.", target, string.format("%.1f", result))
    end,
})

core.register_chatcommand("professions_qualification", {
    params = "<grant|revoke> <player> <qualification>",
    description = S("Manages qualifications"),
    privs = {professions_admin = true},
    func = function(_, param)
        local action, target, qualification = param:match("^(%S+)%s+(%S+)%s+(%S+)%s*$")
        if action ~= "grant" and action ~= "revoke" then
            return false,
                S("Usage: /professions_qualification <grant|revoke> <player> <qualification>")
        end
        local player, err = online_player(target)
        if not player then
            return false, err
        end
        if not professions.qualifications[qualification] then
            return false, S("Unknown qualification: @1", tostring(qualification))
        end
        local enabled = action == "grant"
        professions.set_qualification(player, qualification, enabled)
        if enabled then
            return true, S("Qualification @1 granted to @2.", qualification, target)
        end
        return true, S("Qualification @1 revoked from @2.", qualification, target)
    end,
})
