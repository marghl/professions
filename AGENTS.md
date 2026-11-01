# Projektkontext: Berufssystem fuer Luanti/Minetest

## Arbeitsstatus

Das Berufssystem befindet sich weiterhin in einer fruehen Konzept- und
Testphase. Der Benutzer hat die Implementierung des unten beschriebenen ersten
Minimaltests ausdruecklich freigegeben; dieser ist als Mod-Grundgeruest im
Ordner vorhanden. Weitere Berufe, externe Integrationen oder produktive
Weltkonfigurationen duerfen ohne eine neue ausdrueckliche Anweisung noch nicht
implementiert beziehungsweise veraendert werden.

Die bisherige ausfuehrlichere Konzeptbeschreibung befindet sich in
`berufe-konzept.md` und ist zusammen mit diesem Dokument als verbindlicher
Projektkontext zu beruecksichtigen.

Alle technischen und internen Bezeichnungen werden auf Englisch gefuehrt.
Alle sichtbaren Texte verwenden `professions.S`. Englisch ist die
Ausgangssprache; deutsche Übersetzungen liegen unter `locale/`.
Die menschenlesbare Bestandsübersicht `docs/professions.md` wird mit
`lua scripts/generate_professions_doc.lua` aus der technischen Konfiguration
erzeugt und darf nicht von Hand gepflegt werden. Der Modus `--check` prueft,
ob die eingecheckte Datei aktuell ist.
Dies umfasst insbesondere Mod- und API-Namespace (`professions`), Metadaten,
Zweig-, Rang-, Qualifikations-, Faehigkeits- und Aktivitaets-IDs, Privilegien
sowie Chatbefehle und deren Parameter. Sichtbare Titel, Beschreibungen und
Spielermeldungen duerfen weiterhin Deutsch sein. Fuer die veralteten deutschen
IDs, Metadaten, Privilegien und Nodes gibt es ausdruecklich keine
Migrationspfade oder Aliase. Alte platzierte Nodes duerfen als `unknown`
erscheinen; alte Testdaten werden nicht uebernommen.

## Ziel

Berufe sollen die Zusammenarbeit und Arbeitsteilung zwischen Spielern
foerdern. Ein Beruf und der jeweilige Ausbildungsstand sollen bestimmen,
welche spezialisierten Handlungen ein Spieler ausfuehren kann. Das langfristige
System soll grundsaetzlich Regeln fuer folgende Bereiche ermoeglichen:

- Nodes platzieren, abbauen und benutzen
- Gegenstaende, Werkzeuge und Maschinen verwenden
- bestimmte Rezepte craften
- weitere durch Mods bereitgestellte Interaktionen

Spieler ohne Berufsausbildung muessen weiterhin ein einfaches
Vanilla-Survival spielen koennen. Insbesondere Farmen, Baeume faellen, Bretter
herstellen sowie weitere grundlegende Survival-Taetigkeiten duerfen keine
Ausbildung voraussetzen.

## Erster Beruf

Der erste Ausbau beginnt mit dem Beruf **Handwerker**. Er ist der erste
konkrete Beruf, aber ausdruecklich nicht die dauerhafte Systemgrenze. Spaeter
sollen weitere Berufe hinzukommen koennen, ohne die Architektur neu aufbauen
zu muessen.

Der Handwerker ist fuer fortgeschrittenes Crafting vorgesehen. Die genaue
Abgrenzung seiner Rezepte und sonstigen Berechtigungen wird noch geplant.
Treppen (`stairs`) und Platten (`slabs`) bleiben ausdruecklich auch ohne den
Beruf Handwerker craftbar und gehoeren damit zu den Grundfaehigkeiten. Mit dem
Beruf Handwerker wird zusaetzlich die Kreissaege (`moreblocks:circular_saw`) aus Moreblocks
verfuegbar. Die Saege und ihre erweiterten Form- und Zuschnittmoeglichkeiten
sind damit der erste konkret festgelegte berufsgebundene Inhalt. Sowohl das
Crafting als auch die Benutzung der Saege sind dem Handwerker vorbehalten.

