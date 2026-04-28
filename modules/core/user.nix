{
  specs,
  ...
}:
let
  username = specs.core.user.name;
  userDescription = specs.core.user.description;
  userHashedPassword = specs.core.user.hashedPassword;
in
{
  users.mutableUsers = false;
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    hashedPassword = userHashedPassword;
    extraGroups = [ "wheel" ];
  };

  security.sudo.extraConfig = ''
    Defaults lecture=never
    Defaults timestamp_timeout=30
  '';

  home-manager.users.${username} = {
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      stateVersion = specs.core.homeStateVersion;
    };
  };
}
