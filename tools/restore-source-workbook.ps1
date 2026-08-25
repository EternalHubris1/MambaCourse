$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$encoded = Join-Path $repoRoot "source\original_course_index.xlsx.base64"
$target = Join-Path $repoRoot "source\original_course_index.xlsx"
$bytes = [Convert]::FromBase64String((Get-Content $encoded -Raw).Trim())
[IO.File]::WriteAllBytes($target, $bytes)
Write-Host "Restored $target"
