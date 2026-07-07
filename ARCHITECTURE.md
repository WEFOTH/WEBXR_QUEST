# Architektur — Quest-Variante

*Stand: 07.07.2026*

Die Grundarchitektur (Szene, Modell-Pipeline, Platzierung, Auswahl, Ansichtsmodi, AR-Leiste, Anchors Stufe 1) ist identisch zum Hauptprojekt und dort dokumentiert: [WEBXR_TEST/ARCHITECTURE.md](https://github.com/WEFOTH/WEBXR_TEST/blob/main/ARCHITECTURE.md). Hier stehen nur die Quest-Besonderheiten.

## Session-Features

```js
optionalFeatures: ['hit-test', 'dom-overlay', 'anchors', 'plane-detection']
```

Alles optional — fehlt ein Feature, degradiert die App auf das Verhalten des Hauptprojekts. `dom-overlay` wird vom Quest-Browser nicht unterstützt (HTML-UI in der Session unsichtbar); der Eintrag bleibt, damit dieselbe Seite auch auf dem Handy funktioniert.

## Stufe 2: Ebenen-Snap (`snapPointToDetectedPlane`)

Pro Frame wird der Hit-Test-Punkt gegen `frame.detectedPlanes` geprüft (Ebenen liefert das Quest Space Setup):

1. nur Ebenen mit `orientation === 'horizontal'`
2. Punkt in den Ebenen-Raum transformieren (`plane.planeSpace`-Pose, Matrix-Inverse)
3. Snap nur, wenn der Punkt **±12 cm** über/unter der Ebene liegt **und** innerhalb der Bounding-Box des Ebenen-Polygons (+5 cm Toleranz)
4. lokale Höhe auf 0 setzen, zurücktransformieren → Ring (`reticle`) und Platzierungs-Grid zeigen die gesnappte Position

Die Platzierung übernimmt die Ring-Position. Weil der **Anker** aus dem *rohen* Hit-Test-Ergebnis erzeugt wird, speichert jedes Objekt einen `anchorOffset` (= gesnappte Position − rohe Hit-Position); die Anker-Nachführung in `animate()` addiert ihn pro Frame.

## Stufe 3: Persistente Anker

- **Speichern:** Nach `createAnchor()` → `anchor.requestPersistentHandle()`. Das Handle (UUID) plus Objekt-Einstellungen (`viewMode`, `scaleFactor`, `rotationDeg`, `baseYaw`, `anchorOffset`) landet als Eintrag im `localStorage` (Key `webxrQuestPersistedAnchors`). Slider-/Dropdown-Änderungen aktualisieren den Eintrag (`syncPersistedEntry`)
- **Wiederherstellen:** Bei `sessionstart` → `restorePersistedAnchors(session)`: für jeden Eintrag `session.restorePersistentAnchor(handle)`; `spawnPlacedFromEntry()` erzeugt einen Klon des aktuell geladenen Modells mit den gespeicherten Einstellungen. Der Klon startet unsichtbar und wird erst mit der ersten gültigen Anker-Pose eingeblendet (verhindert Aufblitzen bei 0/0/0)
- **Löschen:** Button „Gespeicherte Anker löschen" → `session.deletePersistentAnchor(handle)` (falls Session aktiv) + `localStorage` leeren

Grenzen: Handles sind gerätegebunden; `localStorage` ist browserprofilgebunden; das Modell selbst wird nicht persistiert (siehe PROJEKTSTAND, nächste Schritte).

## Eingabe auf der Quest

`renderer.xr.getController(0)` liefert auf der Quest den Controller-Ray (auf dem Handy den Bildschirm-Tap) — Auswahl per Zeigen+Trigger und Platzierung am Ring funktionieren daher ohne Quest-spezifischen Code. Handtracking löst dasselbe `select`-Event per Pinch aus.

## Bekannte Architektur-Lücke

Ohne dom-overlay gibt es in der Session **keine UI**. Geplant: In-Headset-Menü als three.js-Objekte (Panel am Controller/Handgelenk), das die Funktionen der HTML-Leiste übernimmt — inkl. Raycast-Buttons. Bis dahin: Einstellungen vor dem AR-Start wählen.