Das Platzieren von Bloecken bleibt unabhaengig vom Beruf erlaubt. Dies gilt
auch fuer Bloecke und Formen, die zuvor mit der Moreblocks-Saege hergestellt
wurden. Ein Nicht-Handwerker darf solche fertigen Bauteile somit erhalten und
platzieren, aber die Saege weder craften noch benutzen.

Die genaue Zuordnung einzelner Nodes, Gegenstaende, Rezepte und Maschinen ist
noch nicht beschlossen. Ebenso offen sind Ausbildungsstufen, Voraussetzungen,
Punkte beziehungsweise Lernfortschritt, Berufswechsel, Mehrfachberufe,
Vertretungsregeln und Ausnahmen fuer Administratoren.

Als moegliche spaetere Entwicklungsrichtung ist ein offenes Lernmodell
(`learning by doing`) vorgesehen. Spieler koennten dabei durch passende
Taetigkeiten Erfahrung, Kenntnisse oder einzelne Faehigkeiten erwerben. Diese
Moeglichkeit muss bei Datenmodell und Rechtesystem von Anfang an offenbleiben,
auch wenn der erste Handwerker zunaechst per Chatbefehl vergeben wird.

## Verbindliches Fortschrittsmodell: Rang und Qualifikation

Das Berufssystem wird als Kombination aus **Taetigkeitszweigen**,
**spezialisierter XP**, **Raengen** und **Qualifikationen beziehungsweise
Lizenzen** geplant.

- Ein Taetigkeitszweig beschreibt ein Fachgebiet, zum Beispiel Handwerk.
- Passende Handlungen geben ausschliesslich XP fuer diesen Zweig.
- Der Rang ergibt sich aus der spezialisierten XP im jeweiligen Zweig.
- Der sichtbare Beruf kann als Rangbezeichnung innerhalb eines Zweigs
  verstanden werden, beispielsweise Lehrling, Geselle oder Meister im
  Handwerk.
- Qualifikationen oder Lizenzen werden getrennt vom Rang verwaltet. Sie weisen
  eine ausdruecklich absolvierte Ausbildung, Einweisung oder Pruefung nach.
- Eine konkrete Faehigkeit kann nur einen Rang, nur eine Lizenz oder eine
  Kombination aus beidem verlangen.

Beispiel fuer eine spaetere Regel:

```text
Faehigkeit erlaubt, wenn:
    Handwerksrang >= Lehrling
    UND erforderliche Lizenz vorhanden
```

Nicht jede Faehigkeit muss zwingend beide Bedingungen haben. Einfache
Fortschritte koennen allein durch Rang freigeschaltet werden. Sicherheitskritische
oder besonders maechtige Inhalte koennen zusaetzlich eine externe Ausbildung
und damit eine Lizenz verlangen.

Die externe Ausbildung vergibt demnach in erster Linie Qualifikationen oder
Lizenzen ueber die Chatbefehl-Schnittstelle. Learning by Doing steigert dagegen
die spezialisierte XP und damit den Rang. Externe Ausbildung darf bei Bedarf
auch einen definierten XP-Bonus oder Mindestrang verleihen; dies ist noch nicht
abschliessend entschieden.

Fuer die XP-Vergabe werden spaeter Schutzmechanismen gegen triviales Grinding
benoetigt, beispielsweise abnehmende Ertraege bei Wiederholungen, eine
Bewertung der Schwierigkeit beziehungsweise des Ressourcenwerts und Schutz vor
Platzieren-und-sofortigem-Abbauen-Schleifen.

## Verbindliches Spezialisierungsmodell: Soft Caps statt Verbote

Jeder Spieler darf grundsaetzlich jeden Taetigkeitszweig lernen. Es gibt keine
festen Klassen, keine dauerhaft ausgeschlossenen Zweige und keine technisch
erzwungene Obergrenze fuer die Anzahl erlernter Berufe oder Abschluesse.
Beschraenkung und Spezialisierung entstehen ausschliesslich durch den mit
zunehmendem Fortschritt stark wachsenden Aufwand.

Angestrebte praktische Verteilung pro Spieler:

- Alle Zweige sollen mit vertretbarem Aufwand bis mindestens **Pfuscher** oder
  **Lehrling** entwickelt werden koennen.
