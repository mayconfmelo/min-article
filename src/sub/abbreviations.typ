/**
= Abbreviations Command
```typ
#abbreviations(data)
```
Collects abbreviation and glossary data. All abbreviations found in the article
content (case-insensitive) are automatically replaced as required by ABNT. Can
be used multiple times anywhere in the source code.

data <- dictionary
  `(abbrev: long)`\
  `(abbrev: (long, definition))`\
  Set each abbreviation and its long name; optionally, a glossary definition can
  be also set.

ABNT requires that an abbreviation must appear like _abbreviation (abbrev)_ the
first time, and just _abbrev_ the next times.
**/
#let add(data) = {
  import "@preview/toolbox:0.1.0": storage
  
  assert.eq(
    type(data), dictionary,
    message: "#abbreviations(data) must be dictionary"
  )
  
  for key in data.keys() {
    let item = data.at(key, default: ())
    let this = (:)
    
    if type(item) != array {item = (item,)}
    
    if item.len() > 1 {this.insert("def", item.slice(1).join(" "))}
    
    this.insert("long", item.at(0))
    this.insert("abbrev", true)
    
    data.at(key) = this
  }
  storage.add("glossary", data, append: true, namespace: "min-article")
}


// Initialize abbreviation replacement mechanism.
#let init(insensitive: true, body) = context {
  import "@preview/toolbox:0.1.0": storage
  
  let stored = storage.final("glossary", (:), namespace: "min-article")
  let body = body
  let i = if insensitive {"(?i)"} else {""}
  
  for (abbrev, value) in stored {
    if not value.abbrev {continue}
    
    let re = i + "\b" + abbrev + "\b"
    let first = state("abbrev-first-use-" + abbrev, true)
    
    body = {
      show regex(re): it => context {
        if first.get() [#value.long (#abbrev)] else {abbrev}
        first.update(false)
      }
      body
      first.update(none)  // clean temporary state
    }
  }
  return body
}