// Article Manual

#import "@preview/min-manual:0.1.0": manual, arg, univ

#show: manual.with(
  title: "Minimal Articles",
  description: "Simple and easy way to write ABNT-compliant articles",
  authors: "Maycon F. Melo <https://github.com/mayconfmelo>",
  cmd: "min-article",
  version: "0.1.0",
  license: "MIT",
  toc: true,
  logo: image("assets/manual-logo.png")
)

#pagebreak()

= Quick Start

```typ
#import "@preview/min-article:0.1.0": article
#show: article.with(
	title: "Main Title",
	subtitle: "Complementary subtitle",
	foreign-title: "Título Principal",
	foreign-subtitle: "Subtítulo complementar",
	authors: (
	  ("Main Author", "PhD in Procrastination, etc."),
	  ("Main Collaborator", "Degree in Doing Nothing, etc."),
	  ("Collaborator", "Procrastination Student, etc.")
	),
	lang-foreign: "pt"
)
```

= Description

Generate authentic, structured, and standardized articles, compliant with the
requirements of the Brazilian Association of Technical Standards (ABNT, in
Portuguese). The main advantage of this package, apart from the ABNT standard,
is being able to manage, all by itself, almost all the mind-frying document
structure and its rules: just input the data anywhere and _min-article_ will
find where it belongs, and will put it there.

This manual will be updated only when new versions break or modify something;
otherwise, it will be valid to all newer versions starting by the one documented
here.

= Options

Those are the full list of options available and its default values:

```typm
#show: book.with(
  title: none,
  foreign-title: none,
  subtitle: none,
  foreign-subtitle: none,
  authors: none,
  abstract: none,
  foreign-abstract: none,
  acknowledgments: none,
  date: auto,
  paper: "a4",
  lang: "en",
  lang-foreign: none,
  lang-data: toml("assets/lang.toml"),
  justify: true,
  line-space: 0.3em,
  par-margin: 1.5em,
  margin: (
    top: 3cm,
    bottom: 2cm,
    left: 3cm,
    right: 2cm
  ),
  font: ("Book Antiqua", "Times New Roman"),
  font-size: 12pt,
)
```

Seems like an awful lot to start with, but let's just break down all this to
understand it better, shall we?

#arg(
  "title:", ("string", "content"),
  required: true
)[
  The article title in the main language.
]

#arg(
  "foreign-title:", ("string", "content")
)[
  The article title in a foreign language --- generally a _lingua franca_.
]

#arg(
  "subtitle:", ("string", "content", "none")
)[
  The article subtitle; generally two lines long or less.
]

#arg(
  "foreign-subtitle:", ("string", "content", "none")
)[
  The article main subtitle in a foreign language --- generally a _lingua franca_.
]

#arg(
  "authors:", "array",
  required: true
)[
  An array of arrays containing the name and brief curriculum of each author, in
  format `( (NAME, CV), (NAME, CV) )`. If a plain array is set, the
  first element will be treated as `NAME` and the second one, as `RÉSUMÉ`.
]

#arg(
  "abstract:", "content"
)[
  The ugly way to define the abstract --- a formal resume of everything
  the document talks about. It is prettier and more intuitive to use the
  `#abstract("main")` command instead.
]

#arg(
  "foreign-abstract:", "content"
)[
  The ugly way to define the foreign abstract. It is prettier and more
  intuitive to use the `#abstract("foreign")` command instead.
]

#arg(
  "acknowledgments:", "content"
)[
  The ugly way to define the acknowledgments — the text with final thanks.
  It is prettier and more intuitive to use the `#acknowledgments` command
  instead.
]

#arg(
  "date:", ("array", "datetime")
)[
  The article publication date, in format `(yyyy, mm, dd)`. Fallback to today's date if not set, or set to `auto`.
]

#arg(
  "paper:", "string"
)[
  Defines the page paper type --- and its size, therefore.
]

#arg(
  "lang:", "string"
)[
  Defines the main language, used on the full text.
]

#arg(
  "foreign-lang:", "string"
)[
  Defines the foreign language, used on the foreign title and abstract.
]

#arg(
  "lang-data:", "file"
)[
  Defines a custom #univ("linguify") file with translations for the automatically created
  headings. The default file have officially full support for English and Portuguese,
  as well as some other languages through AI translation.
]

#arg(
  "justify:", "boolean"
)[
  Defines if the text will have justified alignment.
]

#arg(
  "line-space:", "length"
)[
  Defines the space between lines in the document.
]

#arg(
  "par-margin:", "length"
)[
  Defines the margin space after each paragraph. Set it the same as `line-space`
  to remove get paragraphs without additional space in between.
]

#arg(
  "margin:", "length"
)[
  Defines the document margins.
]

#arg(
  "font:", ("string", "array")
)[
  Defines the font families used for the text: a principal font and its fallback.
]

#arg(
  "font-size:", "length"
)[
  Defines the size of the text in the document.
]

#pagebreak()


= Abstract command

```typ
#import "@preview/min-article:0.1.0": abstract
#abstract(
  type,
  body
)
```

This is the best way to define the article abstracts. This commands just
captures the abstract content and feed it to the `article` command, where the
abstracts are actually generated. Because of that, you can put this command
anywhere inside the document body and it will be generated in the right place,
right after the titles, as the ABNT NBR 6022 determines.


#arg(
  "type", "string",
  required: true
)[
  Defines which abstract this is: the `"main"` abstract, or the `"foreign"`
  abstract; only those two string values are accepted.
]

#arg(
  "body", "content",
  required: true
)[
  The abstract content.
]


