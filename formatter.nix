{
  inputs,
  ...
}:
{
  imports = with inputs; [ treefmt.flakeModule ];

  perSystem =
    { config, pkgs, ... }:
    {
      formatter = config.treefmt.build.wrapper;

      treefmt = {
        package = pkgs.treefmt;
        flakeCheck = true;
        flakeFormatter = true;
        projectRootFile = "flake.nix";

        settings.excludes = [
          "*.age"
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
