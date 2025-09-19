#import "/src/lib.typ": *
#import "@preview/toolbox:0.1.0": storage
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

#abbrev("abbr", "Abbreviation Name", "Optional abbreviation description")
#abbrev("abbrev", "Abbreviation Name")

#gloss("term", "Glossary term description")