{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "where-the-nixpkg";
  src = ./.;

  buildInputs = [
    pkgs.makeWrapper
  ];

  installPhase = ''
    install -D -m555 -t $out/bin where-the-nixpkg

    wrapProgram $out/bin/where-the-nixpkg \
      --prefix PATH : ${pkgs.lib.makeBinPath [
        pkgs.nix
        pkgs.perl
      ]}
  '';
}
