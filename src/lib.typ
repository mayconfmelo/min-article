// TODO: Implement web article when HTML become stable
// TODO: Update authors to dictionary

/** #v(1fr) #outline() #v(1.2fr) #pagebreak()
= Quick Start
```typ
#import "@preview/min-article:0.2.0": *
#show: article.with(   
	title: "Main Title",
	subtitle: "Complementary subtitle",
	authors: (
	  "Main Author": "Short description",
	  "Collaborator": "Short description",
	),
)
```

= Description
Generate structured and standardized articles, compliant with the requirements
of the Brazilian Association of Technical Standards (ABNT, in Portuguese). This
package also features what is called "collector commands", which just obtain
data for _min-article_; this allows to declare structural data anywhere in
source code, without worrying about the mind-frying document structure and its
rules at all: just write it and _min-article_ will figure it out.

Overall, this package aims to follow the ABNT standards as closelly as possible,
using minimum customizations only when strictly necessary. Refer to the
`docs/changelog.md` file to check out which ABNT normative documents are used.

= Options
:show.with article:
**/
#let article(
  title: none, /// <- string | content <required>
    /// Article title. |
  subtitle: none, /// <- string | content
    /// Article subtitle. |
  abstract: none, /// <- string | content
    /// Article abstract. |
  foreign: (:), /// <- dictionary
    /// `(title, subtitle, abstract, lang)`\ Set (optional) foreign language data. |
  foreign-lang: none, /// <- string
    /// Additional foreign language used (generally a _lingua franca_). |
  foreign-title: none, /// <- string | content
    /// Additional title in foreign language. |
  foreign-subtitle: none, /// <- string | content
    /// Additional subtitle in foreign language. |
  foreign-abstract: none, /// <- string | content
    /// Additional abstract in foreign language. |
  authors: (:), /// <- array | array of arrays <required>
    /// `(name, description)`\ Name and description of each article author. |
  acknowledgments: none, /// <- string | content
    /// Final thanks directed to anyone important in the creation of the article. |
  date: auto, /// <- array | dictionary | datetime
    /// `(year, month, day)`\ Article publication date. |
  lang-data: yaml("assets/lang.yaml"), /// <- yaml | toml | dictionary
    /// Translation data for `#text.lang` and `#article(foreign-lang)` languages. |
  typst-defaults: false, /// <- boolean
    /// Use original Typst defaults instead of min-article ones. |
  body
) = context {
  assert.ne(title, none, message: "#article(title) required")
  assert.ne(authors, (:), message: "#article(authors) dictionary required")
  assert.eq(type(lang-data), dictionary, message: "#article(lang-data) required")
  
  import "@preview/transl:0.1.1": transl
  import "@preview/nexus-tools:0.1.0": get, storage, has, its, default
  import "sub/abbreviations.typ"
  
  transl(data: lang-data)
  
  let body = body
  let authors = authors
  let foreign = (title: none, subtitle: none, abstract: none, lang: none) + foreign
  let full-title = title + if subtitle != none {": " + lower(subtitle)}
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
    date: get.date( get.auto-val(date, datetime.today()) )
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
      value: (leading: 0.35em),
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
      value: (style: "assets/abnt.csl"),
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
  show raw: it => text(
    ..default(
      when: text.size == 11pt,
      value: (size: 9pt),
      typst-defaults
    ),
    ..default(
      when: text.font == "dejavu sans mono",
      value: (font: ("Fira Mono", "Inconsolata")),
      typst-defaults
    ),
    it
  )
  show raw.where(block: true): set par(leading: 0.45em)
  show ref: it => { 
      let el = it.at("element", default: none)
      
      // When referencing headings in "normal" form
      if el != none and el.func() == heading and it.form == "normal" {
        let post = transl("appendix", "annex", to: text.lang, data: lang-data)
        let data = el.supplement
        let pattern = "1.1.1.1.1"
        let space
        
        if el.numbering != none {
          if post.contains(el.supplement.at("text", default: "")) {
            pattern = "A." + pattern
          }
          
          space = if el.supplement != none {" "} else {""}
          data += space + numbering(
            pattern,
            ..counter(heading).at(el.location())
          )
        }
        else {data = el.body}
        
        link(el.location(), data)
      }
      else {it}
    }

  // Title
  {
    set text(hyphenate: false)
    
    heading(
      level: 1,
      outlined: false,
      numbering: none,
      align(center, full-title)
    )
    
    if foreign.title != none {
      assert.ne(foreign.lang, none, message: "#article(foreign.lang) must be set")
      
      if foreign.subtitle != none {foreign.title += ": " + foreign.subtitle}
      
      set text(lang: foreign.lang)
      
      // Foreign title, if any
      heading(
        level: 1,
        outlined: false,
        numbering: none,
        align(center, foreign.title)
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
  
  // Initialize abbreviations mechanism
  show: abbreviations.init
  
  // Abstract
  context {
    show heading: set align(center)
    
    heading(
      level: 1,
      numbering: none,
      transl("abstract")
    )
    
    // Try to get #abstract commands, fallback to #article abstract options
    let stored = storage.final("abstract", (:), namespace: "min-article")
    let abstract = (:)
    
    abstract += (main: stored.at("main", default: abstract))
    abstract += (foreign: stored.at("foreign", default: foreign.abstract))
    
    assert.ne(
      abstract.main, none,
      message: "#article(abstract) or #abstract('main') required"
    )
    
    abstract.main
    
    if abstract.at("foreign", default: none) != none {
      assert.ne(foreign.lang, none, message: "#article(foreign.lang) must be set")
      
      set text(lang: foreign.lang)
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
      args += entry.named()
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
    
    let title = transl("appendix", to: text.lang, data: lang-data)
    let data = storage.final("appendices").join()
    let kinds = data.children
      .filter(it => it.func() == figure and it.fields().keys().contains("kind"))
      .map(it => it.at("kind", default: ""))
      .dedup()
    let pattern = (
      title + " {1:A} — ",
      "{1:A}.{2:1} ",
      "{1:A}.{2:1}.{3:1} ",
      "{1:A}.{2:1}.{3:1}.{4:1} ",
      "{1:A}.{2:1}.{3:1}.{4:1}.{5:1} ",
    )
    
    set heading(
      numbering: numbly(..pattern, default: "A.1.1.1.1 "),
      supplement: title,
    )
    set figure(numbering: n => {
      let h = counter(heading).get().at(0)
      numbering("A1", h, n)
    })
    
    show heading.where(level: 1): it => {
      for kind in kinds {
        counter(figure.where(kind: kind)).update(0)
      }
      counter(figure.where(kind: raw)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: image)).update(0)
      counter(math.equation).update(0)
      
      align(center, it)
    }
    
    counter(heading).update(0)
     
    data
  }
  
  // Annex
  context if not its.empty( storage.final("annexes", (:)) ) {
    pagebreak(weak: true)
  
    import "@preview/numbly:0.1.0": numbly
    
    let title = transl("annex", to: text.lang, data: lang-data)
    let data = storage.final("annexes").join()
    let kinds = data.children
      .filter(it => it.func() == figure and it.fields().keys().contains("kind"))
      .map(it => it.at("kind", default: ""))
      .dedup()
    let pattern = (
      title + " {1:A} — ",
      "{1:A}.{2:1} ",
      "{1:A}.{2:1}.{3:1} ",
      "{1:A}.{2:1}.{3:1}.{4:1} ",
      "{1:A}.{2:1}.{3:1}.{4:1}.{5:1} ",
    )
    
    set heading(
      numbering: numbly(..pattern, default: "A.1.1.1.1 "),
      supplement: title,
    )
    set figure(numbering: n => {
      let h = counter(heading).get().at(0)
      numbering("A1", h, n)
    })
    
    show heading.where(level: 1): it => {
      for kind in kinds {
        counter(figure.where(kind: kind)).update(0)
      }
      counter(figure.where(kind: raw)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: image)).update(0)
      counter(math.equation).update(0)
      
      align(center, it)
    }
    
    counter(heading).update(0)
     
    data
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


/// = Commands

// At the end because they replace some Typst commands
#import "sub/abbreviations.typ": add as abbreviations
#import "sub/glossary.typ": add as glossary
#import "sub/cmd.typ" as cmd: figure, board
#import "sub/collectors.typ": *