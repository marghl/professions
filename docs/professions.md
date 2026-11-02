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

| Tätigkeit | Technische ID | Zweig | Tätigkeitsrang | Grund-XP | Wiederholungsdämpfung |
| --- | --- | --- | --- | ---: | --- |
| Einfaches Bauelement platzieren | `construction.place.basic_element` | Bauwesen | Pfuscher | 5 | keine |
| Tür, Fenster, Homedecor- oder Moreblocks-Element platzieren | `construction.place.special_element` | Bauwesen | Pfuscher | 10 | keine |
| Natürliches Gestein abbauen | `mining.dig.stone` | Bergbau | Pfuscher | 1 | keine |
| Gewöhnliches Erz abbauen | `mining.dig.common_ore` | Bergbau | Pfuscher | 3 | keine |
| Wertvolles Erz abbauen | `mining.dig.valuable_ore` | Bergbau | Pfuscher | 5 | keine |
| Seltenes Erz abbauen | `mining.dig.rare_ore` | Bergbau | Pfuscher | 10 | keine |
| Holzbretter herstellen | `crafting.craft.planks` | Handwerk | Pfuscher | 1 | aktiv |
| Stöcke herstellen | `crafting.craft.sticks` | Handwerk | Pfuscher | 1 | aktiv |
| Fackeln herstellen | `crafting.craft.torches` | Handwerk | Pfuscher | 2 | aktiv |
| Holzwerkzeug herstellen | `crafting.craft.wood_tool` | Handwerk | Pfuscher | 5 | aktiv |
| Truhe herstellen | `crafting.craft.chest` | Handwerk | Pfuscher | 10 | aktiv |
| Grundkultur ernten | `farming.harvest.basic` | Landwirtschaft | Pfuscher | 1 | keine |
| Fortgeschrittene Kultur ernten | `farming.harvest.advanced` | Landwirtschaft | Lehrling | 1 | keine |
| Spezialkultur ernten | `farming.harvest.specialty` | Landwirtschaft | Geselle | 1 | keine |
| Exotische Kultur ernten | `farming.harvest.exotic` | Landwirtschaft | Meister | 1 | keine |
| Standardbaum mit Woodcutting fällen | `forestry.fell.basic_tree` | Forstwirtschaft | Pfuscher | 5 | keine |
| Fortgeschrittenen Baum mit Woodcutting fällen | `forestry.fell.advanced_tree` | Forstwirtschaft | Lehrling | 5 | keine |
| Einfachen wachstumsfähigen Setzling pflanzen | `forestry.plant.basic_sapling` | Forstwirtschaft | Pfuscher | 5 | keine |
| Fortgeschrittenen wachstumsfähigen Setzling pflanzen | `forestry.plant.advanced_sapling` | Forstwirtschaft | Lehrling | 5 | keine |
| Ruhenden Setzling aktivieren | `forestry.activate_sapling` | Forstwirtschaft | Lehrling | 3 | keine |

### Zentrale Rangprogression

`XP = max(0,1; Grund-XP × Multiplikator ^ Rangdifferenz)`

| Zweig | Multiplikator |
| --- | ---: |
| Handwerk | 0.5 |
| Bauwesen | 0.5 |
| Bergbau | 0.5 |
| Landwirtschaft | 0.5 |
| Forstwirtschaft | 0.5 |

### Wiederholungsdämpfung

| Einstellung | Wert |
| --- | ---: |
| Zeitfenster | 60 Minuten |
| Wiederholungen mit voller XP | 3 |
| Wiederholungen 4–6 | 50 % |
| Wiederholungen 7–10 | 25 % |
| Mindestfaktor ab Wiederholung 11 | 10 % |
| Kleinste XP-Gutschrift | 0.1 XP |

## Bauwesenregeln

Alle Bautätigkeiten liegen auf der Grundstufe und schränken das Platzieren nicht ein.

| Platzierung | Grund-XP |
| --- | ---: |
| Treppe, Slab, Wand oder Zaun | 5 |
| Tür, Fenster, Homedecor- oder Moreblocks-Element | 10 |

## Bergbauregeln

Alle Bergbautätigkeiten liegen auf der Grundstufe. Spielerplatzierte Nodes geben keine Abbau-XP.

| Abbau | Grund-XP |
| --- | ---: |
| natürliches Gestein | 1 |
| gewöhnliches Erz | 3 |
| wertvolles Erz | 5 |
| seltenes Erz, einschließlich Diamant, Mithril und Uran | 10 |

## Forstwirtschaftsregeln

| Handlung | Ergebnis | XP |
| --- | --- | ---: |
| Baum ohne Woodcutting fällen | keine XP | 0 |
| Moretrees-Baum ohne Forstwirtschaft: Lehrling abbauen | gesperrt | 0 |
| Spielerplatzierten Moretrees-Stamm abbauen | erlaubt | 0 |
| Standardbaum mit abgeschlossenem Woodcutting-Prozess fällen | Forstwirtschaft-XP | 5 |
| Moretrees-Baum mit abgeschlossenem Woodcutting-Prozess fällen | Forstwirtschaft-XP | 5 |
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

Alle Kulturgruppen haben 1 Grund-XP. Die tatsächliche Gutschrift wird zentral
mit dem Multiplikator des Landwirtschaftsbaums berechnet.

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
