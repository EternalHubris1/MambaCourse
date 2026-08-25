$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$manifest = Get-Content (Join-Path $repoRoot "materials\manifest.json") -Raw | ConvertFrom-Json

foreach ($item in $manifest) {
  if ($item.storage -eq "github-base64") {
    $encoded = Join-Path $repoRoot ("materials\base64\" + $item.filename + ".base64")
    $target = Join-Path $repoRoot ("materials\restored\" + $item.filename)
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
    [IO.File]::WriteAllBytes($target, [Convert]::FromBase64String((Get-Content $encoded -Raw).Trim()))
  } else {
    $target = $item.local_path
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
    Invoke-WebRequest -Uri $item.source_url -OutFile $target
  }
  $actual = (Get-FileHash -Algorithm SHA256 -Path $target).Hash.ToLowerInvariant()
  if ($actual -ne $item.sha256.ToLowerInvariant()) { throw "Checksum mismatch: $target" }
  Write-Host "Verified $target"
}
