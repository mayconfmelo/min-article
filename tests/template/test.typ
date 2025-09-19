#import "/src/lib.typ"

#let doc = read("/template/main.typ")
#let doc = doc.replace(regex("#import.*?min-article.*"), "")
#let doc = doc.replace(
  regex("(read|image|bibliography|include)\(\"/?"),
  m => m.captures.at(0) + "(\"/template/"
)

#eval(
  "[" + doc + "]",
  scope: dictionary(lib)
)