- In einzelnen ausgewaehlten Zweigen sollen ein oder mehrere
  **Gesellenbriefe** realistisch erreichbar sein.
- **Meister** soll eine starke Spezialisierung darstellen; praktisch werden
  fuer einen Spieler ungefaehr bis zu zwei Meisterzweige erwartet.
- **Ingenieur** ist die hoechste beziehungsweise aufwendigste Spezialisierung;
  praktisch wird hoechstens ein Ingenieurszweig pro Spieler erwartet.

Diese Zahlen sind ausdruecklich keine harten Limits. Ein Spieler darf auch
weitere Meister- oder Ingenieursraenge anstreben, wenn er den dafuer noetigen
sehr hohen Aufwand investiert. Das System soll dies nicht mit einer Meldung wie
"Maximum erreicht" verhindern.

Die Verlangsamung muss progressiv wirken. Dazu koennen zwei Kostenkurven
kombiniert werden:

1. Innerhalb eines Zweigs steigt die fuer jeden hoeheren Rang erforderliche XP
   ueberproportional.
2. Bereits erreichte hohe Abschluesse erhoehen den Aufwand fuer weitere hohe
   Abschluesse in anderen Zweigen.

Niedrige Grundkenntnisse in vielen Zweigen sollen von dieser
Spezialisierungsbremse kaum oder gar nicht betroffen sein. Der zusaetzliche
Aufwand soll vor allem ab Geselle, deutlich bei Meister und sehr stark bei
Ingenieur einsetzen. Die genauen Kurven, Multiplikatoren und die Frage, ob nur
XP-Anforderungen steigen oder zugleich XP-Ertraege sinken, sind noch zu
planen.

Rang und formaler Abschluss bleiben unterscheidbar: Praktische Zweig-XP kann
den erforderlichen Erfahrungsstand liefern; Gesellenbrief, Meisterbrief oder
eine Ingenieursqualifikation koennen zusaetzlich eine externe Pruefung oder
Lizenz darstellen. Auch hierbei sollen fehlende Abschluesse einen Weg
erschweren beziehungsweise bestimmte Fachhandlungen sperren, aber nicht das
Lernen anderer Zweige verhindern.

## Abhaengige und tiefer beginnende Taetigkeitszweige

Nicht jeder Taetigkeitszweig beginnt an der Wurzel oder ist fuer neue Spieler
sofort aktiv. Fortgeschrittene, spezialisierte oder fachuebergreifende Zweige
duerfen tiefer im Kompetenzmodell beginnen und Abhaengigkeiten von anderen
Zweigen, Raengen und Qualifikationen besitzen.

Das Modell ist deshalb streng genommen kein einfacher Baum, sondern ein
gerichtetes, zyklenfreies Kompetenznetz. Ein Zweig kann mehrere Vorgaenger
haben. Seine Freischaltbedingung kann insbesondere enthalten:

- einen Mindestrang in einem oder mehreren anderen Zweigen,
- einen formalen Abschluss wie Gesellen- oder Meisterbrief,
- eine bestimmte Qualifikation oder Lizenz,
- bei Bedarf eine Kombination dieser Bedingungen.

Beispiel:

```text
Bergbaumeister-Zweig wird freigeschaltet, wenn:
    Bauwesen >= Meister
    UND Bergbau >= Geselle
    UND Qualifikation "Untertagebau" vorhanden
```

Das Erfuellen der Voraussetzungen verleiht nicht automatisch den Rang im neuen
Zweig. Es oeffnet den Zweig lediglich. Der Spieler beginnt dort anschliessend
mit eigener spezialisierter XP und eigener Rangentwicklung. Dadurch kann ein
tiefer Zweig weitere Unterzweige und Faehigkeiten freischalten, zum Beispiel
Minenplanung sowie Minecart-, Foerder- und Liftsysteme.

Abhaengigkeiten duerfen als UND- oder gezielt als ODER-Regeln formuliert
werden. Die Datenstruktur muss Zyklen verhindern oder beim Laden eindeutig
erkennen und ablehnen. Konkrete Faehigkeiten bleiben getrennt vom Zweiggraphen:
Der Graph regelt, welche Lernwege offen sind; Faehigkeitsregeln bestimmen,
welche Handlungen durch Rang und Lizenz erlaubt werden.

