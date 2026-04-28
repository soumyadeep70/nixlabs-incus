{
  inputs,
  ...
}:
{
  imports = with inputs; [ treefmt.flakeModule ];

  perSystem = _: {
    treefmt = {
      projectRootFile = "flake.nix";

      settings.excludes = [
        "*.lock"
        ".gitignore"
        "secrets/*"
      ];

      programs = {
        deadnix.enable = true;
        statix.enable = true;
        nixfmt.enable = true;
        mdformat = {
          enable = true;
          excludes = [
            ".github/**/*.md"
          ];
        };
        shfmt.enable = true;
        shellcheck = {
          enable = true;
          includes = [
            "*.sh"
            ".envrc"
          ];
        };
        actionlint.enable = true;
      };
    };
  };
}
