{
  lib,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

      settings = {
        trusted-users = [ "@wheel" ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        # disable global registry
        flake-registry = "";

        connect-timeout = 5;
        log-lines = 25;
        min-free = 1073741824;
        max-free = 5368709120;
        fallback = true;
        auto-optimise-store = true;
        warn-dirty = false;

        substituters = [
          "https://nix-community.cachix.org"
          "https://cache.flox.dev"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
        ];
      };

      channel.enable = false;
    };
}