## Konfigurierbares Kompetenznetz

Taetigkeitszweige, Raenge, XP-Schwellen, Abhaengigkeiten, Qualifikationen,
Faehigkeitsregeln und XP-Quellen sollen nicht fest im Kern verdrahtet werden.
Der Kern stellt Registrierung, Validierung, Speicherung, Fortschrittslogik und
Rechtepruefung bereit; der konkrete Kompetenzgraph wird ueber Konfiguration
aufgebaut.

Als primaeres Konfigurationsformat ist eine deklarative Lua-Konfiguration
vorgesehen. Die Dateien werden ausschliesslich von vertrauenswuerdigen
Administratoren und Entwicklern bearbeitet, im Wesentlichen vom Projektinhaber
selbst; gelegentliche GitHub-Contributions sind moeglich. Ausfuehrbarer Lua-Code
in diesen Dateien ist deshalb innerhalb des festgelegten Vertrauensmodells kein
entscheidender Nachteil.

Die deklarative Form soll eine kleine, gut lesbare Definitions-API anbieten,
zum Beispiel sinngemaess:

```lua
branch {
    id = "mine_construction_master",
    prerequisites = all {
        rank("construction", "master"),
        rank("mining", "journeyman"),
        qualification("underground_construction"),
    },
}
```

Konfiguration und ausfuehrende Integrationslogik bleiben getrennt. Eine
Konfiguration darf nur auf registrierte Ereignis- beziehungsweise
Taetigkeitstypen verweisen. Adapter fuer Moreblocks, Minecarts, Lifte oder
andere Mods registrieren die technisch messbaren Aktivitaeten und
durchsetzbaren Faehigkeiten.

Alle Definitionen muessen beim Serverstart streng validiert werden. Dazu
gehoeren mindestens eindeutige und stabile IDs, vorhandene Referenzen,
gueltige XP-Werte, bekannte Taetigkeitstypen, erreichbare Voraussetzungen und
ein zyklenfreier Abhaengigkeitsgraph. Fehler sollen den betroffenen Eintrag und
die Quelldatei klar benennen. Das Format soll ausserdem kleine, nachvollziehbare
Git-Diffs und Reviews von Contributions ermoeglichen.

## Verbindliche Architekturentscheidung: eigene spezialisierte XP

Die XP der Taetigkeitszweige werden innerhalb des Berufssystems verwaltet und
gespeichert. Eine externe XP-Mod oder XP-Bibliothek ist nicht die Datenquelle
fuer Zweigfortschritt, Raenge oder Soft Caps.

Das bereits vorhandene `xp_redo` verwaltet einen allgemeinen, globalen
XP-Wert. Es kann unabhaengig weiter fuer den allgemeinen Serverfortschritt und
globale Raenge verwendet werden, bleibt aber technisch und semantisch vom
Berufssystem getrennt. Berufs-XP wird weder aus `xp_redo` abgeleitet noch dort
gespeichert.

Das Berufssystem stellt eine zentrale API bereit, ueber die erfolgreiche
Taetigkeiten gemeldet werden, sinngemaess beispielsweise:

```lua
professions.record_activity(playername, "crafting.circular_saw_output", {
    item = "moreblocks:stair_stone",
    count = 4,
    source = "moreblocks:circular_saw",
})
```

Die meldende Integration liefert nur ein bestaetigtes Ereignis und dessen
Kontext. Sie berechnet und speichert keine XP. Der Kern ordnet die Taetigkeit
anhand der deklarativen Konfiguration einem oder mehreren Zweigen zu, prueft
Missbrauchs- und Wiederholungsregeln, wendet Schwierigkeits- und
Spezialisierungsfaktoren an und schreibt erst danach die endgueltige XP gut.

Grundlegende Luanti-Ereignisse werden durch einen Kernadapter erfasst.
Mod-spezifische Aktivitaeten werden durch kleine Adapter bereitgestellt, zum
Beispiel fuer Moreblocks-Saege, Minecarts, Lifte oder Technic. Neue Adapter
registrieren stabile Aktivitaets-IDs und gegebenenfalls Kontextfelder; die
konkrete XP-Zuordnung bleibt konfigurierbar.

