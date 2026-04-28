{
  specs,
  ...
}:
{
  environment.etc.machine-id.text = specs.core.machineId;

  time.timeZone = specs.core.timeZone;

  i18n.defaultLocale = specs.core.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = specs.core.locale;
    LC_IDENTIFICATION = specs.core.locale;
    LC_MEASUREMENT = specs.core.locale;
    LC_MONETARY = specs.core.locale;
    LC_NAME = specs.core.locale;
    LC_NUMERIC = specs.core.locale;
    LC_PAPER = specs.core.locale;
    LC_TELEPHONE = specs.core.locale;
    LC_TIME = specs.core.locale;
    LC_COLLATE = specs.core.locale;
  };

  system = { inherit (specs.core) stateVersion; };
}
