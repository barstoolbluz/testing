{
  description = "Flake for Node.js v22.5.1";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    packages = {
      x86_64-linux = let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        nodejs = pkgs.stdenv.mkDerivation {
          pname = "nodejs";
          version = "22.5.1";
          src = pkgs.fetchurl {
            url = "https://nodejs.org/dist/v22.5.1/node-v22.5.1-linux-x64.tar.gz";
            sha256 = "sha256-KnuLiqXHOa5VIz1Z94c2kRqKXaXqHGPw6EPaJw0DlJk";
          };
          buildInputs = [ pkgs.stdenv ];
          installPhase = ''
            mkdir -p $out
            cp -r * $out/
          '';
        };
      in
      { 
        default = nodejs;
      };
    };
  };
}
