# Minimal articles

<center>
  Simple and easy way to write ABNT-compliant articles
</center>

# Quick Start

```typst
#import "@preview/min-article:0.1.0": article
#show: article.with(
  title: "Main Title",
  subtitle: "Complementary subtitle",
  foreign-title: "Título Principal",
  foreign-subtitle: "Subtítulo complementar",
  authors: (
    ("Main Author", "Doctor in Procrastination, etc, etc."),
    ("Main Collaborator", "Graduate in Doing Nothing, etc, etc."),
    ("Collaborator", "Student of Procrastination, etc, etc.")
  ),
  lang-foreign: "pt"
)
```

# Description

Generate a authentic, structured, and standard articles, compliant with the
of ABNT (Brazilian Association of Technical Norms) requirements. The main
differential of this package, apart from the ABNT standard, is being able to
manage, all by itself, almost all of that mind-frying document structuration
and its little rules: just input the data at any place, and _min-article_ will
find where it belongs in the article, will and put it there.

# Setup

## Final use

This project uses `just` to automate all development processes. To install
the package to the default _preview_ release namespace, ideal to final use, run:

```bash
just install preview
```

and to uninstall it, use `just remove preview`.

## Development tests

To install the package in a separated _local_ test namespace, ideal to development
tests, run:

```bash
just install local
```

and to uninstall it, use `just remove preview`. To install both _local_ and
_preview_ at the same time, use `just install-all`.

## Development

And finally, it is possible to generate a direct symbolic link between this
project and the package _local_ namespace under the special _0.0.0_ version
— this way, every change made in these source files will be imediatelly available
in Typst through `local:0.0.0` imoport. To use it, run:

```bash
just dev-link
```

This command is a toggle: the first time you run it, the link is installed; the
second time, the link is removed; and so on.

# Manual and Examples

The `docs/manual.typ` and `docs/manual-pt.typ` are the official _min-article_
documentation. They are available as pre-compiled PDFs in `docs/` folder, and
can be locally compiled with:

```bash
just manual
```

and the Brazilian version:

```bash
just manual-pt
```

As for examples, they are in `docs/assets/example.typ` and can be compiled too,
with:

```bash
just compile
```

or be watched, with:

```bash
just watch
```