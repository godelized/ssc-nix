# Usage example

Project structure:

- `src`: [Hakyll](https://github.com/jaspervdj/hakyll) code,
- `www`: site web templates and data,
- `default.nix`: the following nix expression.

Say our Hakyll code uses `rustfmt` to format some Rust snippets before rendering it.
The following nix expression can setup and run the static site generator with its external dependencies with a simple command:

```bash
nix run -c sh -c 'cd www; ssc watch'
```

```nix
# default.nix:
{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) fetchFromGitHub;
  ssc = import (fetchFromGitHub {
    owner = "godelized";
    repo = "ssc-nix";
    rev = "8e22903e9e85cc1b29c585e680479ed5ce19f157";
    sha256 = "0isy5frb1w9ccmbizh8sw63z7afzyrss28w3i43ydg7kn68v5hqz";
  }) {
    src = ./src;
  };
in with pkgs; [ ssc rustfmt ]
```
