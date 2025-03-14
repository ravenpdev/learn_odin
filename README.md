Compile and run it using odin run <dir>. For the current directory:

```bash
odin run .
```

The run command compiles the .odin file to an executable and then runs that executable after compilation.

If you do not wish to run the executable after compilation, the build command ca be used:

```bash
odin build <dir>
```

Odin thinks in terms of directory-based packages. To tell it to treat a single file as a standalone package, add -file, like so:

```bash
odin run main.odin -file
```
