/**
== Abstract
```typ
#abstract(
  type,
  body
)
```
Collects abstract data. Also set using the `#article(abstract, foreign-abstract)`
options. The main abstract is required by ABNT, while the foreign abstract is
optional. Can be used multiple times anywhere in the source code.

type <- string
  The abstract defined: `"main"` or `"foreign"` — if bot set, fallback to `"main"`.

An abstract is a general resume of the entire article content.
**/
#let abstract(..args) = {
  import "@preview/nexus-tools:0.1.0": storage, content2str
  
  assert.ne(args.pos().len(), 0, message: "#abstract(body) required")
  
  let args = args.pos()
  let abstr = (:)
  let kind
  let body
  
  // Insert "main" kind when omitted
  if args.len() == 1 {args.insert(0, "main")}
  
  kind = content2str(args.at(0))
  body = args.slice(1).join(" ")
  
  abstr.insert(kind, body)
  
  assert(
    ("main", "foreign").contains(kind),
    message: "Invalid #article(" + str(type) + ") kind"
  )
  
  storage.add("abstract", abstr, append: true, namespace: "min-article")
}


/**
== Bibliography
:bibliography:
Collects bibliography data, replacing the original `#bibliography` command. Can
be used multiple times anywhere in the source code.

args.named() <- arguments
  #let docs = "https://typst.app/docs/reference/model/bibliography#parameters"
  Any arguments supported by the original #url(docs)[`#bibliography`] command.

args.pos() <- arguments
  Content (not paths) of one or more bibliography files. Use `#read` or strings.
**/
#let bibliography(..args) = {
  import "@preview/nexus-tools:0.1.0": storage
  
  storage.add("bibliography", args, append: true, namespace: "min-article")
}


/**
== Appendix
:appendix:
Collects appendix data. Inside it, each level 1 heading starts a new appendix by
itself. Can be used multiple times anywhere in the source code.

data <- content
  The appendix content.

An appendix is any additional data left out of the main article content but
referenced or related to it.
**/
#let appendix(data) = {
  import "@preview/nexus-tools:0.1.0": storage
  
  storage.add("appendices", data, append: true, namespace: "min-article")
}


/**
== Annex
:appendix:
Collects annex data. Inside it, each level 1 heading starts a new annex by
itself. Can be used multiple times anywhere in the source code.

data <- content
  The annex content.

An annex is any third-party data referenced or related to the article content.
**/
#let annex(data) = {
  import "@preview/nexus-tools:0.1.0": storage
  
  storage.add("annexes", data, append: true, namespace: "min-article")
}


/**
== Acknowledgments
:acknowledgments:
Collects acknowledgments data. Also set using the `#article(acknowledgments)`
option. Can be used multiple times anywhere in the source code.

data <- content
  The appendix content.

An acknowledgments is a final thanks directed to anyone important in the
creation of the article.
**/
#let acknowledgments(data) = {
  import "@preview/nexus-tools:0.1.0": storage
  
  storage.add("acknowledgments", data, append: true, namespace: "min-article")
}