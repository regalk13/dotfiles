{
  lib,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib.types) enum nullOr;
in
{
  options.hm.programs.defaults = {
    terminal = mkOption {
      type = enum [
        "alacritty"
        "kitty"
        "ghostty"
      ];
      default = "ghostty";
    };

    browser = mkOption {
      type = enum [
        "firefox"
        "chromium"
        "librewolf"
      ];
      default = "librewolf";
    };

    editor = mkOption {
      type = enum [
        "nvim"
        "codium"
      ];
      default = "nvim";
    };

    launcher = mkOption {
      type = nullOr (enum [
        "rofi"
        "wofi"
      ]);
      default = "rofi";
    };
  };
}
