{
  inputs,
  lib,
  ...
}:
{
  imports = with inputs; [ git-hooks.flakeModule ];

  perSystem =
    { config, pkgs, ... }:
    {
      pre-commit.settings =
        let
          treefmt-wrapper = config.treefmt.build.wrapper or null;
        in
        {
          excludes = [ "flake.lock" ];

          hooks = {
            treefmt.enable = if (treefmt-wrapper != null) then true else false;
            treefmt.package = if (treefmt-wrapper != null) then treefmt-wrapper else pkgs.treefmt;

            commitizen.enable = true;
            trim-trailing-whitespace.enable = true;
            mixed-line-endings.enable = true;
            end-of-file-fixer.enable = true;
            check-executables-have-shebangs.enable = true;
            check-added-large-files.enable = true;

            gitleaks = {
              enable = true;
              name = "gitleaks";
              entry = "${lib.getExe pkgs.gitleaks} protect --verbose --redact --staged";
              pass_filenames = false;
            };
          };
        };
    };
}
