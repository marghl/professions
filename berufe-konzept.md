# Berufe im Spiel

## Grundidee

Berufe sollen die Zusammenarbeit zwischen Spielern foerdern. Ein Beruf und der
jeweilige Ausbildungsstand bestimmen, welche spezialisierten Handlungen ein
Spieler ausfuehren kann.

Die Berechtigungen sollen nicht nur das Platzieren einzelner Nodes betreffen.
Das System soll grundsaetzlich auf die gesamte Interaktion mit der Welt
erweiterbar sein. Dazu gehoeren insbesondere:

- Nodes platzieren, abbauen und benutzen
- bestimmte Gegenstaende und Maschinen verwenden
- bestimmte Rezepte craften
- weitere durch Mods bereitgestellte Interaktionen

## Grundfaehigkeiten ohne Ausbildung

Spieler ohne Ausbildung sollen weiterhin ein einfaches Vanilla-Survival spielen
koennen. Grundlegende Taetigkeiten duerfen deshalb keine Berufsausbildung
voraussetzen. Dazu zaehlen beispielsweise:

- farmen
- Baeume faellen
- Bretter herstellen
- weitere einfache Survival-Taetigkeiten

Diese Grundfaehigkeiten sollen dem Spieler die erforderlichen Punkte oder
Berechtigungen auch ohne Ausbildung geben.

## Spezialisierung und Fortschritt

Fortgeschrittene Inhalte werden ueber Beruf und Ausbildungsstand freigeschaltet.
Dabei soll nicht nur die Benutzung, sondern auch das Crafting entsprechender
Inhalte eingeschraenkt werden koennen.

Als grobe technische und spielerische Fortschrittslinie wurden genannt:

1. Vanilla-Survival ohne Ausbildung
2. spezialisierte Technik wie Technic
3. Transportmittel wie Minecart und Blimp
4. spaeter sehr fortgeschrittene Technik wie Jumpdrive

Die genaue Zuordnung dieser Inhalte zu Berufen und Ausbildungsstufen ist noch
nicht festgelegt.

## Technischer Ansatz

Diskutiert wurden zwei moegliche Modelle:

1. Berufe werden direkt als Luanti-Privilegien abgebildet. Vor einer Handlung
   wird geprueft, ob das zugehoerige Privileg vorhanden ist.
2. Eine eigene Mod verwaltet Berufe, Ausbildungsstaende, Punkte und Regeln in
   einer eigenen Datenhaltung und setzt die daraus folgenden Berechtigungen bei
   Weltinteraktionen und Crafting durch.

Fuer ein umfassendes Policy-System erscheint eine eigene Mod flexibler als eine
reine Sammlung von Privilegien. Sie kann trotzdem Luanti-Privilegien als
Integrationspunkt oder sichtbare Berechtigungen verwenden.

## Balancing

Das Balancing ist der schwierige Teil des Vorhabens. Das System darf neue
Spieler nicht bereits bei einfachen Survival-Handlungen blockieren, soll aber
bei fortgeschrittenen Inhalten echte Spezialisierung und Zusammenarbeit
erzeugen.

Noch offen sind insbesondere:

- konkrete Berufe und ihre Zustaendigkeiten
- Ausbildungsstufen und deren Voraussetzungen
- Punktevergabe und Lernfortschritt
- Zuordnung von Nodes, Werkzeugen, Maschinen und Rezepten
- Verhalten bei fehlender Berechtigung
- Wechsel, Kombination und Weitergabe von Berufen
- Regeln fuer Gruppen, Vertretung und Zusammenarbeit
- Administrations- und Ausnahmeberechtigungen

## Aufwand

Fuer ein umfassendes System mit Interaktionskontrolle, Crafting-Regeln,
Ausbildungsstufen, Datenhaltung, Administration, Mod-Integration, Balancing und
Tests wurde grob ein Aufwand von etwa 120 Stunden diskutiert. Bei ungefaehr drei
Stunden Arbeit pro Tag waere das ein mehrwoechiges Projekt und sollte deshalb in
kleinen, spielbaren Ausbaustufen umgesetzt werden.
