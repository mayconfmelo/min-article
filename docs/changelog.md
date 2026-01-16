# 0.0.0


## 0.1.0

- Main title and foreign title[^1]
- Authors name and short description[^2]
- Main abstract and foreign abstract[^3]
- General formatting[^4]
- Section titles[^5]
  - Title numbering[^6]
  - Centralized unnumbered titles[^7]
- ABNT bibliographical reference style[^8]
- Figures with source[^9]
- Abbreviation management[^10]
- Math equation formatting[^11]
- Automatic glossary[^12] generation
- Automatic appendix[^13] insertion
- Automatic annex[^14] insertion
- Automatic acknowledgments[^15] insertion
- Other minor enhancements

[^1]: ABNT NBR 6022 (item 5.1.1)
[^2]: ABNT NBR 6022 (item 5.1.2)
[^3]: ABNT NBR 6022 (item 5.1.3)
[^4]: ABNT NBR 6022 (item 6.1),<br/>ABNT NBR 14724 (items 5.1, 5.2)
[^5]: ABNT NBR 6022 (item 6.2),<br/> ABNT NBR 6024
[^6]: ABNT NBR 6024 (item 4.1)
[^7]: ABNT NBR 6024 (item 4.1h)
[^8]: ABNT NBR 6022 (item 6.3)
[^9]: ABNT NBR 6022 (items 6.3, 6.6, 6.7)
[^10]: ABNT NBR 6022 (item 6.4)
[^11]: ABNT NBR 6022 (item 6.5)
[^12]: ABNT NBR 6022 (item 5.3.2)
[^13]: ABNT NBR 6022 (item 5.3.3)
[^14]: ABNT NBR 6022 (item 5.3.4)
[^15]: ABNT NBR 6022 (item 5.3.5)


### 0.2.0

- Complete internal re-design
- Added: Automatic bibliography generation
- `#abbreviations` to declare abreviations
- `#glossary` to declare glossary entries
- Removed: `#abbrev` and `#gloss` commands
- Updated: [toolbox](https://typst.app/universe/package/toolbox) used for internal management
- Updated: [transl](https://typst.app/universe/package/transl) used for translation
- Updated: _Tex Gyre Termes_ as default text font (fallback to _Times New Roman_)
- Updated: `#bibliography` fully compliant to ABNT standard[^16]
- Updated: Adapted CSL file to Hayagriva's limitations (uses [workarounds](../tests/bib/bib.yaml))

[^16]: ABNT NBR 6023:2025