_: {
  services.homepage-dashboard = {
    enable = true;
    settings = {
      title = "My Homelab";
      description = "An awesome homepage";
    };
    widgets = [
      {
        datetime = {
          text_size = "2xl";
          format = {
            timeStyle = "short";
            hour12 = true;
          };
        };
      }
      {
        glances = {
          url = "http://localhost:61208";
          # username = "user";
          # password = "pass";
          version = 4; # required only if running glances v4 or higher, defaults to 3
          cpu = true; # optional, enabled by default, disable by setting to false
          mem = true; # optional, enabled by default, disable by setting to false
          cputemp = true; # disabled by default
          unit = "imperial"; # optional for temp, default is metric
          uptime = true; # disabled by default
          disk = "/"; # disabled by default, use mount point of disk(s) in glances.
          diskUnits = "bytes"; # optional, bytes (default) or bbytes.
          expanded = true; # show the expanded view
          label = "MyMachine"; # optional
        };
      }
      {
        resources = {
          cpu = true;
          disk = "/";
          memory = true;
        };
      }
    ];
    services = [
      {
        "Infrastructure" = [
          {
            "coder" = {
              icon = "coder.png";
              description = "Cloud coding";
              href = "http://localhost:3000";
            };
          }
        ];
      }
      {
        "My Second Group" = [
          {
            "My Second Service" = {
              description = "Homepage is the best";
              href = "http://localhost/";
            };
          }
        ];
      }
    ];
  };
}
