{
  inputs,
  lib,
  specs,
  ...
}:
{
  imports = [
    inputs.sops.nixosModules.sops
  ];

  users.groups."secrets".members = lib.singleton specs.core.user.name;

  sops.age.keyFile = "/home/cypher/.config/sops/age/keys.txt";
}
