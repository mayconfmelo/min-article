#let abstract(..args) = {
  import "@preview/toolbox:0.1.0": storage
  
  args = args.pos()
  
  assert(
    (1, 2).contains(args.len()),
    message: "Supported #abstract(type, body) or #abstract(body)"
  )
  
  // Insert args.pos().at(1) = "main" if none is set
  if args.len() == 1 {args.insert(0, "main")}
  
  let abstr = (:)
  
  abstr.insert(..args)
  
  assert(
    ("main", "foreign").contains(args.at(0)),
    message: "Invalid type #article(" + str(type) + ")"
  )
  
  storage.add("abstract", abstr, append: true, namespace: "min-article")
}


#let bibliography(..args) = {
  import "@preview/toolbox:0.1.0": storage
  
  storage.add("bibliography", args, append: true, namespace: "min-article")
}


#let appendix(data) = {
  import "@preview/toolbox:0.1.0": storage
  
  storage.add("appendices", data, append: true, namespace: "min-article")
}


#let annex(data) = {
  import "@preview/toolbox:0.1.0": storage
  
  storage.add("annexes", data, append: true, namespace: "min-article")
}


#let acknowledgments(data) = {
  import "@preview/toolbox:0.1.0": storage
  
  storage.add("acknowledgments", data, append: true, namespace: "min-article")
}