param(
    [string]$Source = "$env:USERPROFILE\OneDrive\Documents\GitHub\Orbital-strike-cannon-datapack",
    [string]$World = "Nuke",
    [switch]$NoCopy
)

$minecraft = Join-Path $env:APPDATA ".minecraft"
$saves = Join-Path $minecraft "saves"

if (-not (Test-Path $Source)) { Write-Error "Source not found: $Source"; exit 1 }
if (-not (Test-Path $saves)) { Write-Error "Minecraft saves folder not found: $saves"; exit 1 }

if (-not $World) {
    $worlds = Get-ChildItem -Path $saves -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name
    if (-not $worlds) { Write-Error "No worlds found in $saves"; exit 1 }
    Write-Host "Found worlds:"
    for ($i=0; $i -lt $worlds.Count; $i++) { Write-Host ("{0}) {1}" -f ($i+1), $worlds[$i]) }
    $sel = Read-Host "Enter world number or name"
    if ($sel -match '^\d+$') { $World = $worlds[[int]$sel - 1] } else { $World = $sel }
}

$destWorld = Join-Path $saves $World
if (-not (Test-Path $destWorld)) { Write-Error "World not found: $destWorld"; exit 1 }

$datapacks = Join-Path $destWorld "datapacks"
New-Item -Path $datapacks -ItemType Directory -Force | Out-Null

$zipName = (Split-Path $Source -Leaf) + ".zip"
$zipPath = Join-Path $datapacks $zipName

Compress-Archive -Path (Join-Path $Source '*') -DestinationPath $zipPath -Force
Write-Host "Zipped datapack to: $zipPath"

if (-not $NoCopy) {
    $copyDest = Join-Path $datapacks (Split-Path $Source -Leaf)
    if (Test-Path $copyDest) { Remove-Item -Path $copyDest -Recurse -Force }
    Copy-Item -Path $Source -Destination $datapacks -Recurse -Force
    Write-Host "Copied datapack folder to: $copyDest"
}

Write-Host "Done. Start Minecraft and run /reload in the world, then use /datapack list or /function <namespace>:<function>."