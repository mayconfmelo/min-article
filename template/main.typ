#import "@local/min-article:0.0.0": (
  article, abstract, abbrev, gloss,
  appendix, annex, acknowledgments, figure
)

#show: article.with(  
	title: "",
	subtitle: "",
	foreign-title: "",
	foreign-subtitle: "",
	authors: (
	  ("NAME", "BRIEF RÉSUMÉ"),
	),
	lang: "",
	lang-foreign: "",
)

// Write the text body bellow:
// Don't mind the positioning of these commands, they can be anywhere.

#abstract("main")[ ABSTRACT HERE ]

#abstract("foreign")[ FOREIGN ABSTRACT HERE ]


#appendix[ APPENDIX HERE ]


#annex[ ANNEX HERE ]


#acknowledgments[ ACKNOWLEDGEMENTS HERE ]


// Better to keep the bibliography always at the end.
#bibliography("bib.yml")