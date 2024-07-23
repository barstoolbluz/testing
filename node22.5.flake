{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = {
          nodejs22 = pkgs.stdenv.mkDerivation {
            name = "nodejs22.5.1";
            src = pkgs.fetchurl {
              url = "https://nodejs.org/dist/v22.5.1/node-v22.5.1-linux-x64.tar.gz";
              sha256 = "sha256-2a7b8b8aa5c739ae55233d59f78736911a8a5da5ea1c63f0e843da270d039499";
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
            self'.packages.nodejs22
            pkgs.nodePackages.node-gyp-build
            pkgs.nodePackages.kafkajs          ];
        };
      };
      flake = {
      };
    };
}
