# MambaCourse archive

Reproducible backup of the course index and its linked resources.

## Inventory

- Original workbook preserved at `source/original_course_index.xlsx`.
- 261 linked cells and 207 unique URLs recorded with original cell coordinates.
- 154 Quizlet sets indexed separately under `quizlet_cards/`.
- Files over 100 MiB are represented by checksum pointers and restored to `C:\Users\user\Desktop\MambaCourse-LargeFiles`.

## Current limitation

Quizlet placed the extraction browser in a repeating human-verification challenge. All set URLs are preserved, but card bodies are explicitly marked `blocked` until a lawful export is supplied.

## Reconstruction

1. Open `source/original_course_index.xlsx` for the original layout.
2. Use `manifest/link_manifest.csv` to map each URL back to its original cell.
3. Use `quizlet_cards/quizlet_index.csv` to track card-set exports.
4. Run `tools/restore-large-files.ps1` after `large_files/pointers.json` is populated.
