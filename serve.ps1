$root = 'g:\Meine Ablage\OTH\CODING\VS Code\OTH WEBXR_TEST'
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add('http://localhost:8000/')
$listener.Start()
Write-Host "Server läuft unter http://localhost:8000/"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $requestPath = $context.Request.Url.AbsolutePath
    if ($requestPath -eq '/') { $requestPath = '/index.html' }

    $fullPath = Join-Path $root ($requestPath.TrimStart('/'))
    if (Test-Path $fullPath -PathType Leaf) {
        $contentType = 'text/html'
        if ($fullPath.EndsWith('.js')) { $contentType = 'application/javascript' }
        elseif ($fullPath.EndsWith('.css')) { $contentType = 'text/css' }
        elseif ($fullPath.EndsWith('.json')) { $contentType = 'application/json' }
        elseif ($fullPath.EndsWith('.glb')) { $contentType = 'model/gltf-binary' }
        elseif ($fullPath.EndsWith('.gltf')) { $contentType = 'model/gltf+json' }

        $bytes = [System.IO.File]::ReadAllBytes($fullPath)
        $response = $context.Response
        $response.ContentType = $contentType
        $response.ContentLength64 = $bytes.Length
        $response.OutputStream.Write($bytes, 0, $bytes.Length)
        $response.OutputStream.Close()
    } else {
        $response = $context.Response
        $buffer = [System.Text.Encoding]::UTF8.GetBytes('Nicht gefunden')
        $response.StatusCode = 404
        $response.ContentType = 'text/plain'
        $response.ContentLength64 = $buffer.Length
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
        $response.OutputStream.Close()
    }
}
