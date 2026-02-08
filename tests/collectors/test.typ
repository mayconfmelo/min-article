#import "/src/lib.typ": *
#import "@preview/nexus-tools:0.1.0": storage
#set page(width: auto, height: auto, margin: 1em)


#context raw(
  lang: "yaml",
  yaml.encode(storage.final(namespace: "min-article"))
)


#abstract("Main abstract")

#abstract("foreign", "Foreign abstract")

#bibliography("Bibliographic data")

#appendix("Appendix ambient")

#annex("Annex ambient")

#acknowledgments("Acknowledgments")


#set text(size: 0pt)
// These ones also collects data:

#abbreviations((
  ABBR: (
    "Abbreviation Name",
    "Optional abbreviation description",
  ),
  ABBREV: "Abbreviation Name",
))

#glossary((
  term: "Glossary term description",
))