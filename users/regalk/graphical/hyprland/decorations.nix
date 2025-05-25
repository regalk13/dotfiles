{
  wayland.windowManager.hyprland.settings.decoration = {
    rounding = 5;
    rounding_power = 2;

    active_opacity = 1.0;
    inactive_opacity = 1.0;
    shadow = {
      enabled = true;
      range = 4;
      render_power = 3;
    };

    blur = {
      enabled = true;
      passes = 2;
      size = 2;

      brightness = 1.2;
      contrast = 1.3;
      # noise = 1.17e-2;
      noise = 0.02;

      new_optimizations = true;
    };
  };
}
