#!/usr/bin/env lua

local script = arg[0]:gsub("\\", "/")
local modpath = script:match("^(.*)/scripts/[^/]+$") or "."
local output_path = modpath .. "/docs/professions.md"

local function read_file(path)
    local file, err = io.open(path, "rb")
    if not file then
        return nil, err
    end
    local content = file:read("*a")
    file:close()
    return content
end

local translations = {}
for line in assert(io.lines(modpath .. "/locale/professions.de.tr")) do
    if line ~= "" and line:sub(1, 1) ~= "#" then
        local source, translated = line:match("^(.-)=(.*)$")
        if source and translated ~= "" then
            translations[source] = translated
        end
    end
end

local function translate(source, ...)
    local args = {...}
    local result = (translations[source] or source):gsub("@(%d+)", function(index)
        return tostring(args[tonumber(index)] or "@" .. index)
    end)
    return result
end

core = {}
professions = {modpath = modpath, S = translate}

assert(loadfile(modpath .. "/core.lua"))()
assert(loadfile(modpath .. "/config.lua"))()
professions.validate_config()

local nodes = {}
local crafts = {}
local privileges = {}
local commands = {}

core.register_node = function(name, def)
    nodes[name] = def
end
core.register_craft = function(def)
    table.insert(crafts, def)
end
core.register_on_player_receive_fields = function() end
core.register_privilege = function(name, def)
    privileges[name] = def
end
core.register_chatcommand = function(name, def)
    commands[name] = def
end
core.formspec_escape = function(value) return value end
core.show_formspec = function() end
core.chat_send_player = function() end
core.get_item_group = function() return 0 end
core.add_item = function() end

default = {
    node_sound_wood_defaults = function() return {} end,
}

assert(loadfile(modpath .. "/workbench.lua"))()
assert(loadfile(modpath .. "/commands.lua"))()

local mod_conf = {}
for line in assert(io.lines(modpath .. "/mod.conf")) do
    local key, value = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
    if key then
        mod_conf[key] = value
    end
end

local lines = {}
local function add(value)
    table.insert(lines, value or "")
end

local function requirement(ability)
    local branch = professions.branches[ability.rank.branch]
    local rank
    for _, candidate in ipairs(branch.ranks) do
        if candidate.id == ability.rank.rank then
            rank = candidate
            break
        end
    end
    local result = branch.title .. ": " .. rank.title
    if ability.qualification then
        result = result .. " und " .. professions.qualifications[ability.qualification].title
    end
    return result
end

add("<!-- Automatisch erzeugt durch scripts/generate_professions_doc.lua. Nicht von Hand bearbeiten. -->")
add("# Berufe – Übersicht")
add()
add("## Berufsbaum")
add()
add("```text")
add("Berufssystem")
for branch_index, branch_id in ipairs(professions.branch_order) do
    local branch = professions.branches[branch_id]
    local last_branch = branch_index == #professions.branch_order
    add((last_branch and "└── " or "├── ") .. branch.title .. " (" .. branch.id .. ")")
    for rank_index, rank in ipairs(branch.ranks) do
        local last_rank = rank_index == #branch.ranks
        local prefix = last_branch and "    " or "│   "
        add(prefix .. (last_rank and "└── " or "├── ") .. rank.title
            .. " (" .. rank.id .. ") ab " .. rank.xp .. " XP")
    end
end
add("```")
add()

add("## XP-Quellen")
add()
add("| Tätigkeit | Technische ID | Zweig | Grund-XP | Dämpfung |")
add("| --- | --- | --- | ---: | --- |")
for _, activity_id in ipairs(professions.activity_order) do
    local activity = professions.activities[activity_id]
    add("| " .. activity.title .. " | `" .. activity.id .. "` | "
        .. professions.branches[activity.branch].title .. " | " .. activity.xp .. " | "
        .. (activity.repetition == false and "keine" or "aktiv") .. " |")
end
add()

