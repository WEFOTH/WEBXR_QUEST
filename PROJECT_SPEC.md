# Projektspezifikation — Rhino → WebXR (Meta Quest)

*Stand: 07.07.2026*

## Zweck & Zielplattform

Rhino-Exporte (.glb/.gltf) im Passthrough-Mixed-Reality der Meta Quest **präzise platzieren und dauerhaft fixieren**.

- **Zielgerät:** Meta Quest 3 / 3S (Quest 2 eingeschränkt: S/W-Passthrough, kein Depth-Hit-Test)
- **Browser:** Meta Quest Browser (Horizon OS), WebXR `immersive-ar`
- **Basis:** Ableger von [WEBXR_ANDROID](https://github.com/WEFOTH/WEBXR_ANDROID) (Smartphone-Variante, dient als `upstream`)

## Anforderungen (umgesetzt)

Alle funktionalen Anforderungen des Hauptprojekts (siehe [WEBXR_ANDROID/PROJECT_SPEC.md](https://github.com/WEFOTH/WEBXR_ANDROID/blob/main/PROJECT_SPEC.md)), zusätzlich:

1. **Präzise Platzierung:** Einrasten auf erkannte horizontale Ebenen des Space Setup (±12 cm, innerhalb der Ebenen-Grenzen) — kein Schweben/Einsinken auf Boden und Tisch
2. **Dauerhafte Fixierung:** persistente Anker; platzierte Objekte erscheinen nach Browser-/Headset-Neustart wieder an derselben realen Position, inkl. gespeicherter Ansicht/Skalierung/Drehung
3. **Controller- und Handtracking-Bedienung:** Zeigen+Trigger bzw. Pinch für Auswahl und Platzierung
4. Verwaltung: gespeicherte Anker per Button löschbar

## Anforderungen (offen)

- **In-Headset-Menü** für Ansicht/Skalieren/Drehen/Löschen während der Session (der Quest-Browser unterstützt kein dom-overlay, die HTML-Leiste ist im Headset unsichtbar)
- Einzelobjekt-Löschung inkl. persistentem Anker
- Modell-Persistenz (GLB in IndexedDB), damit die Wiederherstellung ohne manuelles Neuladen desselben Modells auskommt

## Rahmenbedingungen

- Space Setup der Quest muss durchgeführt sein (Voraussetzung für Ebenen; ohne Ebenen greift der rohe Hit-Test)
- HTTPS zwingend (GitHub Pages), kein Build-Schritt, three.js 0.160 per CDN
- Persistenz ist geräte- und browserprofilgebunden; max. 24 Objekte


