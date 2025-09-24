/**
= Figure Command
:figure:
Replace the original `#figure` command to add a source option, required by ABNT.
**/
#let figure(
  source: none, /// reference | string | content <required>
    /// The figure source.
  align: center, /// alignment
    /// Align the figure — does not replace `#figure(placement)`.
  caption: none,
  ..args /// arguments
    /** #let docs = "https://typst.app/docs/reference/model/figure/#parameters"
    Any arguments supported by the original #url(docs)[`#figure`] command. |**/
) = {
  assert.ne(source, none, message: "#figure(source) required by ABNT")
  assert.ne(caption, none, message: "#figure(caption) required by ABNT")
  
  import "@preview/transl:0.1.1": transl
  import "origin.typ"
  
  set origin.align(align)
  
  block(breakable: false)[
    #origin.figure(..args, caption: caption)
    #v(-1em)
    #origin.align(center, text(size: 1em - 2pt)[#transl("source"): #source])
  ]
}


/**
= Help Command
:help: => #cmd.<name>(<capt>)
Prints a table thats helps to remember which commands are used for each article
element, working as a quick reminder.

new-page <- boolean
  Get the helper table in a custom separated page.
**/
#let help(new-page: true) = context {
  let args = (:)
  
  if new-page {
    pagebreak(weak: true)
    args = (
      width: auto,
      height: auto,
      margin: 1em,
      header: none
    )
  }
  
  set page(..args)
  
  if text.lang == "pt" {
    table(
      columns: 2,
      table.header[*Elemento*][*Comando*],
      [Título],              ```typ #article(title)```,
      [Subtitulo],           ```typ #article(subtitle)```,
      [Autores],             ```typ #article(authors)```,
      [Resumo],             [```typ #abstract()```\ ```typ #article(abstract)```],
      [Resumo estrangeiro], [```typ #abstract("foreign")```\ ```typ #article(foreign-abstract)```],
      [Abreviaturas],        ```typ #abbreviations()```,
      [Bibliografia],        ```typ #bibliography()```,
      [Glossário],           ```typ #glossary()```,
      [Apêndices],           ```typ #appendix()```,
      [Anexos],              ```typ #annex()```,
      [Agradecimentos],      ```typ #acknowledgments()```,
    )
  }
  else {
    table(
      columns: 2,
      table.header[*Element*][*Command*],
      [Title],             ```typ #article(title)```,
      [Subtitle],          ```typ #article(subtitle)```,
      [Authors],           ```typ #article(authors)```,
      [Abstract],         [```typ #abstract()```\ ```typ #article(abstract)```],
      [Foreign abstract], [```typ #abstract("foreign")```\ ```typ #article(foreign-abstract)```],
      [Abbreviations],     ```typ #abbreviations()```,
      [Bibliography],      ```typ #bibliography()```,
      [Glossary],          ```typ #glossary()```,
      [Appendices],        ```typ #appendix()```,
      [Annexes],           ```typ #annex()```,
      [Acknowledgments],   ```typ #acknowledgments()```,
    )
  }
  
  if new-page {pagebreak(weak: true)}
}