local repetition = professions.activities[professions.activity_order[1]].repetition
add("### Wiederholungsdämpfung")
add()
add("| Einstellung | Wert |")
add("| --- | ---: |")
add("| Zeitfenster | " .. string.format("%g", repetition.window / 60) .. " Minuten |")
add("| Wiederholungen mit voller XP | " .. repetition.full_reward_count .. " |")
add("| Wiederholungen 4–6 | 50 % |")
add("| Wiederholungen 7–10 | 25 % |")
add("| Mindestfaktor ab Wiederholung 11 | "
    .. string.format("%g", repetition.minimum_factor * 100) .. " % |")
add("| Kleinste XP-Gutschrift | " .. string.format("%g", 1 / professions.XP_SCALE) .. " XP |")
add()

local forestry = professions.forestry_rules
local fell = professions.activities[forestry.fell_activity]
local plant = professions.activities[forestry.plant_activity]
local activate = professions.activities[forestry.activate_activity]
local advanced = professions.abilities[forestry.advanced_sapling_ability]
local advanced_tree = professions.abilities[forestry.advanced_tree_ability]
add("## Forstwirtschaftsregeln")
add()
add("| Handlung | Ergebnis | XP |")
add("| --- | --- | ---: |")
add("| Baum ohne Woodcutting fällen | keine XP | 0 |")
add("| Moretrees-Baum ohne " .. requirement(advanced_tree) .. " abbauen | gesperrt | 0 |")
add("| Spielerplatzierten Moretrees-Stamm abbauen | erlaubt | 0 |")
add("| Baum mit abgeschlossenem Woodcutting-Prozess fällen | "
    .. professions.branches[fell.branch].title .. "-XP | " .. fell.xp .. " |")
add("| Standardsetzling wachstumsfähig pflanzen | "
    .. professions.branches[plant.branch].title .. "-XP | " .. plant.xp .. " |")
add("| Moretrees-Setzling ohne " .. requirement(advanced) .. " pflanzen | Setzling ruht | 0 |")
add("| Moretrees-Setzling mit " .. requirement(advanced) .. " pflanzen | "
    .. professions.branches[plant.branch].title .. "-XP | " .. plant.xp .. " |")
add("| Ruhenden Moretrees-Setzling aktivieren | "
    .. professions.branches[activate.branch].title .. "-XP | " .. activate.xp .. " |")
add()
add("### Berücksichtigte Standardsetzlinge")
add()
local basic_saplings = {}
for name in pairs(forestry.basic_saplings) do table.insert(basic_saplings, name) end
table.sort(basic_saplings)
for _, name in ipairs(basic_saplings) do
    add("- `" .. name .. "`")
end
add()

local farming_rules = professions.farming_rules
add("## Landwirtschaftsregeln")
add()
add("Das Anpflanzen wird nach Kulturgruppe freigeschaltet. Bei der Ernte einer selbst")
add("gepflanzten, vollständig ausgewachsenen Kultur hängt die XP von der Rangstufe ab.")
add()
add("| Verhältnis der Kultur zum eigenen Rang | XP |")
add("| --- | ---: |")
add("| aktuelle Rangstufe | 1 |")
add("| eine Rangstufe niedriger | 0,2 |")
add("| mindestens zwei Rangstufen niedriger | 0,1 |")
add()
add("| Rang | Kulturen |")
add("| --- | --- |")
local crops_by_ability = {}
for crop_name, ability_id in pairs(farming_rules.crop_abilities) do
    crops_by_ability[ability_id] = crops_by_ability[ability_id] or {}
    table.insert(crops_by_ability[ability_id], "`" .. crop_name .. "`")
end
for _, ability_id in ipairs({
    "farming.crops.basic", "farming.crops.advanced",
    "farming.crops.specialty", "farming.crops.exotic",
}) do
    local crops = crops_by_ability[ability_id]
    table.sort(crops)
    add("| " .. requirement(professions.abilities[ability_id]) .. " | "
        .. table.concat(crops, ", ") .. " |")
end
add()

add("## Qualifikationen")
add()
add("| Anzeige | Technische ID |")
add("| --- | --- |")
for _, qualification_id in ipairs(professions.qualification_order) do
    local qualification = professions.qualifications[qualification_id]
    add("| " .. qualification.title .. " | `" .. qualification.id .. "` |")
