{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "x86_64-linux" ];
      perSystem = { self, pkgs, ... }: {
        packages = {
          default = pkgs.stdenv.mkDerivation {
            name = "nodejs22.5.1";
            src = pkgs.fetchurl {
              url = "https://nodejs.org/dist/v22.5.1/node-v22.5.1-linux-x64.tar.gz";
              sha256 = "sha256-KnuLiqXHOa5VIz1Z94c2kRqKXaXqHGPw6EPaJw0DlJk=";
            };
            installPhase = ''
              echo "installing nodejs"
              mkdir -p $out
              cp -r ./ $out/
            '';
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.gnused
            pkgs.yarn
            self.packages.default
            pkgs.nodePackages.node-gyp-build
            pkgs.nodePackages.kafkajs
          ];
        };
      };
    };
}
