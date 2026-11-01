# Berufe – Minimaltest

Alle sichtbaren Texte sind übersetzbar. Englisch dient als Ausgangssprache;
eine vollständige deutsche Übersetzung liegt in `locale/professions.de.tr`.

Erster vertikaler Test des geplanten Berufs- und Lernsystems für Luanti mit
Minetest Game. Die Mod verwaltet eigene Handwerks-XP, leitet daraus Ränge ab,
speichert die Qualifikation `tool_knowledge` und schützt Herstellung und
Benutzung einer einfachen Holzwerkbank.

## Aktivierung

Den Ordner als Mod `professions` installieren und für die gewünschte Testwelt
aktivieren:

```ini
load_mod_professions = true
```

Abhängigkeit: `default` aus Minetest Game. Moreblocks ist optional.

## Grundzweige

Das Kompetenzmodell enthält zunächst fünf Grundzweige:

- Handwerk (`crafting`)
- Bauwesen (`construction`)
- Bergbau (`mining`)
- Landwirtschaft (`farming`)
- Forstwirtschaft (`forestry`)

Alle fünf verwenden vorläufig dieselben Testränge und XP-Schwellen. Im
Minimaltest sammelt bisher ausschließlich Handwerk tatsächlich XP.

## Fortschritt

| Rang | Handwerks-XP |
| --- | ---: |
| Pfuscher | 0 |
| Lehrling | 100 |
| Geselle | 300 |

Handwerks-XP entstehen beim erfolgreichen Herstellen von Holzbrettern,
Stöcken, Fackeln, Holzwerkzeugen und Truhen. Häufige Wiederholungen desselben
Rezepts liefern innerhalb einer Stunde zunehmend weniger XP.

## Befehle

Eigenen Status anzeigen:

```text
/professions_status
```

Administratoren mit `professions_admin` können für den Test XP setzen und die
Qualifikation verwalten:

```text
/professions_set_xp <player> <xp>
/professions_qualification grant <player> tool_knowledge
/professions_qualification revoke <player> tool_knowledge
```

Der Zielspieler muss dabei online sein.

## Holzwerkbank

Das Rezept besteht aus acht Holzblöcken um einen Stahlbarren. Die Herstellung
setzt den Rang Lehrling voraus. Zur Benutzung werden zusätzlich
`tool_knowledge` und damit beide vorgesehenen Prüfarten benötigt.

Die Werkbank verarbeitet einen Holzblock zu vier Übungsbauteilen. Werkbank und
Bauteile dürfen unabhängig vom Rang platziert werden.

## Moreblocks-Kreissäge

Ist Moreblocks aktiviert, wird `moreblocks:circular_saw` automatisch
integriert. Die Kreissäge ersetzt die Holzwerkbank nicht; beide bleiben
verfügbar.

Für die Kreissäge gelten dieselben Bedingungen wie für die Holzwerkbank:

- Crafting: Handwerksrang Lehrling
- Benutzung: Handwerksrang Lehrling und Qualifikation `tool_knowledge`
- Platzieren: für alle erlaubt

Ohne Berechtigung können keine Materialien eingelegt, Einstellungen geändert
oder Erzeugnisse aus der Säge entnommen werden.
