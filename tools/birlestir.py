"""revize.html'i index.html'in içine gömer.

Revize panelinde değişiklik yaptıktan sonra çalıştır:
    python3 tools/birlestir.py

Böylece yayınlamak için tek bir index.html yeterli olur.
"""
import base64
import pathlib
import re

ROOT = pathlib.Path(__file__).resolve().parent.parent
index_path = ROOT / "index.html"
revize = (ROOT / "revize.html").read_bytes()

data = base64.b64encode(revize).decode("ascii")
block = f'<script id="revizeData" type="text/plain">{data}</script>'

index = index_path.read_text(encoding="utf-8")
pattern = re.compile(r"<!-- REVIZE:BASLA -->.*?<!-- REVIZE:BITIR -->", re.S)
if not pattern.search(index):
    raise SystemExit("index.html içinde REVIZE işaretleri bulunamadı.")
index = pattern.sub(lambda _: f"<!-- REVIZE:BASLA -->{block}<!-- REVIZE:BITIR -->", index)
index_path.write_text(index, encoding="utf-8")
print(f"Revize paneli index.html içine gömüldü ({len(revize) // 1024} KB).")
