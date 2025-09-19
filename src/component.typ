
// Captures abbreviation ls to feed `article-glossary` state.
// Shows the abbreviation (along with long name, just the first time).
#let abbrev(
  abbreviation,
  ..definitions
) = context {
  import "@preview/toolbox:0.1.0": storage, its, has, content2str
  
  let abbreviation = upper(content2str(abbreviation))
  let definitions = definitions.pos()
  let long-form = none
  let stored = storage.get("glossary", (:), namespace: "min-article")
  
  assert( its.type(abbreviation, str) )
  
  if definitions.len() > 0 {long-form = definitions.remove(0)}
  if definitions.len() > 0 {definitions = definitions.join(" ")}
  
  if long-form == none {
    
    if not has.key(stored, abbreviation) {
      panic("First ocurrency must be #abbrev[" + abbreviation + "][Definition]")
    }
    
    abbreviation
  }
  else {
    let this = (:)
    
    if has.key(stored, abbreviation) {
      panic("Duplicated #abbr[" + abbreviation + "]")
    }
    
    [#long-form (#abbreviation)]
    
    this.insert(abbreviation, (long: long-form, def: definitions))
    
    storage.add("glossary", this, append: true, namespace: "min-article")
  }
}


// Captures glossary entries to feed `article-glossary` state.
// Shows the gloss term where it is placed.
#let gloss(
  name,
  definition
) = context {
  import "@preview/toolbox:0.1.0": storage, content2str
  
  let name = content2str(name)
  let this = (:)
  
  this.insert(upper(name.at(0)) + name.slice(1), (def: definition))
  
  storage.add("glossary", this, append: true, namespace: "min-article")
  
  name
}



// Shadows the figure command to introduce the `source` argument to it.
#let figure(
  source: none,
  alignment: center,
  caption: none,
  ..args
) = {
  assert.ne(source, none, message: "#figure(source) required by ABNT")
  assert.ne(caption, none, message: "#figure(caption) required by ABNT")
  
  import "@preview/transl:0.1.1": transl
  import "origin.typ"
  
  set align(alignment)
  
  block(breakable: false)[
    #origin.figure(..args, caption: caption)
    #v(-1em)
    #align(center, text(size: 1em - 2pt)[#transl("source"): #source])
  ]
}


#let cmd-help() = context {
  pagebreak(weak: true)
  
  set page(width: auto, height: auto, margin: 1em, header: none)
  
  if text.lang == "pt" {
    table(
      columns: 2,
      table.header[Elemento][Comando],
      [Título], ```typ #article(title)```,
      [Subtitulo], ```typ #article(subtitle)```,
      [Autores], ```typ #article(authors)```,
      [Resumo], [```typ #abstract()```\ ```typ #article(abstract)```],
      [Resumo estrangeiro], [```typ #abstract("foreign")```\ ```typ #article(foreign-abstract)```],
      [Bibliografia], ```typ #bibliography()```,
      [Glossário], ```typ #abbr() #gloss()```,
      [Apêndices], ```typ #appendix()```,
      [Anexos], ```typ #annex()```,
      [Agradecimentos], ```typ #acknowledgments()```,
    )
  }
  else {
    table(
      columns: 2,
      table.header[Element][Command],
      [Title], ```typ #article(title)```,
      [Subtitle], ```typ #article(subtitle)```,
      [Authors], ```typ #article(authors)```,
      [Abstract], [```typ #abstract()```\ ```typ #article(abstract)```],
      [Foreign abstract], [```typ #abstract("foreign")```\ ```typ #article(foreign-abstract)```],
      [Bibliography], ```typ #bibliography()```,
      [Glossary], ```typ #abbr() #gloss()```,
      [Appendices], ```typ #appendix()```,
      [Annexes], ```typ #annex()```,
      [Acknowledgments], ```typ #acknowledgments()```,
    )
  }
  
  pagebreak(weak: true)
}