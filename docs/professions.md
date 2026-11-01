<!-- Automatisch erzeugt durch scripts/generate_professions_doc.lua. Nicht von Hand bearbeiten. -->
# Berufe – Übersicht

## Berufsbaum

```text
Berufssystem
├── Handwerk (crafting)
│   ├── Pfuscher (novice) ab 0 XP
│   ├── Lehrling (apprentice) ab 100 XP
│   ├── Geselle (journeyman) ab 300 XP
│   └── Meister (master) ab 700 XP
├── Bauwesen (construction)
│   ├── Pfuscher (novice) ab 0 XP
│   ├── Lehrling (apprentice) ab 100 XP
│   ├── Geselle (journeyman) ab 300 XP
│   └── Meister (master) ab 700 XP
├── Bergbau (mining)
│   ├── Pfuscher (novice) ab 0 XP
│   ├── Lehrling (apprentice) ab 100 XP
│   ├── Geselle (journeyman) ab 300 XP
│   └── Meister (master) ab 700 XP
├── Landwirtschaft (farming)
│   ├── Pfuscher (novice) ab 0 XP
│   ├── Lehrling (apprentice) ab 100 XP
│   ├── Geselle (journeyman) ab 300 XP
│   └── Meister (master) ab 700 XP
└── Forstwirtschaft (forestry)
    ├── Pfuscher (novice) ab 0 XP
    ├── Lehrling (apprentice) ab 100 XP
    ├── Geselle (journeyman) ab 300 XP
    └── Meister (master) ab 700 XP
```

## XP-Quellen

| Tätigkeit | Technische ID | Zweig | Grund-XP | Dämpfung |
| --- | --- | --- | ---: | --- |
| Holzbretter herstellen | `crafting.craft.planks` | Handwerk | 1 | aktiv |
| Stöcke herstellen | `crafting.craft.sticks` | Handwerk | 1 | aktiv |
| Fackeln herstellen | `crafting.craft.torches` | Handwerk | 2 | aktiv |
| Holzwerkzeug herstellen | `crafting.craft.wood_tool` | Handwerk | 5 | aktiv |
| Truhe herstellen | `crafting.craft.chest` | Handwerk | 10 | aktiv |
| Kultur der aktuellen Rangstufe ernten | `farming.harvest_current_crop` | Landwirtschaft | 1 | keine |
| Kultur der vorherigen Rangstufe ernten | `farming.harvest_previous_crop` | Landwirtschaft | 0.2 | keine |
| Kultur einer niedrigeren Rangstufe ernten | `farming.harvest_lower_crop` | Landwirtschaft | 0.1 | keine |
| Baum mit Woodcutting fällen | `forestry.fell_tree` | Forstwirtschaft | 5 | keine |
| Wachstumsfähigen Setzling pflanzen | `forestry.plant_sapling` | Forstwirtschaft | 5 | keine |
| Ruhenden Setzling aktivieren | `forestry.activate_sapling` | Forstwirtschaft | 3 | keine |

### Wiederholungsdämpfung

| Einstellung | Wert |
| --- | ---: |
| Zeitfenster | 60 Minuten |
| Wiederholungen mit voller XP | 3 |
| Wiederholungen 4–6 | 50 % |
| Wiederholungen 7–10 | 25 % |
| Mindestfaktor ab Wiederholung 11 | 10 % |
| Kleinste XP-Gutschrift | 0.1 XP |

## Forstwirtschaftsregeln

| Handlung | Ergebnis | XP |
| --- | --- | ---: |
| Baum ohne Woodcutting fällen | keine XP | 0 |
| Moretrees-Baum ohne Forstwirtschaft: Lehrling abbauen | gesperrt | 0 |
| Spielerplatzierten Moretrees-Stamm abbauen | erlaubt | 0 |
| Baum mit abgeschlossenem Woodcutting-Prozess fällen | Forstwirtschaft-XP | 5 |
| Standardsetzling wachstumsfähig pflanzen | Forstwirtschaft-XP | 5 |
| Moretrees-Setzling ohne Forstwirtschaft: Lehrling pflanzen | Setzling ruht | 0 |
| Moretrees-Setzling mit Forstwirtschaft: Lehrling pflanzen | Forstwirtschaft-XP | 5 |
| Ruhenden Moretrees-Setzling aktivieren | Forstwirtschaft-XP | 3 |

### Berücksichtigte Standardsetzlinge

- `default:acacia_sapling`
- `default:aspen_sapling`
- `default:emergent_jungle_sapling`
- `default:junglesapling`
- `default:pine_sapling`
- `default:sapling`

## Landwirtschaftsregeln

