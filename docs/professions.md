<!-- Automatisch erzeugt durch scripts/generate_professions_doc.lua. Nicht von Hand bearbeiten. -->
# Berufe – Übersicht

## Berufsbaum

```text
Berufssystem
├── Handwerk (crafting)
│   ├── Pfuscher (novice) ab 0 XP
│   ├── Lehrling (apprentice) ab 100 XP
│   └── Geselle (journeyman) ab 300 XP
├── Bauwesen (construction)
│   ├── Pfuscher (novice) ab 0 XP
│   ├── Lehrling (apprentice) ab 100 XP
│   └── Geselle (journeyman) ab 300 XP
├── Bergbau (mining)
│   ├── Pfuscher (novice) ab 0 XP
│   ├── Lehrling (apprentice) ab 100 XP
│   └── Geselle (journeyman) ab 300 XP
├── Landwirtschaft (farming)
│   ├── Pfuscher (novice) ab 0 XP
│   ├── Lehrling (apprentice) ab 100 XP
│   └── Geselle (journeyman) ab 300 XP
└── Forstwirtschaft (forestry)
    ├── Pfuscher (novice) ab 0 XP
    ├── Lehrling (apprentice) ab 100 XP
    └── Geselle (journeyman) ab 300 XP
```

## XP-Quellen

| Tätigkeit | Technische ID | Zweig | Grund-XP | Dämpfung |
| --- | --- | --- | ---: | --- |
| Holzbretter herstellen | `crafting.craft.planks` | Handwerk | 1 | aktiv |
| Stöcke herstellen | `crafting.craft.sticks` | Handwerk | 1 | aktiv |
| Fackeln herstellen | `crafting.craft.torches` | Handwerk | 2 | aktiv |
| Holzwerkzeug herstellen | `crafting.craft.wood_tool` | Handwerk | 5 | aktiv |
| Truhe herstellen | `crafting.craft.chest` | Handwerk | 10 | aktiv |
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
| Optionale Abhängigkeit | `moreblocks, moretrees, woodcutting` |
| Ausgangssprache | Englisch |
| Vorhandene Übersetzung | Deutsch |
