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

local function register_apprentice_ability(id, title, branch, qualification)
    professions.register_ability {
        id = id,
        title = title,
        rank = {branch = branch, rank = "apprentice"},
        qualification = qualification,
    }
end

register_apprentice_ability("woodworking_bench.craft", S("Craft woodworking bench"), "crafting")
register_apprentice_ability("woodworking_bench.use", S("Use woodworking bench"), "crafting", "tool_knowledge")
register_apprentice_ability("moreblocks.circular_saw.craft", S("Craft circular saw"), "crafting")
register_apprentice_ability("moreblocks.circular_saw.use", S("Use circular saw"), "crafting", "tool_knowledge")
register_apprentice_ability("moretrees.sapling.grow", S("Grow Moretrees sapling"), "forestry")
register_apprentice_ability("moretrees.tree.fell", S("Fell Moretrees tree"), "forestry")

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

professions.forestry_rules = {
    basic_tree_namespace = "default",
    basic_saplings = {
        ["default:sapling"] = true,
        ["default:junglesapling"] = true,
        ["default:emergent_jungle_sapling"] = true,
        ["default:pine_sapling"] = true,
        ["default:acacia_sapling"] = true,
        ["default:aspen_sapling"] = true,
    },
    advanced_tree_namespace = "moretrees",
    advanced_sapling_ability = "moretrees.sapling.grow",
    advanced_tree_ability = "moretrees.tree.fell",
    fell_activity = "forestry.fell_tree",
    plant_activity = "forestry.plant_sapling",
    activate_activity = "forestry.activate_sapling",
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

professions.register_activity {
    id = "forestry.fell_tree",
    title = S("Fell tree with Woodcutting"),
    branch = "forestry",
    xp = 5,
    repetition = false,
}

professions.register_activity {
    id = "forestry.plant_sapling",
    title = S("Plant active sapling"),
    branch = "forestry",
    xp = 5,
    repetition = false,
}

professions.register_activity {
    id = "forestry.activate_sapling",
    title = S("Activate dormant sapling"),
    branch = "forestry",
    xp = 3,
    repetition = false,
}
