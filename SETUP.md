
# Setup

This project uses `just` to automate all development processes. Run `just` or
refer to the _justfile_ for more information.


## Release

Install the package in default _preview_ namespace:

```
just install preview
```

To uninstall:

```
just remove preview
```


## Testing

Install the package in a separated _local_ namespace:

```
just install local
```

To uninstall:

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


-------------------------

## Other Usefull Commands

Install the package in `dev/pkg/` for debug purposes:

```
just install pkg
```

Compile or watch the example file in `template/main.typ`:

```
just compile
```

or:

```
just watch
```

Compile the official manual:

```
just manual
```

or the official Brazilian manual:

```
just manual-pt
```


