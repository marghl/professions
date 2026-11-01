# Berufe – Übersicht

Diese Datei zeigt den aktuell eingerichteten Stand des Berufssystems in
menschenlesbarer Form. Verbindlich für den Server bleiben die technischen
Konfigurationsdateien.

## Berufsbaum

```text
Berufssystem
├── Handwerk
│   ├── Pfuscher      ab   0 XP
│   ├── Lehrling      ab 100 XP
│   └── Geselle       ab 300 XP
├── Bauwesen
│   ├── Pfuscher      ab   0 XP
│   ├── Lehrling      ab 100 XP
│   └── Geselle       ab 300 XP
├── Bergbau
│   ├── Pfuscher      ab   0 XP
│   ├── Lehrling      ab 100 XP
│   └── Geselle       ab 300 XP
├── Landwirtschaft
│   ├── Pfuscher      ab   0 XP
│   ├── Lehrling      ab 100 XP
│   └── Geselle       ab 300 XP
└── Forstwirtschaft
    ├── Pfuscher      ab   0 XP
    ├── Lehrling      ab 100 XP
    └── Geselle       ab 300 XP
```

Derzeit sammelt nur **Handwerk** tatsächlich XP. Die übrigen vier Zweige sind
angelegt, besitzen aber noch keine XP-Quellen oder besonderen Freigaben.

## Handwerks-XP

| Erfolgreich hergestellter Gegenstand | Grund-XP |
| --- | ---: |
| Holzbretter | 1 |
| Stöcke | 1 |
| Fackeln | 2 |
| Holzwerkzeug | 5 |
| Truhe | 10 |

### Wiederholungsdämpfung

Die Wiederholungen werden für eine Stunde getrennt nach hergestelltem
Gegenstand gezählt.

| Wiederholung innerhalb einer Stunde | Anteil der Grund-XP |
| --- | ---: |
| 1–3 | 100 % |
| 4–6 | 50 % |
| 7–10 | 25 % |
| ab 11 | 10 % |

Die kleinste tatsächlich vergebene Menge beträgt 0,1 XP.

## Qualifikationen

| Qualifikation | Vergabe | Derzeit benötigt für |
| --- | --- | --- |
| Werkzeugkunde | Administrativer Befehl | Benutzung von Holzwerkbank und Kreissäge |

Qualifikationen sind unabhängig vom Rang. Ein Spieler kann deshalb den
benötigten Rang besitzen, ohne bereits die erforderliche Qualifikation zu
haben.

## Holzwerkbank

| Handlung | Voraussetzung |
| --- | --- |
| Herstellen | Handwerk: Lehrling |
| Benutzen | Handwerk: Lehrling und Werkzeugkunde |
| Platzieren | frei |

### Rezept

```text
Holz  Holz         Holz
Holz  Stahlbarren  Holz
Holz  Holz         Holz
```

Ein Holzblock wird an der Werkbank in vier Übungsbauteile umgewandelt.

## Moreblocks-Kreissäge

Die Kreissäge wird nur eingebunden, wenn Moreblocks installiert ist.

| Handlung | Voraussetzung |
| --- | --- |
| Herstellen | Handwerk: Lehrling |
| Benutzen und Inventar bedienen | Handwerk: Lehrling und Werkzeugkunde |
| Platzieren | frei |

Die Kreissäge ersetzt die Holzwerkbank nicht. Treppen und Platten bleiben
ohne Berufsausbildung herstellbar.

## Verwaltungsrechte

| Recht | Bedeutung |
| --- | --- |
| `professions_admin` | Darf Berufs-XP und Qualifikationen verwalten |

Das Recht wird im Einzelspielermodus und an Serveradministratoren automatisch
vergeben.

## Befehle

| Befehl | Berechtigung | Wirkung |
| --- | --- | --- |
| `/professions_status` | alle | Eigenen Handwerksstand anzeigen |
| `/professions_status <spieler>` | `professions_admin` | Handwerksstand eines Onlinespielers anzeigen |
| `/professions_set_xp <spieler> <xp>` | `professions_admin` | Handwerks-XP eines Onlinespielers setzen |
| `/professions_qualification grant <spieler> tool_knowledge` | `professions_admin` | Werkzeugkunde vergeben |
| `/professions_qualification revoke <spieler> tool_knowledge` | `professions_admin` | Werkzeugkunde entziehen |

Der Zielspieler muss bei administrativen Änderungen online sein.

## Technische Zuordnung

Die folgenden Bezeichnungen sind für Konfiguration, Fehlersuche und
Anbindungen anderer Mods relevant.

### Zweige

| Anzeige | Technische ID |
| --- | --- |
| Handwerk | `crafting` |
| Bauwesen | `construction` |
| Bergbau | `mining` |
| Landwirtschaft | `farming` |
| Forstwirtschaft | `forestry` |

### Ränge und Qualifikation

| Anzeige | Technische ID |
| --- | --- |
| Pfuscher | `novice` |
| Lehrling | `apprentice` |
| Geselle | `journeyman` |
| Werkzeugkunde | `tool_knowledge` |

### Gegenstände und Geräte

| Anzeige | Technischer Name |
| --- | --- |
| Holzwerkbank | `professions:woodworking_bench` |
| Übungsbauteil | `professions:practice_part` |
| Moreblocks-Kreissäge | `moreblocks:circular_saw` |

### Handwerksaktivitäten

| Aktivität | Technische ID |
| --- | --- |
| Holzbretter herstellen | `crafting.craft.planks` |
| Stöcke herstellen | `crafting.craft.sticks` |
| Fackeln herstellen | `crafting.craft.torches` |
| Holzwerkzeug herstellen | `crafting.craft.wood_tool` |
| Truhe herstellen | `crafting.craft.chest` |

### Fähigkeitsprüfungen

| Prüfung | Technische ID |
| --- | --- |
| Holzwerkbank herstellen | `woodworking_bench.craft` |
| Holzwerkbank benutzen | `woodworking_bench.use` |
| Kreissäge herstellen | `moreblocks.circular_saw.craft` |
| Kreissäge benutzen | `moreblocks.circular_saw.use` |

## Installation und Abhängigkeiten

| Eigenschaft | Einstellung |
| --- | --- |
| Modname | `professions` |
| Mindestversion | Luanti 5.4 |
| Erforderliche Abhängigkeit | `default` |
| Optionale Abhängigkeit | `moreblocks` |
| Ausgangssprache | Englisch |
| Vorhandene Übersetzung | Deutsch |
