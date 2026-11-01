local S = professions.S

local function register_basic_branch(id, title)
    professions.register_branch {
        id = id,
        title = title,
        ranks = {
            {id = "novice", title = S("Novice"), xp = 0},
            {id = "apprentice", title = S("Apprentice"), xp = 100},
            {id = "journeyman", title = S("Journeyman"), xp = 300},
        },
    }
end

register_basic_branch("crafting", S("Crafting"))
register_basic_branch("construction", S("Construction"))
register_basic_branch("mining", S("Mining"))
register_basic_branch("farming", S("Farming"))
register_basic_branch("forestry", S("Forestry"))

professions.register_qualification {
    id = "tool_knowledge",
    title = S("Tool knowledge"),
}

local repetition = {
    window = 3600,
    full_reward_count = 3,
    minimum_factor = 0.1,
}

professions.register_activity {
    id = "crafting.craft.planks",
    branch = "crafting",
    xp = 1,
    repetition = repetition,
}

professions.register_activity {
    id = "crafting.craft.sticks",
    branch = "crafting",
    xp = 1,
    repetition = repetition,
}

professions.register_activity {
    id = "crafting.craft.torches",
    branch = "crafting",
    xp = 2,
    repetition = repetition,
}

professions.register_activity {
    id = "crafting.craft.wood_tool",
    branch = "crafting",
    xp = 5,
    repetition = repetition,
}

professions.register_activity {
    id = "crafting.craft.chest",
    branch = "crafting",
    xp = 10,
    repetition = repetition,
}
