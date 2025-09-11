
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
    message: "Invalid #article(" + str(type) + ")"
  )
  
  storage.add("abstract", abstr, append: true)
}


#let bibliography(..args) = {
  import "@preview/toolbox:0.1.0": storage
  
  storage.add("bibliography", args, append: true)
}


// Captures appendices to feed `article-appendices` state.
#let appendix(data) = context {
  import "@preview/toolbox:0.1.0": storage
  
  storage.add("appendices", data, append: true)
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
