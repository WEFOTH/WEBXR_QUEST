# Setup & Entwicklung — Quest-Variante

*Stand: 07.07.2026*

## Klonen und Remotes einrichten

```powershell
git clone https://github.com/WEFOTH/WEBXR_QUEST.git
cd WEBXR_QUEST
git remote add upstream https://github.com/WEFOTH/WEBXR_ANDROID.git
```

- `origin` → dieses Repo (hierhin pushen)
- `upstream` → Hauptprojekt WEBXR_ANDROID (von dort gemeinsame Verbesserungen holen)

## Upstream-Workflow

Gemeinsame Features (alles, was Handy **und** Quest betrifft) werden im Hauptprojekt entwickelt und hier übernommen:

```powershell
git fetch upstream
git merge upstream/main
git push
```

Die Repos teilen ihre Git-Historie, Merges laufen daher normalerweise konfliktfrei. Quest-spezifischer Code (Ebenen-Snap, persistente Anker, künftig In-Headset-Menü) wird **nur hier** entwickelt und nicht zurück nach upstream gemergt.

## Lokal starten

```powershell
.\serve.ps1        # oder: python -m http.server 8000
# → http://localhost:8000/src/index.html
```

Damit lässt sich die 3D-Vorschau und die HTML-Oberfläche testen. **Der AR-Modus ist lokal praktisch nicht testbar** — WebXR verlangt HTTPS und das Headset bräuchte die Rechner-IP. Praxis-Workflow: pushen, 1–2 Minuten warten, im Quest-Browser die Live-URL öffnen:

```
https://wefoth.github.io/WEBXR_QUEST/src/index.html
```

## Auf der Quest testen

1. Space Setup der Quest durchführen (einmalig; liefert Ebenen für Snap + stabile Anker)
2. Quest-Browser → Live-URL oder QR-Code (`qr-codes/qrcode.html` am Rechner öffnen und mit dem Headset scannen)
3. Läuft etwas schief, zeigt das Fehler-Panel auf der Seite die Ursache (Screenshot der Ansicht genügt zum Debuggen)
4. Persistenz testen: platzieren → Session + Browser beenden → Seite neu öffnen, gleiches Modell laden, AR starten → Objekte stehen wieder da

## QR-Code aktualisieren

Nur nötig, wenn sich eine Seiten-URL ändert: neues PNG erzeugen (z. B. `python make_qr.py` mit angepasster URL oder ein Online-Generator) und `qr-codes/qrcode.png` + Link in `qr-codes/qrcode.html` austauschen.


