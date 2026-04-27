{
  lib,
  specs,
  ...
}:
{
  config = lib.mkIf specs.services.caddy.enable {
    services.caddy.enable = true;

    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
