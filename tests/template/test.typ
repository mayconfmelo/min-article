#import "/src/lib.typ"

#let doc = read("/template/main.typ")
#let doc = doc.replace(regex("#import.*?min-article.*"), "")
#let doc = doc.replace(
  regex("(yaml|read|include|image)\(\"/?"),
  m => m.captures.at(0) + "(\"/template/"
)

#eval(
  "[\n" + doc + "\n]",
  scope: dictionary(lib)
)