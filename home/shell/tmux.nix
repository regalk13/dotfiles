{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      #      {
      #        plugin = tmux-super-fingers;
      #        extraConfig = "set -g @super-fingers-key f";
      #      }
      tmuxPlugins.better-mouse-mode
    ];
  };
}
