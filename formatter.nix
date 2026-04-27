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

        settings = {
          global.excludes = [
            "*.age"
          ];
          shellcheck.includes = [
            "*.sh"
            ".envrc"
          ];
          prettier.editorconfig = true;
        };

        programs = {
          deadnix.enable = true;
          statix.enable = true;
          nixfmt.enable = true;

          prettier.enable = true;
          yamlfmt.enable = true;
          jsonfmt.enable = true;
          mdformat.enable = true;
          shfmt.enable = true;
          shellcheck.enable = true;
          actionlint.enable = true;
        };
      };
    };
}
