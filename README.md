# MambaCourse archive

Reproducible backup of the course index and its linked resources.

## Inventory

- Exact source workbook preserved as reconstructable Base64 with SHA-256 verification.
- 261 linked cells and 207 unique URLs mapped to original spreadsheet coordinates.
- All 12 Yandex materials downloaded and checksummed.
- 8 files below 100 MiB stored in GitHub as exact-byte Base64.
- 4 files above 100 MiB recorded with source URLs, sizes, checksums, and absolute Windows destinations.
- 154 Quizlet sets indexed separately under `quizlet_cards/`.

## Restore the materials on Windows

Clone or download this repository, open PowerShell in its root directory, and run:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\restore-source-workbook.ps1
powershell -ExecutionPolicy Bypass -File .\tools\restore-materials.ps1
```

Small materials are reconstructed from GitHub. Oversized files are downloaded to:

```text
C:\Users\user\Desktop\MambaCourse-LargeFiles
```

Every restored file is checked against its recorded SHA-256 checksum.

## Quizlet limitation

Quizlet placed the extraction browser in a repeating human-verification challenge. All set URLs and IDs are preserved. The paired Markdown schema and TSV importer are ready under `quizlet_cards/` and `tools/import-quizlet-tsv.py`.