Das Anpflanzen wird nach Kulturgruppe freigeschaltet. Bei der Ernte einer selbst
gepflanzten, vollständig ausgewachsenen Kultur hängt die XP von der Rangstufe ab.

| Verhältnis der Kultur zum eigenen Rang | XP |
| --- | ---: |
| aktuelle Rangstufe | 1 |
| eine Rangstufe niedriger | 0,2 |
| mindestens zwei Rangstufen niedriger | 0,1 |

| Rang | Kulturen |
| --- | --- |
| Landwirtschaft: Pfuscher | `farming:carrot`, `farming:cotton`, `farming:potato`, `farming:wheat` |
| Landwirtschaft: Lehrling | `farming:barley`, `farming:beans`, `farming:beetroot`, `farming:cabbage`, `farming:corn`, `farming:cucumber`, `farming:lettuce`, `farming:melon`, `farming:oat`, `farming:onion`, `farming:pea_pod`, `farming:pumpkin`, `farming:rice`, `farming:rye`, `farming:tomato` |
| Landwirtschaft: Geselle | `ethereal:strawberry`, `farming:artichoke`, `farming:asparagus`, `farming:blackberry`, `farming:blueberries`, `farming:chili_pepper`, `farming:eggplant`, `farming:garlic`, `farming:ginger`, `farming:grapes`, `farming:hemp`, `farming:mint`, `farming:parsley`, `farming:pepper`, `farming:pineapple`, `farming:raspberries`, `farming:rhubarb`, `farming:soy_pod`, `farming:spinach`, `farming:sunflower` |
| Landwirtschaft: Meister | `farming:cocoa_beans`, `farming:coffee`, `farming:vanilla` |

## Qualifikationen

| Anzeige | Technische ID |
| --- | --- |
| Werkzeugkunde | `tool_knowledge` |

## Fähigkeiten und Voraussetzungen

| Fähigkeit | Technische ID | Voraussetzung |
| --- | --- | --- |
| Holzwerkbank herstellen | `woodworking_bench.craft` | Handwerk: Lehrling |
| Holzwerkbank benutzen | `woodworking_bench.use` | Handwerk: Lehrling und Werkzeugkunde |
| Kreissäge herstellen | `moreblocks.circular_saw.craft` | Handwerk: Lehrling |
| Kreissäge benutzen | `moreblocks.circular_saw.use` | Handwerk: Lehrling und Werkzeugkunde |
| Moretrees-Setzling wachsen lassen | `moretrees.sapling.grow` | Forstwirtschaft: Lehrling |
| Moretrees-Baum fällen | `moretrees.tree.fell` | Forstwirtschaft: Lehrling |
| Grundkulturen anbauen | `farming.crops.basic` | Landwirtschaft: Pfuscher |
| Fortgeschrittene Kulturen anbauen | `farming.crops.advanced` | Landwirtschaft: Lehrling |
| Spezialkulturen anbauen | `farming.crops.specialty` | Landwirtschaft: Geselle |
| Exotische Kulturen anbauen | `farming.crops.exotic` | Landwirtschaft: Meister |

Das Platzieren der Geräte ist nicht beschränkt.

## Gegenstände und Geräte

| Anzeige | Technischer Name |
| --- | --- |
| Übungsbauteil | `professions:practice_part` |
| Holzwerkbank | `professions:woodworking_bench` |
| Moreblocks-Kreissäge | `moreblocks:circular_saw` |

### Rezept der Holzwerkbank

```text
group:wood | group:wood | group:wood
group:wood | default:steel_ingot | group:wood
group:wood | group:wood | group:wood
```

Die Werkbank verarbeitet 1 Gegenstand der Gruppe `wood` zu 4 × `professions:practice_part`.

## Verwaltungsrechte

| Recht | Beschreibung | Einzelspieler | Administrator |
| --- | --- | --- | --- |
| `professions_admin` | Darf Berufs-XP und Qualifikationen verwalten | ja | ja |

## Befehle

| Befehl | Beschreibung | Benötigtes Recht |
| --- | --- | --- |
| `/professions_qualification <grant|revoke> <player> <qualification>` | Verwaltet Qualifikationen | `professions_admin` |
| `/professions_set_xp <player> <branch> <xp>` | Setzt Zweig-XP für den Minimaltest | `professions_admin` |
| `/professions_status [player]` | Zeigt den Berufsfortschritt | – |

## Installation und Abhängigkeiten

| Eigenschaft | Einstellung |
| --- | --- |
| Modname | `professions` |
| Mindestversion | Luanti 5.4 |
| Erforderliche Abhängigkeit | `default` |
| Optionale Abhängigkeit | `moreblocks, moretrees, woodcutting, farming` |
| Ausgangssprache | Englisch |
| Vorhandene Übersetzung | Deutsch |
