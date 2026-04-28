{
  lib,
  inputs,
  self,
  withSystem,
  ...
}:
let
  hostDirs = builtins.attrNames (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./.)
  );

  hosts = lib.listToAttrs (
    map (
      name:
      let
        dir = ./${name};
        specs =
          if builtins.pathExists (dir + "/specs.toml") then
            fromTOML (builtins.readFile (dir + "/specs.toml"))
          else
            throw "specs.toml doesn't exist";
      in
      {
        inherit name;
        value = {
          system = "${specs.core.arch}-linux";
          config = import dir;
          inherit specs;
        };
      }
    ) hostDirs
  );
in
{
  flake.nixosConfigurations = lib.mapAttrs (
    _name: cfg:
    inputs.nixpkgs.lib.nixosSystem (
      withSystem cfg.system (
        { self', inputs', ... }:
        {
          specialArgs = {
            inherit (cfg) specs;
            inherit inputs self;
          };

          modules = [
            "${inputs.nixpkgs}/nixos/maintainers/scripts/incus/incus-container-image.nix"
            self.nixosModules.default
            {
              _module.args = { inherit self' inputs'; };
              nixpkgs.hostPlatform = cfg.system;
            }
            cfg.config
          ];
        }
      )
    )
  ) hosts;
}
