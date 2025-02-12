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
find where it belongs in the article, and will put it there.


# More Information

- [Official manual](docs/pdf/manual.pdf)
- [Official manual (Portuguese)](docs/pdf/manual-pt.pdf)
- [Example Result](docs/pdf/example.pdf)
- [Example Code](docs/assets/example.typ)


# Setup

This project uses `just` to automate all development processes. Run `just` or
refer to the _justfile_ for more information.


## Release

Install the package in default _preview_ namespace:

```
just install preview
```

To uninstall it:

```
just remove preview
```


## Testing

Install the package in a separated _local_ namespace:

```
just install local
```

To uninstall it:

```
just remove local
```

The command `just install-all` installs it in both _preview_ and _local_
namespaces at the same time.


## Development

Create a direct symbolic link between this project and and the _local_ namespace,
under a special _0.0.0_ version:

```
just dev-link
```

This way, every change made into the package will instantly be available to 
Typst by using a `@local/min-article:0.0.0` import.

This command is a toggle: run it once, and it creates the link; run it again and
the link is removed; and so on.