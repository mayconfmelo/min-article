// NAME: Minimal Articles
// REQ: transl:0.1.1, numbly:0.1.0
// TODO: Implement web article (HTML) when stable
// TODO: #abbrev retrieve long-name from storage.final()
// TODO: compartimentalize project


#let article(
  title: none,
  subtitle: none,
  foreign-title: none,
  foreign-subtitle: none,
  foreign-abstract: none,
  foreign-lang: none,
  authors: none,
  abstract: none,
  acknowledgments: none,
  date: auto,
  lang-data: yaml("assets/lang.yaml"),
  typst-defaults: false,
  body
) = context {
  assert.ne(title, none)
  assert.eq(type(authors), array)
  assert.eq(type(lang-data), dictionary)
  
  import "@preview/transl:0.1.1": transl
  import "@preview/toolbox:0.1.0": date as date-parse, get, storage, has, its, default
  
  // Store translation database
  transl(data: lang-data)
  
  let full-title = title + if subtitle != none {": " + subtitle}
  let font-size = default(
    when: text.size == 11pt,
    value: 12pt,
    otherwise: text.size,
    typst-defaults
  )
  
  if type(authors.at(0)) != array {authors = (authors,)}
  
  set document(
    title: full-title,
    author: authors.at(0).at(0) + if authors.len() > 1 {" et al."},
    date: date-parse( get.auto-val(date, datetime.today()) )
  )
  set page(
    ..default(
      when: page.margin == auto,
      value: (margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 2cm)),
      typst-defaults
    ),
    header: context if counter(page).get().at(0) > 1 {
      align( right, text(size: font-size - 2pt)[#locate(here()).page()] )
    }
  )
  set par(
    ..default(
      when: not par.justify,
      value: (justify: true),
      typst-defaults
    ),
    ..default(
      when: par.leading == 0.65em,
      value: (leading: 0.3em),
      typst-defaults
    ),
    ..default(
      when: par.spacing == 1.2em,
      value: (spacing: 1.5em),
      typst-defaults
    ),
  )
  set text(
    ..default(
      when: text.font == "libertinus serif",
      value: (font: ("Tex Gyre Termes", "Times New Roman")),
      typst-defaults
    ),
    size: font-size,
  )
  set terms(separator: [: ], tight: true)
  set heading(numbering: "1.1.1.1.1 ")
  set table(
    stroke: (_, y) => (
       top: if y <= 1 { 1pt } else { 0pt },
       bottom: 1pt,
      ),
    align: (_, y) => if y == 0 { center } else { left },
  )
  set bibliography(
    ..default(
      when: bibliography.style == "ieee",
      value: (style: "associacao-brasileira-de-normas-tecnicas"),
      typst-defaults
    )
  )
  
  show figure: set figure.caption(position: top)
  show figure.caption: set text(size: 1em - 2pt)
  show footnote.entry: set text(size: font-size - 2pt)
  show heading: set block(above: font-size * 1.5, below: font-size * 1.5)
  show heading.where(numbering: none): set align(center)
  show heading.where(level: 1): set text(size: font-size + 2pt)
  show selector.or(
    heading.where(level: 2),
    heading.where(level: 3),
    heading.where(level: 4),
    heading.where(level: 5),
  ): set text(size: font-size + 1pt)
  show math.equation.where(block: true): set align(left)
  show math.equation.where(block: true): set math.equation(numbering: "(1)")
  show math.equation: it => text(..default(
    when: text.font == "new computer modern math",
    value: (font: "Tex Gyre Termes Math"),
    typst-defaults
  ), it)
  show quote.where(block: true): it => pad(x: 1em, it)
  show raw.where(block: true): it => pad(left: 1em)[#it]
  
  // Title
  {
    set text(hyphenate: false)
    
    heading(
      level: 1,
      outlined: false,
      numbering: none,
      align(center, full-title)
    )
    
    if foreign-title != none {
      let foreign-full-title = foreign-title + if foreign-subtitle != none {
        ": " + foreign-subtitle
      }
      
      set text(lang: foreign-lang)
      
      // Foreign title, if any
      heading(
        level: 1,
        outlined: false,
        numbering: none,
        align(center, foreign-full-title)
      )
    }
  }
  
  // Authors
  {
    set align(right)
    set footnote(numbering: "*")
    
    v(1.5em)
    for author in authors {
      author.at(0)
      footnote[#author.at(1)]
      linebreak()
    }
    v(4.5em)
    
    set footnote(numbering: "1")
    counter(footnote).update(0)
  }
  
  // Abstract
  context {
    show heading: set align(center)
    
    heading(
      level: 1,
      numbering: none,
      transl("abstract")
    )
    
    // Try to get #abstract commands, fallback to #article abstract options
    let abstract = storage.final("abstract", (:))
    
    assert.ne(
      abstract.at("main", default: none), none,
      message: "#article(abstract) or #abstract('main') required"
    )
    abstract.main
    
    if abstract.at("foreign", default: none) != none {
      set text(lang: foreign-lang)
      show heading: set align(center)
      
      heading(
        level: 1,
        numbering: none,
        transl("abstract")
      )
      
      abstract.foreign
    }
  }
  
  body
  
  // Bibliography
  context if not its.empty( storage.final("bibliography", (:)) ) {
    pagebreak(weak: true)
    
    let stored = storage.final("bibliography")
    let bib = ()
    let args = (:)
    
    for entry in stored {
      for data in entry.pos() {
        if type(data) != bytes {data = bytes(data)}
        
        bib.push(data)
      }
      args = args + entry.named()
    }
    
    bibliography(bib, ..args)
  }
  
  // Glossary
  context if not its.empty( storage.final("glossary", (:)) ) {
    pagebreak(weak: true)
    
    heading(
      level: 1,
      numbering: none,
      transl("glossary")
    )
    
    let stored = storage.final("glossary")
    let value
    
    for entry in stored.keys().sorted() {
      value = stored.at(entry)
      
      if value.def == () and has.key(value, "long") {value = value.long}
      else {
        // 'abbreviation (long form)' for #abbrev:
        if has.key(value, "long") {entry = [#value.long (#entry)]}
        
        value = value.def
      }
      set terms(separator: [:#linebreak()], tight: true)
      
      block(breakable: false, terms.item(entry, [#value]))
    }
  }
  
  // Appendices
  context if not its.empty( storage.final("appendices", (:)) ) {
    pagebreak(weak: true)
  
    import "@preview/numbly:0.1.0": numbly
    
    let pattern = (
      transl("appendix", to: text.lang, data: lang-data) + " {1:A} — ",
      "{1:A}.{2:1} ",
      "{1:A}.{2:1}.{3:1} ",
      "{1:A}.{2:1}.{3:1}.{4:1} ",
      "{1:A}.{2:1}.{3:1}.{4:1}.{5:1} ",
    )
    
    set heading(numbering: numbly(..pattern, default: "A.1.1.1.1 "))
    show heading.where(level: 1): set align(center)
    counter(heading).update(0)
     
    storage.final("appendices").join()
  }
  
  // Annex
  context if not its.empty( storage.final("annexes", (:)) ) {
    pagebreak(weak: true)
  
    import "@preview/numbly:0.1.0": numbly
    
    let pattern = (
      transl("annex", to: text.lang, data: lang-data) + " {1:A} — ",
      "{1:A}.{2:1} ",
      "{1:A}.{2:1}.{3:1} ",
      "{1:A}.{2:1}.{3:1}.{4:1} ",
      "{1:A}.{2:1}.{3:1}.{4:1}.{5:1} ",
    )
    
    set heading(numbering: numbly(..pattern, default: "A.1.1.1.1 "))
    show heading.where(level: 1): set align(center)
    counter(heading).update(0)
     
    storage.final("annexes").join()
  }
  
  // Acknowledgments
  let acknowledgments = storage.final("acknowledgments", (acknowledgments,))
  context if acknowledgments != none {
    pagebreak(weak: true)
    
    heading(
      level: 1,
      outlined: false,
      numbering: none,
      align(center, transl("acknowledgments"))
    )
    
    acknowledgments.join()
  }
}


// Receives the abstract and its designation "main" or "foreign".
// Stores both text and designation into "article-abstract" state.
#let abstract(..args) = {
  import "@preview/toolbox:0.1.0": storage
  
  args = args.pos()
  
  assert( (1, 2).contains(args.len()) )
  
  // Insert args.pos().at(1) = "main" if none is set
  if args.len() == 1 {args.insert(0, "main")}
  
  let abstr = (:)
  
  abstr.insert(..args)
  
  assert(
    args.at(0) == "main" or args.at(0) == "foreign",
    message: "Invalid #article(" + type + ")"
  )
  
  storage.add("abstract", abstr, append: true)
}


#let bibliography(..args) = {
  import "@preview/toolbox:0.1.0": storage
  
  storage.add("bibliography", args, append: true)
}


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
  
  assert( its.type(abbreviation, str) )
  
  
  if definitions.len() > 0 {long-form = definitions.remove(0)}
  if definitions.len() > 0 {definitions = definitions.join(" ")}
  
  if long-form == none {abbreviation}
  else {
    let stored = storage.get("glossary", (:))
    let this = (:)
    
    if has.key(stored, abbreviation) {
      panic("Duplicated #abbr[" + abbreviation + "]")
    }
    
    [#long-form (#abbreviation)]
    
    this.insert(abbreviation, (long: long-form, def: definitions))
    
    storage.add("glossary", this, append: true)
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
  
  storage.add("glossary", this, append: true)
  
  name
}


// Captures appendices to feed `article-appendices` state.
#let appendix(data) = context {
  import "@preview/toolbox:0.1.0": storage
  
  storage.add("appendices", data, append: true)}
}


// Captures annexes to feed `article-annexes` state.
#let annex(data) = context {
  import "@preview/toolbox:0.1.0": storage
  
  storage.add("annexes", data, append: true)
}


// Thank and recognize the role of important people in the making of the document.
#let acknowledgments(data) = context {
  import "@preview/toolbox:0.1.0": storage
  
  storage.add("acknowledgments", data, append: true)
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