XP soll fuer ein erfolgreich abgeschlossenes und serverseitig bestaetigtes
Ergebnis vergeben werden, nicht bloss fuer einen Klick oder Versuch. Beispiele:

- Crafting: nach einem tatsaechlich erfolgreichen Craft
- Moreblocks-Saege: beim tatsaechlichen Entnehmen hergestellter Formen
- Bergbau: nach erfolgreichem Abbau eines geeigneten Nodes
- Minecart: nach einer abgeschlossenen, sinnvoll messbaren Transportleistung
- Maschinen: nach einem abgeschlossenen Produktionsvorgang

Die spaetere Berechnung folgt konzeptionell diesem Schema:

```text
endgueltige XP = Grundwert
               * Schwierigkeitsfaktor
               * Wiederholungsfaktor
               * Spezialisierungsfaktor
               * Kontextfaktor
```

Intern sollen XP und Faktoren deterministisch ohne problematische
Fliesskomma-Rundungsfehler verarbeitet werden, vorzugsweise mit skalierten
Ganzzahlen. Die genaue Skalierung ist noch festzulegen.

Fuer den Anti-Grinding-Zustand benoetigt das System zeitlich begrenzte Zaehler
pro Spieler und Aktivitaetsklasse. Identische triviale Wiederholungen sollen
zunehmend weniger XP ergeben. Unterschiedliche Materialien, Schwierigkeitsgrade
oder echte komplexere Leistungen duerfen davon getrennt bewertet werden. Die
exakten Fenster, Schluessel und Ertragskurven bleiben Teil des spaeteren
Balancings.

## Verbindliches Minimalsetup fuer den ersten Test

Der erste vollstaendige Test verwendet nur das Berufssystem und Minetest Game.
Moreblocks, Minecarts, Lifte, Technic und andere zusaetzliche Mods werden fuer
diesen Test nicht benoetigt. Das Szenario bildet bewusst nur einen kleinen
vertikalen Durchstich durch XP, Rang, Qualifikation und Rechtepruefung ab.

### Grundzweige und Raenge

Das System registriert die fünf Grundzweige `crafting`, `construction`,
`mining`, `farming` und `forestry`. Im Minimaltest besitzt bisher nur
`crafting` konkrete XP-Quellen und Berechtigungsregeln. Alle fünf Zweige
verwenden vorläufig folgende Raenge:

| Rang | XP-Schwelle |
| --- | ---: |
| Pfuscher | 0 |
| Lehrling | 100 |
| Geselle | 300 |

Diese Werte dienen ausschliesslich dem schnellen Test und sind kein
endgueltiges Balancing. Meister, Ingenieur, kombinierte Zweige und die
zweiguebergreifenden Soft Caps werden erst in spaeteren Ausbaustufen getestet.

### Vorlaeufige XP-Quellen

Einige einfache Standardrezepte liefern Handwerks-XP:

| Erfolgreiche Taetigkeit | Grund-XP |
| --- | ---: |
| Holzbretter herstellen | 1 |
| Stoecke herstellen | 1 |
| Fackeln herstellen | 2 |
| Holzwerkzeug herstellen | 5 |
| Truhe herstellen | 10 |

XP wird erst nach einem tatsaechlich erfolgreichen Craft gutgeschrieben. Die
Wiederholungszaehler werden pro Rezept beziehungsweise sinnvoll definierter
Aktivitaetsklasse getrennt gefuehrt. Erste Herstellungen erhalten den vollen
Wert; haeufige identische Wiederholungen bringen zunehmend weniger XP. Nach
einem noch festzulegenden Zeitfenster kann sich der Ertrag erholen.

### Testqualifikation

Die erste Qualifikation hat die interne ID `tool_knowledge`. Sie wird im Minimalsetup nur
durch einen administrativen Chatbefehl vergeben. Eine externe Ausbildung oder
Quest-Mod wird fuer diesen Test nicht benoetigt.

### Uebungswerkbank und Testrechte

Das Berufssystem darf fuer dieses Minimalsetup eine einfache
`Uebungswerkbank` als eigenes Testobjekt bereitstellen. Sie ist keine externe
Mod-Abhaengigkeit, sondern ein bewusst kleiner Testadapter beziehungsweise
Testinhalt des Projekts.

