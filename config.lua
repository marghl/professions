local S = professions.S

local function register_basic_branch(id, title)
    professions.register_branch {
        id = id,
        title = title,
        ranks = {
            {id = "novice", title = S("Novice"), xp = 0},
            {id = "apprentice", title = S("Apprentice"), xp = 100},
            {id = "journeyman", title = S("Journeyman"), xp = 300},
            {id = "master", title = S("Master"), xp = 700},
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

local function register_rank_ability(id, title, branch, rank)
    professions.register_ability {
        id = id,
        title = title,
        rank = {branch = branch, rank = rank},
    }
end

register_apprentice_ability("woodworking_bench.craft", S("Craft woodworking bench"), "crafting")
register_apprentice_ability("woodworking_bench.use", S("Use woodworking bench"), "crafting", "tool_knowledge")
register_apprentice_ability("moreblocks.circular_saw.craft", S("Craft circular saw"), "crafting")
register_apprentice_ability("moreblocks.circular_saw.use", S("Use circular saw"), "crafting", "tool_knowledge")
register_apprentice_ability("moretrees.sapling.grow", S("Grow Moretrees sapling"), "forestry")
register_apprentice_ability("moretrees.tree.fell", S("Fell Moretrees tree"), "forestry")
register_rank_ability("farming.crops.basic", S("Grow basic crops"), "farming", "novice")
register_rank_ability("farming.crops.advanced", S("Grow advanced crops"), "farming", "apprentice")
register_rank_ability("farming.crops.specialty", S("Grow specialty crops"), "farming", "journeyman")
register_rank_ability("farming.crops.exotic", S("Grow exotic crops"), "farming", "master")

professions.farming_rules = {
    harvest_activities = {
        current = "farming.harvest_current_crop",
        previous = "farming.harvest_previous_crop",
        lower = "farming.harvest_lower_crop",
    },
    rank_levels = {
        novice = 1,
        apprentice = 2,
        journeyman = 3,
        master = 4,
    },
    ability_levels = {
        ["farming.crops.basic"] = 1,
        ["farming.crops.advanced"] = 2,
        ["farming.crops.specialty"] = 3,
        ["farming.crops.exotic"] = 4,
    },
    crop_abilities = {
        ["farming:wheat"] = "farming.crops.basic",
        ["farming:potato"] = "farming.crops.basic",
        ["farming:carrot"] = "farming.crops.basic",
        ["farming:cotton"] = "farming.crops.basic",

        ["farming:barley"] = "farming.crops.advanced",
        ["farming:beans"] = "farming.crops.advanced",
        ["farming:beetroot"] = "farming.crops.advanced",
        ["farming:cabbage"] = "farming.crops.advanced",
        ["farming:corn"] = "farming.crops.advanced",
        ["farming:cucumber"] = "farming.crops.advanced",
        ["farming:lettuce"] = "farming.crops.advanced",
        ["farming:melon"] = "farming.crops.advanced",
        ["farming:oat"] = "farming.crops.advanced",
        ["farming:onion"] = "farming.crops.advanced",
        ["farming:pea_pod"] = "farming.crops.advanced",
        ["farming:pumpkin"] = "farming.crops.advanced",
        ["farming:rice"] = "farming.crops.advanced",
        ["farming:rye"] = "farming.crops.advanced",
        ["farming:tomato"] = "farming.crops.advanced",

        ["farming:artichoke"] = "farming.crops.specialty",
        ["farming:asparagus"] = "farming.crops.specialty",
        ["farming:blackberry"] = "farming.crops.specialty",
        ["farming:blueberries"] = "farming.crops.specialty",
        ["farming:chili_pepper"] = "farming.crops.specialty",
        ["farming:eggplant"] = "farming.crops.specialty",
        ["farming:garlic"] = "farming.crops.specialty",
        ["farming:ginger"] = "farming.crops.specialty",
        ["farming:grapes"] = "farming.crops.specialty",
        ["farming:hemp"] = "farming.crops.specialty",
        ["farming:mint"] = "farming.crops.specialty",
        ["farming:parsley"] = "farming.crops.specialty",
        ["farming:pepper"] = "farming.crops.specialty",
        ["farming:pineapple"] = "farming.crops.specialty",
        ["farming:raspberries"] = "farming.crops.specialty",
        ["farming:rhubarb"] = "farming.crops.specialty",
        ["farming:soy_pod"] = "farming.crops.specialty",
        ["farming:spinach"] = "farming.crops.specialty",
        ["farming:sunflower"] = "farming.crops.specialty",
        ["ethereal:strawberry"] = "farming.crops.specialty",

        ["farming:coffee"] = "farming.crops.exotic",
        ["farming:cocoa_beans"] = "farming.crops.exotic",
        ["farming:vanilla"] = "farming.crops.exotic",
    },
}

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
    id = "farming.harvest_current_crop",
    title = S("Harvest current-rank crop"),
    branch = "farming",
    xp = 1,
    repetition = false,
}

professions.register_activity {
    id = "farming.harvest_previous_crop",
    title = S("Harvest previous-rank crop"),
    branch = "farming",
    xp = 0.2,
    repetition = false,
}

professions.register_activity {
    id = "farming.harvest_lower_crop",
    title = S("Harvest lower-rank crop"),
    branch = "farming",
    xp = 0.1,
    repetition = false,
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
