# Projektstand WEBXR_QUEST

*Stand: 07.07.2026*

## Zusammenfassung

Die Quest-Variante wurde am 07.07.2026 aus [WEBXR_TEST](https://github.com/WEFOTH/WEBXR_TEST) ausgegliedert und ist live deployt. Die drei Stufen der Robustheits-Roadmap für „Objekt sehr gut platzieren und fixieren" sind umgesetzt: Anker (Stufe 1, aus dem Upstream übernommen), Ebenen-Snap (Stufe 2) und persistente Anker (Stufe 3). **Noch nicht im Headset getestet** — die Implementierung basiert auf den dokumentierten Quest-Browser-APIs.

**Live:** https://wefoth.github.io/WEBXR_QUEST/src/index.html

## Erledigte Meilensteine

| Datum | Meilenstein |
|-------|-------------|
| 07.07.2026 | Repo aus WEBXR_TEST ausgegliedert (gemeinsame Historie, `upstream`-Remote); eigene Pages-URL + eigener QR-Code; Texte auf Quest angepasst |
| 07.07.2026 | Stufe 1 per Upstream-Merge: WebXR Anchors — Objekte driften nicht bei Tracking-Korrekturen |
| 07.07.2026 | **Stufe 2 — Ebenen-Snap:** `plane-detection` angefordert; Ring/Platzierung rasten auf horizontale Ebenen des Space Setup ein (±12 cm, innerhalb der Ebenen-Umrandung); Anker-Offset konserviert die gesnappte Position |
| 07.07.2026 | **Stufe 3 — Persistente Anker:** `requestPersistentHandle()` + `localStorage` (Handle, Ansicht, Skalierung, Drehung je Objekt); Wiederherstellung beim Session-Start; „Gespeicherte Anker löschen"-Button |

## Quest-spezifische Erkenntnisse (recherchiert 07.07.2026)

- Quest-Browser unterstützt `immersive-ar` (Passthrough), Hit-Test (ab Browser 40.4 über die Depth-API, ohne vorherigen Scan) und Anchors inkl. Persistenz
- **Kein dom-overlay** auf physischen Quest-Geräten → HTML-UI ist in der Session unsichtbar
- Der `select`-Mechanismus (Controller 0) des Hauptprojekts funktioniert unverändert mit Controller-Ray und Hand-Pinch

## Nächste Schritte (Priorität)

1. [ ] **Test im Headset:** kompletter Durchlauf (Platzieren → Snap prüfen → Session-Neustart → Wiederherstellung). Fehler zeigt das Seiten-Panel
2. [ ] **In-Headset-Menü:** 3D-Panel aus three.js-Objekten (am Controller/Handgelenk) für Ansicht/Skalieren/Drehen/Löschen während der Session — wichtigste Lücke, da dom-overlay fehlt
3. [ ] Objekt löschen (einzeln) inkl. zugehörigen persistenten Anker entfernen
4. [ ] Modell-Persistenz: geladenes GLB in IndexedDB puffern, damit die Wiederherstellung nicht vom manuellen Neuladen desselben Modells abhängt
5. [ ] Optional: vertikale Ebenen (Wände) für Snap zulassen, wenn Wandmontage-Szenarien relevant werden

## Bekannte Einschränkungen

- Wiederhergestellte Objekte verwenden das aktuell geladene Modell (siehe README)
- Ebenen-Snap setzt ein durchgeführtes Space Setup voraus; ohne Ebenen gilt das rohe Hit-Test-Ergebnis
- Persistente Anker sind gerätegebunden (Quest-intern); `localStorage` ist browserprofilgebunden
- Maximal 24 platzierte/wiederhergestellte Objekte (`maxPlacedObjects`)
