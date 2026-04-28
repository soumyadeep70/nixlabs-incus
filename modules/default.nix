{
  lib,
  ...
}:
let
  importModulesRecursive =
    path:
    lib.flatten (
      lib.mapAttrsToList (
        name: type:
        if lib.hasPrefix "_" name then
          [ ]
        else if type == "regular" && lib.hasSuffix ".nix" name then
          [ (path + "/${name}") ]
        else if type == "directory" then
          importModulesRecursive (path + "/${name}")
        else
          [ ]
      ) (builtins.readDir path)
    );

  importModules =
    path:
    lib.flatten (
      lib.mapAttrsToList (
        name: type:
        if name == "default.nix" || name == "services" || lib.hasPrefix "_" name then
          [ ]
        else if type == "regular" && lib.hasSuffix ".nix" name then
          [ (path + "/${name}") ]
        else if type == "directory" then
          importModulesRecursive (path + "/${name}")
        else
          [ ]
      ) (builtins.readDir path)
    );
in
{
  flake.nixosModules.default =
    {
      inputs,
      inputs',
      self,
      self',
      ...
    }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ]
      ++ importModules ./.;

      home-manager = {
        extraSpecialArgs = {
          inherit
            inputs
            inputs'
            self
            self'
            ;
        };
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
}
