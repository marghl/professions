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

local function register_apprentice_ability(id, title, qualification)
    professions.register_ability {
        id = id,
        title = title,
        rank = {branch = "crafting", rank = "apprentice"},
        qualification = qualification,
    }
end

register_apprentice_ability("woodworking_bench.craft", S("Craft woodworking bench"))
register_apprentice_ability("woodworking_bench.use", S("Use woodworking bench"), "tool_knowledge")
register_apprentice_ability("moreblocks.circular_saw.craft", S("Craft circular saw"))
register_apprentice_ability("moreblocks.circular_saw.use", S("Use circular saw"), "tool_knowledge")

professions.workbench = {
    input_group = "wood",
    input_count = 1,
    output = "professions:practice_part",
    output_count = 4,
    recipe = {
        {"group:wood", "group:wood", "group:wood"},
        {"group:wood", "default:steel_ingot", "group:wood"},
        {"group:wood", "group:wood", "group:wood"},
    },
}

local repetition = {
    window = 3600,
    full_reward_count = 3,
    minimum_factor = 0.1,
}

professions.register_activity {
    id = "crafting.craft.planks",
    title = S("Craft wooden planks"),
    branch = "crafting",
    xp = 1,
    repetition = repetition,
}

professions.register_activity {
    id = "crafting.craft.sticks",
    title = S("Craft sticks"),
    branch = "crafting",
    xp = 1,
    repetition = repetition,
}

professions.register_activity {
    id = "crafting.craft.torches",
    title = S("Craft torches"),
    branch = "crafting",
    xp = 2,
    repetition = repetition,
}

professions.register_activity {
    id = "crafting.craft.wood_tool",
    title = S("Craft wooden tool"),
    branch = "crafting",
    xp = 5,
    repetition = repetition,
}

professions.register_activity {
    id = "crafting.craft.chest",
    title = S("Craft chest"),
    branch = "crafting",
    xp = 10,
    repetition = repetition,
}
