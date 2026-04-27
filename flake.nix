{
  description = "Nixlab configuration for incus container";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks.url = "github:cachix/git-hooks.nix";
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops.url = "github:Mic92/sops-nix";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # ./hosts
        # ./modules
        ./formatter.nix
        ./git-hooks.nix
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
}
