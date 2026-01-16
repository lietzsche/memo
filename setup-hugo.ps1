$ErrorActionPreference = "Stop"

$repo = "gohugoio/hugo"
$api = "https://api.github.com/repos/$repo/releases/latest"
$release = Invoke-RestMethod $api
$asset = $release.assets | Where-Object { $_.name -match "hugo_extended_.*_windows-amd64.zip$" } | Select-Object -First 1
if (-not $asset) { throw "hugo_extended windows zip not found in latest release." }

$installDir = "$env:LOCALAPPDATA\\hugo"
$zipPath = "$env:TEMP\\$($asset.name)"

New-Item -ItemType Directory -Force $installDir | Out-Null
Invoke-WebRequest $asset.browser_download_url -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $installDir -Force

$hugoExe = Join-Path $installDir "hugo.exe"
if (-not (Test-Path $hugoExe)) { throw "hugo.exe not found after extraction." }

# Add to user PATH if not already present
$path = [Environment]::GetEnvironmentVariable("Path", "User")
if ($path -notlike "*$installDir*") {
  [Environment]::SetEnvironmentVariable("Path", "$path;$installDir", "User")
}

# Refresh PATH for current session
$env:Path = [Environment]::GetEnvironmentVariable("Path", "User") + ";" + [Environment]::GetEnvironmentVariable("Path", "Machine")

& $hugoExe version
