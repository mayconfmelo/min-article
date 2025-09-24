// NAME: Manual for min-article

#import "@preview/min-manual:0.2.1": manual, arg, univ, url

#show: manual.with(
  title: "Minimal Articles",
  description: "Simple and easy way to write ABNT-compliant articles.",
  authors: "Maycon F. Melo <@mayconfmelo>",
  package: "min-book:0.1.1",
  license: "MIT",
  logo: image("docs/assets/manual-logo.png"),
  from-comments:
    read("src/lib.typ") +
    read("src/sub/collectors.typ") +
    read("src/sub/abbreviations.typ") +
    read("src/sub/glossary.typ") +
    read("src/sub/cmd.typ")
)


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.