$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$manifest = Join-Path $repoRoot "large_files\pointers.json"
$items = Get-Content $manifest -Raw | ConvertFrom-Json
foreach ($item in $items) {
  $target = $item.local_path
  New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
  Invoke-WebRequest -Uri $item.source_url -OutFile $target
  $actual = (Get-FileHash -Algorithm SHA256 -Path $target).Hash.ToLowerInvariant()
  if ($actual -ne $item.sha256.ToLowerInvariant()) { throw "Checksum mismatch: $target" }
  Write-Host "Verified $target"
}
