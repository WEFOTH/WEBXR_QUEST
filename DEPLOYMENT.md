# Deployment: GitHub Pages — Quest-Variante

*Stand: 07.07.2026*

**Live-URL:** https://wefoth.github.io/WEBXR_QUEST/src/index.html

Identisch zum Hauptprojekt aufgesetzt: GitHub Pages mit **„Deploy from a branch"** (Branch `main`, Ordner `/ (root)`), kein eigener Actions-Workflow. Jeder `git push` auf `main` startet automatisch „pages build and deployment"; nach ~1–2 Minuten ist der Stand live. `.nojekyll` im Root muss erhalten bleiben; nur relative Pfade verwenden.

## Typischer Ablauf

```powershell
git push                     # eigene Quest-Änderungen
# oder nach einem Upstream-Merge:
git fetch upstream
git merge upstream/main
git push
```

## Troubleshooting

- **Headset zeigt alten Stand:** kurz warten, dann Seite im Quest-Browser neu laden (ggf. Tab schließen und neu öffnen)
- **Deploy schlägt fehl:** Actions-Tab prüfen (https://github.com/WEFOTH/WEBXR_QUEST/actions). Scheitert nur der Deploy-Schritt, handelt es sich meist um einen transienten GitHub-Fehler → leeren Commit pushen:
  ```powershell
  git commit --allow-empty -m "Retrigger Pages deploy"
  git push
  ```
- **Prüfen, ob der neue Stand live ist:** `https://wefoth.github.io/WEBXR_QUEST/src/app.js` abrufen und nach einem Stichwort aus dem letzten Commit suchen

Ausführliches Pages-Troubleshooting: [WEBXR_ANDROID/DEPLOYMENT.md](https://github.com/WEFOTH/WEBXR_ANDROID/blob/main/DEPLOYMENT.md).


