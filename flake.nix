{
  description = "Flake for Node.js v22.5.1 with support for x86_64-linux and x86_64-darwin";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };
  outputs = { self, nixpkgs }: let
    systems = [ "x86_64-linux" "x86_64-darwin" ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
  in {
    packages = forAllSystems (system: let
      pkgs = import nixpkgs { inherit system; };
      nodejs = pkgs.stdenv.mkDerivation {
        pname = "nodejs";
        version = "22.5.1";
        src = pkgs.fetchurl {
          url = "https://nodejs.org/dist/v22.5.1/node-v22.5.1-${if system == "x86_64-darwin" then "darwin" else "linux"}-x64.tar.gz";
          sha256 = if system == "x86_64-darwin"
            then "sha256-astFM7wKQ6Ro+Qu9SSMKoWx8V7KjRR7+Ahdf7qNGdU0"
            else "sha256-KnuLiqXHOa5VIz1Z94c2kRqKXaXqHGPw6EPaJw0DlJk";
        };
        buildInputs = [ pkgs.stdenv ];
        installPhase = ''
          mkdir -p $out
          cp -r * $out/
        '';
      };
    in {
      default = nodejs;
    });
  };
}
