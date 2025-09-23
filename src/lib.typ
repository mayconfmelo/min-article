// NAME: Minimal Articles
// TODO: Implement web article (HTML) when stable
// TODO: Implement comment documentation


/**#v(1fr)#outline()#v(1.2fr)#pagebreak()
= Quick Start
```typ
#import "@preview/min-article:0.1.1": article
#show: article.with(   
	title: "Main Title",
	subtitle: "Complementary subtitle, not more than two lines",
	authors: (
	  ("Main Author", "PhD in Procrastination."),
	  ("Main Collaborator", "Degree in Doing Nothing."),
	),
)
```
**/
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
  import "sub/abbreviations.typ"
  
  transl(data: lang-data)
  
  let body = body
  let authors = authors
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
  show math.equation: it => text(
    ..default(
      when: text.font == "new computer modern math",
      value: (font: ("Tex Gyre Termes Math", "New Computer Modern Math")),
      typst-defaults
    ),
    it
  )
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
    let abstract = storage.final(
      "abstract",
      (main: abstract, foreign: foreign-abstract),
      namespace: "min-article",
    )
    
    assert.ne(
      abstract.main, none,
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
  
  body = abbreviations.init(body)
  
  body
  
  storage.namespace("min-article")
  
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
  else {panic("ABNT requires a bibliography")}
  
  // Glossary
  context if not its.empty( storage.final("glossary", (:)) ) {
    import "sub/glossary.typ"
    
    pagebreak(weak: true)
    
    heading(
      level: 1,
      numbering: none,
      transl("glossary")
    )
    
    glossary.insert()
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
  context if storage.final("acknowledgments", acknowledgments) != none {
    pagebreak(weak: true)
    
    heading(
      level: 1,
      outlined: false,
      numbering: none,
      align(center, transl("acknowledgments"))
    )
    
    storage.final("acknowledgments", acknowledgments).join()
  }
}

#import "sub/abbreviations.typ": add as abbreviations
#import "sub/glossary.typ": add as glossary
#import "sub/cmd.typ" as cmd: figure
#import "sub/collectors.typ": *