= Abbreviations command

```typ
#import "@preview/min-article:0.1.0": abbrev
#abrev(
  abbreviation,
  long,
  definition
)
```

This command manages abbreviations as the ABNT NBR 14724 requires: The first
time it is used, print the full long name and its abbreviation between
parenthesis; from then on, when is used again with the same abbreviation, it will
print just the abbreviation. Additionally, every new abbreviation is collected to
be used in a automatically generated glossary, along with a optional definition
of the abbreviation and its long name.

#arg(
  "abbreviation", ("string", "content"),
  required: true
)[
  The abbreviation itself. Does not support any styling, quotes, or
  apostrophes. Is recommended to use just lowercase letters --- automatically
  turned uppercase, --- and do any needed stylization outside the `#abbrev` command.
]

#arg(
  "long", ("string", "content"),
)[
  The long name that the abbreviation represents.
]

#arg(
  "definition", ("string", "content"),
)[
  An optional definition, used in the glossary. When no definition is set,
  the long name is used as definition.
]


= Glossary term command

```typ
#import "@preview/min-article:0.1.0": gloss
#gloss(
  term-name
  definition
)
```

This commands works alongside `#abbrev` collecting terms for a automatically
generated glossary. While `abbrev` only collects abbreviations, `gloss` can
collect any word or expression. It just retrieves the data and then prints the
term in the place where the command is written; later, the `article` command use
this data to generate an automatic glossary after the main text body, as the
ABNT NBR 6022 determines. If no data is collected by neither `gloss` nor
`abbrev`, no glossary is generated.

#arg(
  "term-name", ("string", "content"),
  required: true
)[
  The name of the glossary term; it is what will be defined. If the name,
  have any fancy characters like apostrophes or quotes, is recommended to use
  a string instead of content.
]

#arg(
  "definition", ("string", "content"),
  required: true
)[
  A concise and descriptive text about the `term-name`; it is what defines the
  glossary term.
]


= Appendix command

```typ
#import "@preview/min-article:0.1.0": appendix
#appendix(
  appendix
)
```

This command just captures appendices given to it along the text body and feed
them to the `article` command, where the appendices are actually generated.
Because of that, you can put this command anywhere inside the document body and
it will be generated in the right place, right after the  glossary, if any, as
the ABNT NBR 6022 determines. It is possible to use the command multiple times
to collect multiple appendices. Appendices are additional data and information
not included in the document itself, but cited or related to it.

#arg(
  "appendix", "content",
  required: true
)[
  The appendix content itself. In longer documents, is recommended to use
  separated _typ_ files for appendices. Inside the content, each level 1 heading
  is treated as a new appendix.
]


= Annex command

```typ
#import "@preview/min-article:0.1.0": annex
#annex(
  annex
)
```

This command just captures the annexes given to it along the text body and feed
them to the `article` command, where the annexes are actually generated.
Because of that, you can put this command anywhere inside the document body and
it will be generated in the right place, right after the appendices, if any, as
the ABNT NBR 6022 requires. It is possible to use the command multiple times to
collect multiple annexes. Annexes are third-party documents or data cited or
related to the actual document.

#arg(
  "annex", "content",
  required: true
)[
  The annex content itself. In longer documents, is recommended to use
  separated _typ_ file for annexes. Inside the content, each level 1 heading is
  treated as a new annex.
]


= Acknowledgments command

```typ
#import "@preview/min-article:0.1.0": acknowledgments
#acknowledgments(
  thanks
)
```

This command just captures the acknowledgments content and feed it to the
`article` command, where the acknowledgments section is actually generated.
Because of that, you can put this command anywhere inside the document body and
it will be generated in the right place, right at the very end of the document
as the ABNT NBR 6022 determines. Acknowledgments is a text used to thank and
recognize the worth of people with important roles in the creation of the article.


= Figure command

```typ
#import "@preview/min-article:0.1.0": figure
#figure(
  source: none,
  alignment: center,
  ..figure-arguments
)
```

This command shadows the default `#figure` command to add two arguments to it.
The ABNT NBR 6022 requires that all figures have a caption above it and its
source below, and this command allows this by adding the `source` argument; the
other argument, `alignment`, is just syntax sugar to align the figure using
less code.

#arg(
  "source:", ("string", "content"),
  required: true
)[
  The source of the information displayed in the figure --- even if is the author
  itself. Generally, is a bibliographical reference.
]

#arg(
  "alignment:", "alignment",
  required: true
)[
  A sintatic sugar to align the figure in the page with less code.
]

#arg(
  "..figure-arguments", "argument",
  required: true
)[
  Any of the default original `#figure` arguments, all of them are supported
  in this command.
]


= A Note On Bibliography

Unfortunately, there is no way to load the bibliography file to let
_min-article_ deal with it and generate the Bibliography in the right place.
So this is up to you. This means if you insert the command in some place, it
will appear in the place where it was written and not in the right place
automatically. I'm looking forward to workaround this issue, but seems like this
is a limitation of Typst itself.

Because of this limitation, write the `bibliography` command after the end of
all text content and it will appear at the right place, as ABNT NBR 6022 requires:
after the text and before the glossary, if any.


= Translations

This package uses #univ("linguify") to translate the headings automatically generated.
Currently, it offers support to English and Portuguese, and some other languages
through IA translations. If your language is not supported, or wrongly translated by
IA, consider contributing to this project by helping in the translation.

#pagebreak()


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.

This project does not have any association with the Associação Brasileira de Normas
Técnicas, and the --- costly --- norms cited here are all property of ABNT. This is
not an official project.