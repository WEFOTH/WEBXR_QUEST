# Rhino → WebXR (Meta Quest)

Meta-Quest-Variante des Projekts [WEBXR_TEST](https://github.com/WEFOTH/WEBXR_TEST): Rhino-3D-Modelle (.glb/.gltf) im **Passthrough-Mixed-Reality** der Quest platzieren — im Quest-Browser, ohne App-Installation.

**Live-Demo:** https://wefoth.github.io/WEBXR_QUEST/src/index.html
**QR-Code:** https://wefoth.github.io/WEBXR_QUEST/qr-codes/qrcode.html

> **Beziehung zum Hauptprojekt:** Dieses Repo ist ein Ableger mit gemeinsamer Git-Historie. Das Smartphone-Repo WEBXR_TEST ist als `upstream` eingetragen — gemeinsame Verbesserungen entstehen dort und werden hier per `git fetch upstream && git merge upstream/main` übernommen. Quest-spezifische Features leben nur in diesem Repo.

## Funktionen (zusätzlich zum Hauptprojekt)

Alles aus WEBXR_TEST (Modell laden, Hit-Test-Platzierung, Verankerung per WebXR Anchors, Auto-Ausrichtung zum Betrachter, Auswahl, Ansicht/Skalierung/Drehung pro Objekt) **plus:**

- **Ebenen-Snap (Stufe 2):** Platzierungspunkte rasten auf erkannte horizontale Ebenen aus dem Quest Space Setup ein (innerhalb 12 cm und der Ebenen-Umrandung) — eliminiert Höhenfehler, Objekte stehen exakt auf Boden/Tisch
- **Persistente Anker (Stufe 3):** platzierte Objekte werden per `requestPersistentHandle()` dauerhaft gespeichert (Handles + Objekt-Einstellungen im `localStorage`) und beim nächsten AR-Start **an derselben Stelle im Raum wiederhergestellt** — auch nach Headset-Neustart
- Button **„Gespeicherte Anker löschen"** auf der Startseite
- **Controller-Bedienung:** Der Select-Mechanismus des Hauptprojekts wird auf der Quest automatisch zum Controller-Ray — auf Objekt zeigen + Trigger = auswählen, ins Leere zeigen + Trigger = am Ring platzieren. Handtracking (Pinch) funktioniert genauso.

## Bedienung auf der Quest

1. **Einmalig:** Space Setup / Raumeinrichtung der Quest durchführen (liefert die Ebenen für Snap und stabilere Anker)
2. Quest-Browser öffnen → Live-URL eingeben oder QR-Code mit der Headset-Kamera scannen
3. Modell laden („Testmodell laden" oder eigenes .glb über „Rhino-Modell laden")
4. „START AR" → Passthrough startet
5. Controller auf eine Fläche richten, Trigger = platzieren; auf ein Objekt zeigen, Trigger = auswählen
6. **Wiederherstellung testen:** Session beenden, Browser schließen → Seite erneut öffnen, gleiches Modell laden, AR starten → Objekte erscheinen an ihren gespeicherten Positionen

## Wichtige Einschränkungen

- **Kein dom-overlay im Quest-Browser:** Die HTML-Bedienleiste (Ansicht/Skalieren/Drehen) ist **während** der AR-Session im Headset unsichtbar. Vor dem Start gewählte Einstellungen gelten für neue Platzierungen. Abhilfe (geplant): In-Headset-Menü aus three.js-Objekten — siehe [PROJEKTSTAND.md](PROJEKTSTAND.md)
- **Wiederhergestellte Objekte nutzen das aktuell geladene Modell:** vor dem AR-Start dasselbe GLB laden wie beim Platzieren, sonst stehen die Anker richtig, zeigen aber ein anderes Modell
- **Hardware:** Ebenen-Snap und Depth-basierter Hit-Test wirken am besten auf Quest 3/3S; Quest 2 hat Schwarz-Weiß-Passthrough

## Projektstruktur

Identisch zu WEBXR_TEST (`src/index.html`, `src/app.js`, `src/styles.css`, `assets/`, `qr-codes/`). Quest-spezifischer Code liegt gesammelt in `src/app.js`:

- `snapPointToDetectedPlane()` — Ebenen-Snap für Ring und Platzierung
- Abschnitt „Persistente Anker" — `localStorage`-Verwaltung, `persistAnchor()`, `restorePersistedAnchors()`, `spawnPlacedFromEntry()`

## Entwicklung & Workflow

```powershell
git clone https://github.com/WEFOTH/WEBXR_QUEST.git
cd WEBXR_QUEST
git remote add upstream https://github.com/WEFOTH/WEBXR_TEST.git

# Verbesserungen aus dem Hauptprojekt übernehmen:
git fetch upstream
git merge upstream/main
git push
```

Lokaler Server, Deployment und Stolpersteine: wie im Hauptprojekt — siehe [SETUP.md](SETUP.md) und [DEPLOYMENT.md](DEPLOYMENT.md). AR-Tests finden praktisch immer über die Live-URL im Headset statt (WebXR braucht HTTPS).

## Dokumentation

| Datei | Inhalt |
|-------|--------|
| [PROJEKTSTAND.md](PROJEKTSTAND.md) | Aktueller Stand, Roadmap (In-Headset-Menü u. a.) |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Technik: Quest-Besonderheiten + Verweis auf Upstream-Doku |
| [PROJECT_SPEC.md](PROJECT_SPEC.md) | Anforderungen der Quest-Variante |
| [SETUP.md](SETUP.md) | Lokale Entwicklung & Upstream-Workflow |
| [DEPLOYMENT.md](DEPLOYMENT.md) | GitHub-Pages-Deployment |

---

**Entwickler:** Florian Weininger · OTH Regensburg
*Stand: 07.07.2026*
