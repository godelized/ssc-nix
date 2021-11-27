{
  pkgs ? import <nixpkgs> {},
  src ? ./src,
  extraHaskellPackages ? _: [],
}:

let 
  inherit (pkgs) stdenv;
in
stdenv.mkDerivation rec {
  inherit src;
  pname = "ssc";
  version = "0.1";
  nativeBuildInputs = with pkgs; [ makeWrapper ];
  buildInputs = with pkgs; [ (haskellPackages.ghcWithPackages (p: [ p.hakyll ] ++ extraHaskellPackages p)) ];
  buildPhase = ''
    mkdir -p $out/bin
    ghc -dynamic --make site.hs -o "$out/bin/${pname}"
  '';
  installPhase = ''
      wrapProgram $out/bin/${pname} \
          --set LANG "en_US.UTF-8" \
          --set LOCALE_ARCHIVE "${pkgs.glibcLocales}/lib/locale/locale-archive"
  '';
}
