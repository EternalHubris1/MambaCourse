from __future__ import annotations

import csv
import json
import re
import sys
from pathlib import Path


def safe_name(value: str) -> str:
    value = re.sub(r'[^A-Za-z0-9._-]+', '-', value.strip()).strip('-')
    return value or 'quizlet-set'


def main() -> None:
    if len(sys.argv) < 4:
        raise SystemExit('usage: import-quizlet-tsv.py INPUT.tsv SET_ID TITLE [SOURCE_URL]')
    source = Path(sys.argv[1])
    set_id, title = sys.argv[2], sys.argv[3]
    source_url = sys.argv[4] if len(sys.argv) > 4 else ''
    target = Path(__file__).resolve().parents[1] / 'quizlet_cards' / f'{set_id}-{safe_name(title)}'
    target.mkdir(parents=True, exist_ok=True)
    with source.open(encoding='utf-8-sig', newline='') as f:
        cards = [row[:2] for row in csv.reader(f, delimiter='\t') if len(row) >= 2]
    with (target / 'cards.csv').open('w', encoding='utf-8-sig', newline='') as f:
        w = csv.writer(f); w.writerow(['term', 'definition']); w.writerows(cards)
    lines = [f'# {title}', '', f'Source: {source_url}', '']
    for i, (term, definition) in enumerate(cards, 1):
        lines += [f'## Card {i}', '', f'**Term:** {term}', '', f'**Definition:** {definition}', '']
    (target / 'cards.md').write_text('\n'.join(lines), encoding='utf-8')
    (target / 'metadata.json').write_text(json.dumps({
        'set_id': set_id, 'title': title, 'source_url': source_url, 'card_count': len(cards)
    }, ensure_ascii=False, indent=2), encoding='utf-8')


if __name__ == '__main__':
    main()
