#let figure(
  source: none,
  align: center,
  caption: none,
  ..args
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


#let help() = context {
  pagebreak(weak: true)
  
  set page(
    width: auto,
    height: auto,
    margin: 1em,
    header: none
  )
  
  if text.lang == "pt" {
    table(
      columns: 2,
      table.header[Elemento][Comando],
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
      table.header[Element][Command],
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
  
  pagebreak(weak: true)
}