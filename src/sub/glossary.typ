#let add(data) = {
  import "@preview/toolbox:0.1.0": storage
  
  assert.eq(
    type(data), dictionary,
    message: "#glossary(data) must be dictionary"
  )
  
  for key in data.keys() {
    let item = data.at(key)
    let this = (:)
    
    this.insert("def", item)
    this.insert("abbrev", false)
    
    data.at(key) = this
  }
  storage.add("glossary", data, append: true, namespace: "min-article")
}


#let insert() = context {
  import "@preview/toolbox:0.1.0": storage
  
  set terms(separator: linebreak(), tight: true)
  
  let stored = storage.final("glossary", (:), namespace: "min-article")
  
  for entry in stored.keys().sorted() {
    let entry = upper(entry.at(0)) + entry.slice(1)
    let value = stored.at(entry)
    
    if not value.abbrev {value = value.def}
    else {
      value = if value.def != () {value.def} else {value.long}
    }
    block(breakable: false, terms.item(entry, [#value]))
  }

}