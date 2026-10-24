"""Sprey boya temasını bir HTML dosyasına ekler.

Kullanım:
    python3 tools/sprey-uygula.py index.html
"""
import pathlib
import sys

TOOLS = pathlib.Path(__file__).resolve().parent
path = pathlib.Path(sys.argv[1])
html = path.read_text(encoding="utf-8")

if 'id="spray-theme"' in html:
    raise SystemExit("Sprey teması zaten ekli.")

css = (TOOLS / "sprey-tema.css").read_text(encoding="utf-8")
js = (TOOLS / "sprey-tema.js").read_text(encoding="utf-8")

# Fontlar
old_font = "family=Anton&"
assert old_font in html, "Font bağlantısı bulunamadı"
html = html.replace(old_font, "family=Anton&family=Permanent+Marker&family=Rubik+Spray+Paint&", 1)

# Stil: mevcut stilin hemen ardına
i = html.index("</style>") + len("</style>")
html = html[:i] + f'\n  <style id="spray-theme">\n{css}  </style>' + html[i:]

# Kod: son script'in sonuna
# Gömülü revize verisinden (REVIZE:BASLA) önceki, sayfanın ana script'i
end = html.find("<!-- REVIZE:BASLA -->")
j = html.rindex("</script>", 0, end if end != -1 else len(html))
html = html[:j] + "\n" + js + "  " + html[j:]

path.write_text(html, encoding="utf-8")
print(f"Sprey teması eklendi: {path}")
