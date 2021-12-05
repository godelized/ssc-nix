# Usage example

Project structure:

- `src`: [Hakyll](https://github.com/jaspervdj/hakyll) code,
- `www`: site web templates and data.

Create `default.nix` with:

```nix
{ pkgs ? import <nixpkgs> {} }:

let 
  inherit (pkgs) fetchFromGitHub;
  ssc = import (fetchFromGitHub {
    owner = "godelized";
    repo = "ssc-nix";
    rev = "40a6d0d82387154162f3ed4b67f340164aecfedf";
    sha256 = "0qys5x0km4h4d3rypdshnz7shsm4wfkl71mxpdwy62ac56f0g5rn";
  });
in ssc { 
  src = ./src;
}
```

```bash
# Build the static site compiler and append the binary to the PATH:
nix-build
export PATH="$PATH:$(realpath result/bin)"

# Go to the site web directory and run the compiler:
cd www
ssc watch
```
