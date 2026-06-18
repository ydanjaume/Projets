# Serveur HTTP local pour le wiki — aucune installation requise
# PowerShell est intégré à Windows
param([int]$Port = 8080)

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Url  = "http://localhost:$Port/"

$Listener = New-Object System.Net.HttpListener
$Listener.Prefixes.Add($Url)

try {
    $Listener.Start()
} catch {
    Write-Host "Le port $Port est deja utilise. Modifie le parametre Port." -ForegroundColor Red
    Read-Host "Appuie sur Entree pour quitter"
    exit 1
}

Write-Host ""
Write-Host "  Wiki YDA" -ForegroundColor Cyan
Write-Host "  ---------" -ForegroundColor DarkGray
Write-Host "  Adresse : $Url" -ForegroundColor Green
Write-Host "  Ctrl+C  : arreter le serveur" -ForegroundColor DarkGray
Write-Host ""

Start-Process $Url

$MimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".md"   = "text/plain; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".woff2"= "font/woff2"
}

function Get-FileTree {
    $items = Get-ChildItem -Path $Root -Recurse -File -Filter "*.md" |
        Where-Object { $_.FullName -notlike "*\.obsidian*" } |
        Sort-Object FullName |
        ForEach-Object {
            $rel = $_.FullName.Substring($Root.Length).TrimStart('\').Replace('\', '/')
            [ordered]@{ path = $rel; name = $_.BaseName; dir = ($rel -split '/')[0..($rel.Split('/').Length - 2)] -join '/' }
        }
    return ($items | ConvertTo-Json -Compress -Depth 3)
}

function Send-Response($Res, $Bytes, $ContentType, $Status = 200) {
    $Res.StatusCode      = $Status
    $Res.ContentType     = $ContentType
    $Res.ContentLength64 = $Bytes.Length
    $Res.OutputStream.Write($Bytes, 0, $Bytes.Length)
    $Res.OutputStream.Close()
}

Write-Host "En attente de connexions..." -ForegroundColor DarkGray

while ($Listener.IsListening) {
    $Ctx = $null
    try { $Ctx = $Listener.GetContext() } catch { break }

    $Req      = $Ctx.Request
    $Res      = $Ctx.Response
    $Local    = $Req.Url.LocalPath.TrimStart('/')

    try {
        # API : liste des fichiers
        if ($Local -eq "api/files") {
            $Json  = Get-FileTree
            $Bytes = [System.Text.Encoding]::UTF8.GetBytes($Json)
            Send-Response $Res $Bytes "application/json; charset=utf-8"
            continue
        }

        # Racine → app.html
        if ($Local -eq "" -or $Local -eq "index.html") { $Local = "app.html" }

        $FilePath = Join-Path $Root $Local

        if (Test-Path $FilePath -PathType Leaf) {
            $Ext         = [System.IO.Path]::GetExtension($FilePath).ToLower()
            $ContentType = if ($MimeTypes.ContainsKey($Ext)) { $MimeTypes[$Ext] } else { "application/octet-stream" }
            $Bytes       = [System.IO.File]::ReadAllBytes($FilePath)
            Send-Response $Res $Bytes $ContentType
        } else {
            $Msg   = [System.Text.Encoding]::UTF8.GetBytes("404 - Introuvable : $Local")
            Send-Response $Res $Msg "text/plain; charset=utf-8" 404
        }
    } catch {
        try {
            $Msg = [System.Text.Encoding]::UTF8.GetBytes("500 - Erreur serveur")
            Send-Response $Res $Msg "text/plain; charset=utf-8" 500
        } catch {}
    }
}

$Listener.Stop()
Write-Host "Serveur arrete." -ForegroundColor DarkGray
