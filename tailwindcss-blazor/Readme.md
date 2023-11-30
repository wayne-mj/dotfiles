## Tailwind CSS and Blazor WASM

### About and how to use

This is a small shell script to help automate the creation and modification of .Net Blazor Wasm application to use Tailwind CSS rather than Bootstrap.

Since using Tailwind with NextJS and HTML in general, I have found that whilst the learning curve is steep, the functionality and flexibility of use when designing mobile, small screen, and desktop applications/websites make it more intuitive once the foundations have been learnt.  


```bash
$ tailwindcss.sh
```

If the current directory is empty, it will create a .Net 7 Blazor Wasm Empty project, if it contains an existing Blazor Wasm project it will:
- install tailwindcss via npm
- configure tailwindcss
- create the tailwindcss style sheet file
- modify index.html to use the new style sheet
- create a shell script to wrap the command necessary to run the tailwindcss processor.

```bash
$ tailwindcss.sh [projectname]
```

Similar to the above, but will create the directory if it does not exist, or change to it prior to executing the remaining instructions.

## Caveats

It has been tested on .Net 6 and .Net 8 Blazor Wasm projects, it does work with some effort.