end
add()

add("## Fähigkeiten und Voraussetzungen")
add()
add("| Fähigkeit | Technische ID | Voraussetzung |")
add("| --- | --- | --- |")
for _, ability_id in ipairs(professions.ability_order) do
    local ability = professions.abilities[ability_id]
    add("| " .. ability.title .. " | `" .. ability.id .. "` | " .. requirement(ability) .. " |")
end
add()
add("Das Platzieren der Geräte ist nicht beschränkt.")
add()

add("## Gegenstände und Geräte")
add()
add("| Anzeige | Technischer Name |")
add("| --- | --- |")
local node_names = {}
for name in pairs(nodes) do table.insert(node_names, name) end
table.sort(node_names)
for _, name in ipairs(node_names) do
    add("| " .. nodes[name].description .. " | `" .. name .. "` |")
end
add("| Moreblocks-Kreissäge | `moreblocks:circular_saw` |")
add()

add("### Rezept der Holzwerkbank")
add()
for _, craft in ipairs(crafts) do
    if craft.output == "professions:woodworking_bench" then
        add("```text")
        for _, row in ipairs(craft.recipe) do
            add(table.concat(row, " | "))
        end
        add("```")
    end
end
add()
add("Die Werkbank verarbeitet " .. professions.workbench.input_count .. " Gegenstand der Gruppe `"
    .. professions.workbench.input_group .. "` zu " .. professions.workbench.output_count
    .. " × `" .. professions.workbench.output .. "`.")
add()

add("## Verwaltungsrechte")
add()
add("| Recht | Beschreibung | Einzelspieler | Administrator |")
add("| --- | --- | --- | --- |")
local privilege_names = {}
for name in pairs(privileges) do table.insert(privilege_names, name) end
table.sort(privilege_names)
for _, name in ipairs(privilege_names) do
    local privilege = privileges[name]
    add("| `" .. name .. "` | " .. privilege.description .. " | "
        .. (privilege.give_to_singleplayer and "ja" or "nein") .. " | "
        .. (privilege.give_to_admin and "ja" or "nein") .. " |")
end
add()

add("## Befehle")
add()
add("| Befehl | Beschreibung | Benötigtes Recht |")
add("| --- | --- | --- |")
local command_names = {}
for name in pairs(commands) do table.insert(command_names, name) end
table.sort(command_names)
for _, name in ipairs(command_names) do
    local command = commands[name]
    local required = "–"
    if command.privs then
        local names = {}
        for privilege in pairs(command.privs) do table.insert(names, "`" .. privilege .. "`") end
        table.sort(names)
        required = table.concat(names, ", ")
    end
    add("| `/" .. name .. (command.params ~= "" and " " .. command.params or "") .. "` | "
        .. command.description .. " | " .. required .. " |")
end
add()

add("## Installation und Abhängigkeiten")
add()
add("| Eigenschaft | Einstellung |")
add("| --- | --- |")
add("| Modname | `" .. mod_conf.name .. "` |")
add("| Mindestversion | Luanti " .. mod_conf.min_minetest_version .. " |")
add("| Erforderliche Abhängigkeit | `" .. mod_conf.depends .. "` |")
add("| Optionale Abhängigkeit | `" .. mod_conf.optional_depends .. "` |")
add("| Ausgangssprache | Englisch |")
add("| Vorhandene Übersetzung | Deutsch |")
add()

local generated = table.concat(lines, "\n")
local check = arg[1] == "--check"
if check then
    local current = read_file(output_path)
    if current ~= generated then
        io.stderr:write("docs/professions.md ist nicht aktuell. Generator ausführen.\n")
        os.exit(1)
    end
    print("docs/professions.md ist aktuell")
    os.exit(0)
end

local temporary = output_path .. ".tmp"
local file = assert(io.open(temporary, "wb"))
file:write(generated)
file:close()
assert(os.rename(temporary, output_path))
print("docs/professions.md wurde erzeugt")