Es gelten folgende Regeln:

```text
Uebungswerkbank craften:
    Handwerksrang >= Lehrling

Uebungswerkbank benutzen:
    Handwerksrang >= Lehrling
    UND Qualifikation "tool_knowledge"
```

Das Platzieren der Uebungswerkbank sowie der mit ihr hergestellten
Testbauteile bleibt fuer alle Spieler erlaubt. Ein Nicht-Handwerker darf eine
erhaltene Werkbank oder fertige Bauteile besitzen, handeln und platzieren, die
Werkbank aber ohne erfuellte Bedingungen nicht benutzen.

Vorlaeufige visuelle Gestaltung der Uebungswerkbank: ein glatter weisser Block
mit der gut lesbaren Aufschrift **Holzwerkbank**. Dies ist bewusst nur eine
einfache Testdarstellung und kein endgueltiges Modell oder Texturdesign.

### Abnahmekriterien des Minimalsetups

Der erste Test gilt als vollstaendiger Durchstich, wenn nachgewiesen ist:

1. Erfolgreiche konfigurierte Taetigkeiten werden erkannt.
2. Handwerks-XP wird persistent gutgeschrieben.
3. Wiederholte triviale Taetigkeiten verlieren an XP-Wert.
4. Der Rang Lehrling wird aus der erreichten XP korrekt abgeleitet.
5. `tool_knowledge` kann per Admin-Chatbefehl vergeben und entzogen werden.
6. Das Crafting der Uebungswerkbank wird anhand des Rangs entschieden.
7. Ihre Benutzung wird anhand von Rang und Qualifikation entschieden.
8. Das Platzieren von Werkbank und Testbauteilen bleibt davon unabhaengig.
9. Fortschritt und Qualifikation bleiben nach Abmelden und Serverneustart
   erhalten.

Die Moreblocks-Kreissaege ist als erste optionale Integration einer externen
Mod umgesetzt. Sie ersetzt die Uebungswerkbank nicht. Fuer beide gelten im
Minimaltest dieselben Bedingungen: Crafting ab Handwerksrang Lehrling;
Benutzung ab Lehrling und mit Qualifikation `tool_knowledge`. Das Platzieren
bleibt fuer alle Spieler erlaubt.

## Architekturentscheidung: Ausbildung ist extern

Die Ausbildung wird ausserhalb des Berufssystems geloest. Das Berufssystem
kennt und steuert den konkreten Ausbildungsablauf nicht. `epic` darf als ein
moegliches Beispiel fuer eine externe Ausbildungsloesung genannt werden, ist
aber weder festgelegt noch eine Abhaengigkeit des Berufssystems.

Nach erfolgreichem Abschluss einer extern organisierten Ausbildung wird der
Beruf ueber einen Chatbefehl vergeben. Die spaetere Berufssystem-Mod muss
deshalb einen geeigneten administrativen Chatbefehl zur Berufsvergabe
bereitstellen. Eine externe Loesung kann diesen Befehl aufrufen; Vergabe und
Speicherung bleiben beim Berufssystem.

Beabsichtigter Ablauf:

1. Ein Spieler durchlaeuft eine extern organisierte Ausbildung.
2. Das externe System prueft und steuert die Ausbildungsaufgaben.
3. Am erfolgreichen Ende wird der Chatbefehl zur Berufsvergabe ausgefuehrt.
4. Das Berufssystem validiert den Befehl, speichert den Beruf und setzt die
   daraus folgenden Berechtigungen um.

Diese Trennung wurde bewusst fuer maximale Flexibilitaet gewaehlt: Inhalt und
Ablauf der Ausbildung liegen ausserhalb; Berufszustand und
Berechtigungsregeln liegen im Berufssystem.

## Vergabe von Berufen

Berufe werden vorerst ausschliesslich per Chatbefehl vergeben. Der Befehl kann
manuell von einem berechtigten Administrator oder automatisiert durch ein
externes Ausbildungssystem ausgefuehrt werden. Ein `epic:commandblock` ist ein
moegliches Beispiel fuer einen solchen externen Aufruf.

