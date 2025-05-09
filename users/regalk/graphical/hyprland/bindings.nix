{ config, ... }:
let

  inherit (config.hm.programs) defaults;
in
{
  wayland.windowManager.hyprland.settings = {
    #####################################################
    # Regular key binds
    #####################################################
    bind = [
      # launchers / actions
      "SUPER, Q, exec, ${defaults.terminal}"
      "SUPER, C, killactive,"
      "SUPER, M, exit,"
      "SUPER, E, exec, $fileManager"
      "SUPER, V, togglefloating,"
      "SUPER, R, exec, ${defaults.launcher} -show drun"
      "SUPER, P, pseudo," # dwindle
      "SUPER, J, togglesplit," # dwindle

      # focus movement
      "SUPER, left,  movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up,    movefocus, u"
      "SUPER, down,  movefocus, d"

      # workspaces 1‒10
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"

      # move window to workspaces
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"

      # special workspace (scratchpad)
      "SUPER, S, togglespecialworkspace, magic"
      "SUPER SHIFT, S, movetoworkspace, special:magic"

      # workspace scrolling
      "SUPER, mouse_down, workspace, e+1"
      "SUPER, mouse_up,   workspace, e-1"

      "SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
    ];

    #####################################################
    # Mouse-drag bindings
    #####################################################
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    #####################################################
    # “Hold-to-repeat” keys  (volume / brightness)
    #####################################################
    binde = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86MonBrightnessUp,  exec, brightnessctl s 10%+"
      ", XF86MonBrightnessDown,exec, brightnessctl s 10%-"
    ];

    #####################################################
    # One-shot multimedia keys (mute, playerctl)
    #####################################################
    bindel = [
      ", XF86AudioMute,     exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute,  exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindl = [
      ", XF86AudioNext,  exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay,  exec, playerctl play-pause"
      ", XF86AudioPrev,  exec, playerctl previous"
    ];
  };
}
