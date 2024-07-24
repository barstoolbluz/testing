{
  description = "Flake for Node.js v22.5.1 with support for x86_64-linux and x86_64-darwin";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.stdenv.mkDerivation {
        pname = "nodejs";
        version = "22.5.1";
        src = pkgs.fetchurl {
          url = "https://nodejs.org/dist/v22.5.1/node-v22.5.1-linux-x64.tar.gz";
          sha256 = "sha256-KnuLiqXHOa5VIz1Z94c2kRqKXaXqHGPw6EPaJw0DlJk";
        };
        installPhase = ''
          mkdir -p $out
          tar -xzf $src -C $out --strip-components=1
        '';
      };
    packages.x86_64-darwin.default =
      let
        pkgs = import nixpkgs { system = "x86_64-darwin"; };
      in
      pkgs.stdenv.mkDerivation {
        pname = "nodejs";
        version = "22.5.1";
        src = pkgs.fetchurl {
          url = "https://nodejs.org/dist/v22.5.1/node-v22.5.1-darwin-x64.tar.gz";
          sha256 = "sha256-astFM7wKQ6Ro+Qu9SSMKoWx8V7KjRR7+Ahdf7qNGdU0";
        };
        installPhase = ''
          mkdir -p $out
          tar -xzf $src -C $out --strip-components=1
        '';
      };
  };
}