Der konkrete Befehlsname, seine Parameter, erforderliche Privilegien,
Fehlermeldungen und das Verhalten bei einem bereits vorhandenen Beruf sind noch
nicht festgelegt. Bei der spaeteren Planung ist zu beachten, dass ein
Commandblock den Befehl sicher im richtigen Berechtigungskontext und fuer den
richtigen Spieler ausfuehren koennen muss.

## Einordnung untersuchter Quest-Mods

Neben Epic wurden folgende Alternativen betrachtet:

- `missions`: archivierter Vorgaenger von Epic; fuer ein neues System nicht
  geeignet.
- TeTpaAkas `quests`/Quest Framework: alter programmierbarer Unterbau mit
  Questlog und Fortschrittsverwaltung, aber technisch veraltet und ohne
  zeitgemaesse Erstellung im Spiel.
- `tasks`/Tasks Framework: minimalistischer Unterbau ohne eigene Oberflaeche;
  laut Projekt noch in frueher Entwicklung und fuer Produktivserver riskant.
- MineRPG: fertiges und stark vorgegebenes RPG-System mit automatisch
  generierten NPC-Aufgaben, Wirtschaft und Charakterwerten; fuer gezielte
  Berufsausbildungen nicht passend.

Epic ist nur ein moegliches Beispiel fuer die externe Ausbildung. Es kann
Ausbildungsablaeufe direkt im Spiel, ohne fest kodierte Lua-Questlogik, mit
Bedingungen, Verzweigungen, Wegpunkten, Nachrichten, Befehlen und weiteren
Aktionen erstellen. Daraus folgt keine technische Abhaengigkeit.

## Technische Richtung des spaeteren Berufssystems

Diskutiert wurden reine Luanti-Privilegien und eine eigene zentrale Mod. Fuer
die umfassenden Regeln ist eine eigene Mod vorgesehen, weil sie Berufe,
Ausbildungsstaende, Datenhaltung und Interaktionsregeln flexibler verwalten
kann. Luanti-Privilegien koennen trotzdem als Integrationspunkt oder sichtbare
Berechtigungen verwendet werden.

Das interne Rechtemodell darf nicht dauerhaft auf genau ein Privileg pro Beruf
reduziert werden. Es muss mehrere Taetigkeitszweige, spezialisierte XP, daraus
abgeleitete Raenge und getrennt vergebene Qualifikationen beziehungsweise
Lizenzen abbilden. Die Durchsetzung fragt eine konkrete Faehigkeit ab
(beispielsweise Saege craften oder Saege benutzen); deren Regel wertet den
erforderlichen Rang und gegebenenfalls eine Lizenz aus. Luanti-Privilegien
koennen fuer Verwaltung oder Integration gespiegelt werden, sollen aber nicht
die alleinige Datenquelle sein.

Die grobe Fortschrittslinie lautet:

1. Vanilla-Survival ohne Ausbildung
2. spezialisierte Technik wie Technic
3. Transportmittel wie Minecart und Blimp
4. sehr fortgeschrittene Technik wie Jumpdrive

Das Balancing und die konkreten Regeln sind noch offen. Neue Spieler duerfen
nicht bei grundlegenden Survival-Handlungen blockiert werden; fortgeschrittene
Inhalte sollen dagegen echte Spezialisierung und Zusammenarbeit erzeugen.

## Planungsgrundsatz fuer spaetere Arbeiten

Bei allen weiteren Vorschlaegen ist die Trennung zwischen Ausbildung und
Berufsberechtigung beizubehalten:

- Ein externes System definiert und steuert die Ausbildung; Epic ist nur ein
  moegliches Beispiel.
- Der Chatbefehl ist die klar definierte Schnittstelle.
- Das Berufssystem ist fuer Vergabe, Speicherung und Durchsetzung zustaendig.
- Ausbildungsinhalte duerfen nicht unnoetig in der Berufssystem-Mod fest
  verdrahtet werden.

Vor einer Implementierung muessen mindestens Befehls-API, Datenmodell,
Regeln fuer mehrere parallele Taetigkeitszweige, XP-Quellen und Grinding-Schutz,
Rangschwellen, Lizenzvergabe sowie die erste konkrete Berechtigungsmatrix
beschlossen werden.
