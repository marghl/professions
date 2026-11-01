local modpath = core.get_modpath(core.get_current_modname())

professions = rawget(_G, "professions") or {}
professions.modpath = modpath
professions.S = core.get_translator("professions")

dofile(modpath .. "/core.lua")
dofile(modpath .. "/config.lua")

professions.validate_config()

dofile(modpath .. "/crafting.lua")
dofile(modpath .. "/workbench.lua")
if core.get_modpath("moreblocks") then
    dofile(modpath .. "/integrations/moreblocks.lua")
end
dofile(modpath .. "/commands.lua")

core.log("action", "[professions] Minimal test loaded")
