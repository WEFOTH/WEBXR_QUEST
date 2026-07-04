# Rhino zu WebXR

Diese kleine Demo zeigt, wie ein Rhino-Modell direkt in einer WebXR-Anwendung dargestellt werden kann.

## Was du brauchst

- Ein Rhino-Modell als GLTF oder GLB
- Ein GitHub-Konto
- Ein Android-Smartphone mit Chrome
- Optional: ein Gerät, das WebXR/AR unterstützt

## So nutzt du es

1. Exportiere dein Rhino-Modell aus Rhino als GLTF oder GLB.
2. Lade die Projektdateien auf GitHub hoch.
3. Aktiviere GitHub Pages für das Repository.
4. Öffne die GitHub-Pages-URL auf deinem Handy im Chrome-Browser.
5. Lade dein Modell über den Button im Overlay.
6. Tippe auf die AR-Schaltfläche, wenn dein Handy und Browser WebXR unterstützen.

## GitHub Pages auf deinem Handy einrichten

### 1. Repository auf GitHub anlegen

- Gehe auf github.com und melde dich an.
- Klicke auf New repository.
- Gib einen Namen ein, zum Beispiel: rhino-webxr-demo
- Wähle Public oder Private.
- Klicke auf Create repository.

### 2. Dateien hochladen

Es gibt zwei einfache Wege:

- Über die GitHub-Weboberfläche: Dateien per Drag & Drop hochladen
- Oder mit Git auf dem Rechner

Die Dateistruktur sollte so aussehen:

- index.html
- app.js
- styles.css
- README.md
- .github/workflows/deploy-pages.yml
- .nojekyll

### 3. GitHub Pages aktivieren

- Öffne dein Repository auf GitHub.
- Gehe in Settings.
- Öffne den Bereich Pages.
- Unter Source wähle Deploy from a branch.
- Wähle main als Branch.
- Wähle /root als Ordner.
- Klicke auf Save.

GitHub baut die Seite dann automatisch auf. Das kann 1–3 Minuten dauern.

### 4. Die Seite auf dem Handy öffnen

- Nach dem Aufbau erscheint eine URL in der Form:

```text
https://dein-benutzername.github.io/rhino-webxr-demo/
```

- Öffne diese URL in Chrome auf deinem Android-Handy.

### 5. Modell laden

- Tippe auf den Button „Rhino-Modell laden“.
- Wähle dein GLB- oder GLTF-Modell aus.
- Das Modell wird direkt im 3D-Viewer angezeigt.

### 6. AR testen

- Öffne die Seite auf einem kompatiblen Android-Gerät.
- Verwende Chrome.
- Tippe auf die AR-Schaltfläche.
- Erlaube Kamera und Zugriff auf die Umgebung, wenn der Browser danach fragt.

## Wichtig für AR/WebXR

- AR funktioniert nur in kompatiblen Browsern und auf unterstützten Geräten.
- Die Seite muss über HTTPS laufen. GitHub Pages macht das automatisch.
- Die AR-Funktion funktioniert am zuverlässigsten in Chrome auf Android.
- Wenn kein AR-Button erscheint, ist dein Gerät oder Browser eventuell nicht kompatibel.

## Lokal starten

Wenn du die Seite lokal testen willst, kannst du sie auch mit einem kleinen lokalen Server starten:

```bash
python -m http.server 8000
```

Danach im Browser öffnen:

```text
http://localhost:8000/
```

## Empfehlung für Rhino

- Exportiere als GLTF oder GLB.
- Nutze eine sinnvolle Einheiten- und Skalierung.
- Wenn du nur ein Testmodell brauchst, kann die Demo auch mit dem Standardwürfel starten.
