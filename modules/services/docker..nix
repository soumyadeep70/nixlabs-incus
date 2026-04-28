{
  lib,
  specs,
  ...
}:
{
  config = lib.mkIf specs.services.docker.enable {
    virtualisation.docker.enable = true;
    users.groups."docker".members = lib.singleton specs.core.user.name;
  };
}
