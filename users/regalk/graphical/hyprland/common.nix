{
  wayland.windowManager.hyprland.settings."exec-once" = [
    "hyprpaper &"
  ];
  home.sessionVariables = {
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Adwaita";
    HYPRCURSOR_SIZE = "24";
  };

  wayland.windowManager.hyprland.settings.input = {
    kb_layout = "us";
    follow_mouse = 1;
    sensitivity = 0;
    touchpad.natural_scroll = false;
  };

  wayland.windowManager.hyprland.settings.gestures.workspace_swipe = false;
  wayland.windowManager.hyprland.settings.dwindle = {
    pseudotile = true;
    preserve_split = true;
  };
  wayland.windowManager.hyprland.settings.master.new_status = "master";
  wayland.windowManager.hyprland.settings.misc = {
    force_default_wallpaper = -1;
    disable_hyprland_logo = false;
  };
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "suppressevent maximize, class:.*"
    "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
  ];
}
