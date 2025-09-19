#import "@preview/min-article:0.1.1": *

#show: article.with(   
	title: "Main Title",
	subtitle: "Complementary subtitle, not more than two lines long",
	foreign-title: "Título Principal",
	foreign-subtitle: "Subtítulo complementar, com não mais que duas linhas",
	foreign-lang: "pt",
	authors: (
	  ("Main Author", "PhD in Procrastination with a minor in Doing Nothing. Professor at Lazy University."),
	  ("Main Collaborator", "Degree in Doing Nothing and researcher at Lazy University."),
	  ("Collaborator", "Procrastination Student at Lazy University.")
	),
)

// Break page after main/foreign abstracts for cosmetic purpose.
#pagebreak()


= Primary section
#lorem(120)

== Secondary section
#lorem(120)

=== Tertiary section
#lorem(120)

==== Quaternary section
#lorem(120)

===== Quinary section
#lorem(107)


#pagebreak()


= Math

#lorem(14)

$ E = m c^2 $

#lorem(14)

Inline math: $E = m c^2$.


= Figures

#lorem(14)

#figure(
  kind: "board",
  supplement: "Board",
  caption: "A figure example",
  source: ref(<author>),
  rect[Figure content]
)

#lorem(14)


= Tables

#lorem(14)

#figure(
  kind: "table",
  supplement: "Table",
  caption: "Example of table inside a figure",
  source: ref(<author>),
  table(
    columns: 3,
    table.header[Things][Stuffs][Results],
    [Some thing], [Some stuff], [Some result],
    [Another thing], [Another stuff], [Another result]
  )
)

#lorem(14)


= Terms and abbreviations

#abbrev[abnt][Associação Brasileira de Normas Técnicas][
  Brazilian organization responsible for technical standardization
]\
#abbrev[abnt]\
#abbrev[abnt]

#abbrev[idk][I don't know]\
#abbrev[idk]\

#gloss[Saudade][
  Brazilian word with no direct translation; represents a feeling of intense
  longing for someone or something, and a desire to have this someone or
  something back.
]


// These commands are purposelly in the wrong place, to show it does not matter


#abstract[
  The abstract must succinctly highlight the content of a text. The order and
  extent of the elements depend on the type of abstract (informative or
  indicative) and the treatment each item receives in the original document.
  Should consist of a sequence of concise sentences in a single paragraph,
  without itemized topics. In technical or scientific documents, the
  informative abstract is recommended. It is advisable to use the verb in the
  third person. Its length is recommended to be 150 to 500 words for academic
  works and technical and/or scientific reports; 100 to 250 words for journal
  articles; or 50 to 100 words for any other documents. Immediately below the
  abstract must appear the keywords, preceded by the phrase Keywords, followed
  by a colon, separated by semicolons, and ending with a period, all lowercase
  except for proper nouns and scientific names.

  Keywords: article; article example; abstract; ABNT; Brazilian norm.
]

#abstract("foreign")[
  O resumo deve ressaltar sucintamente o conteúdo de um texto. A ordem e a
  extensão dos elementos dependem do tipo de resumo (informativo ou indicativo)
  e do tratamento que cada item recebe no documento original. Ele deve ser
  composto por uma sequência de frases concisas em parágrafo único, sem
  enumeração de tópicos. Em documento técnico ou científico, recomenda-se o
  resumo informativo. Convém usar o verbo na terceira pessoa. É recomendado que
  seu tamanho seja 150 a 500 palavras nos trabalhos acadêmicos e relatórios
  técnicos e/ou científicos; 100 a 250 palavras nos artigos de periódicos; ou
  50 a 100 palavras nos demais documentos. Logo abaixo do resumo devem aparecer
  as palavras-chave, antecedidas da expressão Palavras-chave, seguida de
  dois-pontos, separadas entre si por ponto e vírgula e finalizadas por ponto,
  em letras minúsculas exceto substantivos próprios e nomes científicos.
  
  Palavras-chave: artigo; exemplo de artigo; resumo; ABNT; norma brasileira.
]

#bibliography(read("assets/bib.yml"), full: true)

#appendix[
  = Some Extra Data
  #lorem(162)

  == Some Additional Things
  #lorem(206)
  
  = Even More Extra Data
  #lorem(323)
]

#annex[
  = An Important Document Create by Someone Else
  #lorem(162)
  
  == Important Explanation
  #lorem(206)
  
  = Another Important Third-party Document
  #lorem(323)
]

#acknowledgments[
   That's all folks! \
   Thank you for your time.
]