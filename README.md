# Berufe – Minimaltest

Alle sichtbaren Texte sind übersetzbar. Englisch dient als Ausgangssprache;
eine vollständige deutsche Übersetzung liegt in `locale/professions.de.tr`.

Die menschenlesbare Systemübersicht `docs/professions.md` wird aus der
Konfiguration erzeugt:

```bash
lua scripts/generate_professions_doc.lua
lua scripts/generate_professions_doc.lua --check
```

Die erzeugte Datei wird nicht von Hand bearbeitet.

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

Alle fünf verwenden dieselben Ränge und XP-Schwellen.

## Fortschritt

| Rang | Handwerks-XP |
| --- | ---: |
| Pfuscher | 0 |
| Lehrling | 100 |
| Geselle | 300 |
| Meister | 700 |

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
/professions_set_xp <player> <branch> <xp>
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

## Forstwirtschaft

Woodcutting ist der einzige Weg, durch das Fällen eines Baums XP zu erhalten.
Ein abgeschlossener geeigneter Woodcutting-Prozess gibt 5
Forstwirtschafts-XP; manuelles Fällen gibt keine XP.

Wachstumsfähige Standardsetzlinge geben beim Pflanzen 5 XP. Moretrees-Setzlinge
benötigen den Forstwirtschaftsrang Lehrling. Ohne diesen Rang bleiben sie
ruhend und können später von einem Lehrling für 3 XP aktiviert werden. Die
Natürlich entstandene oder gewachsene Stämme von Moretrees-Bäumen dürfen erst
ab Forstwirtschaft–Lehrling abgebaut werden. Von Spielern platzierte
Moretrees-Stammblöcke bleiben für alle abbaubar. Die Technic-Kettensäge ist
noch nicht integriert.

## Farming Redo

Ist Farming Redo aktiviert, hängt das Anpflanzen von Kulturen vom Rang in
Landwirtschaft ab. Pfuscher bauen Grundkulturen an, Lehrlinge die regulären
Feld- und Gemüsekulturen, Gesellen Spezialkulturen und Meister Kaffee, Kakao
und Vanille. Nur die Ernte einer vollständig ausgewachsenen, selbst gesetzten
Kultur gibt Landwirtschafts-XP. Jede Kulturgruppe besitzt 1 Grund-XP. Der
zentrale Progressionsalgorithmus multipliziert diesen Wert für jede Stufe
Rangabstand erneut mit 0,5; die Mindestgutschrift beträgt 0,1 XP.
Landwirtschaftliche Automatisierung ist noch nicht integriert.
