let
  nixpkgs = import <nixpkgs> { };
in
with nixpkgs;
stdenv.mkDerivation {
  name = "tokio-docker-env";
  buildInputs = [
    rustup
    pkgconfig
    openssl.dev
    nix
  ];
  OPENSSL_DEV = openssl.dev;
}
