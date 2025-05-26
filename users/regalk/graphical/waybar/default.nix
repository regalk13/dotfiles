{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;

      margin-top = 0;
      margin-right = 0;
      margin-bottom = 0;
      margin-left = 0;

      modules-left = [
        "hyprland/workspaces"
        "tray"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "cpu"
        "memory"
        "network"
        "custom/power"
      ];

      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{icon}";
        "format-icons" = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
          "10" = "10";
        };
      };

      mpd = {
        tooltip = true;
        "tooltip-format" = "{artist} - {album} - {title} - Total Time : {totalTime:%M:%S}";
        format = " {elapsedTime:%M:%S}";
        "format-disconnected" = "⚠  Disconnected";
        "format-stopped" = " Not Playing";
        "on-click" = "mpc toggle";
        "state-icons" = {
          playing = "";
          paused = "";
        };
      };

      "mpd#2" = {
        format = "";
        "format-disconnected" = "";
        "format-paused" = "";
        "format-stopped" = "";
        "on-click" = "mpc -q pause && mpc -q prev && mpc -q start";
      };

      "mpd#3" = {
        interval = 1;
        format = "{stateIcon}";
        "state-icons" = {
          playing = "";
          paused = "";
        };
        "on-click" = "mpc toggle";
      };

      "mpd#4" = {
        format = "";
        "on-click" = "mpc -q pause && mpc -q next && mpc -q start";
      };

      tray = {
        "icon-size" = 14;
        spacing = 5;
      };

      clock = {
        "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          "mode-mon-col" = 3;
          "weeks-pos" = "right";
          "on-scroll" = 1;
          "on-click-right" = "mode";
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          "on-click-right" = "mode";
          "on-click-forward" = "tz_up";
          "on-click-backward" = "tz_down";
          "on-scroll-up" = "shift_up";
          "on-scroll-down" = "shift_down";
        };
        format = "  {:%a %d %b   %I:%M %p}";
        "format-alt" = "  {:%d/%m/%Y    %H:%M:%S}";
        interval = 1;
      };

      cpu = {
        format = " {usage: >3}%";
        "on-click" = "alacritty -e htop";
      };

      memory = {
        format = " {: >3}%";
        "on-click" = "alacritty -e htop";
      };

      backlight = {
        format = "{icon} {percent: >3}%";
        "format-icons" = [
          ""
          ""
        ];
        "on-scroll-down" = "light -A 5 && light -G | cut -d'.' -f1 > $SWAYSOCK.wob";
        "on-scroll-up" = "light -U 5 && light -G | cut -d'.' -f1 > $SWAYSOCK.wob";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity: >3}%";
        "format-icons" = [
          ""
          ""
          ""
          ""
          ""
        ];
      };

      network = {
        format = "⚠  Disabled";
        "format-wifi" = "  {essid}";
        "format-ethernet" = "  Wired";
        "format-disconnected" = "⚠  Disconnected";
        "on-click" = "nm-connection-editor";
      };

      "custom/power" = {
        format = "⏻";
        "on-click" = "nwgbar";
        tooltip = false;
      };
    };
    style = ''
          /* ---------- Core background layers ---------- */
            @define-color base   #161616;  /* palette 0  – primary background */
            @define-color mantle #161616;  /* using same deep black for a seamless stack */
            @define-color crust  #161616;

            /* ---------- Primary text colours ---------- */
            @define-color text     #f2f4f8; /* palette 7 – primary foreground */
            @define-color subtext0 #d8d8d8; /* 80 % text for secondary labels */
            @define-color subtext1 #b0b0b0; /* 65 % text for tertiary details */

            /* ---------- Neutral surfaces ---------- */
            @define-color surface0 #262626; /* ~#161616 + 10 % luminance */
            @define-color surface1 #393939; /* matches selection-background */
            @define-color surface2 #585858; /* palette 8 – raised surfaces */

            /* ---------- Overlays / subtle separators ---------- */
            @define-color overlay0 #3ddbd9; /* palette 1  – cyan accent */
            @define-color overlay1 #33b1ff; /* palette 2  – blue accent */
            @define-color overlay2 #be95ff; /* palette 5  – lavender accent */

            /* ---------- Accents ---------- */
            @define-color blue      #33b1ff; /* palette 2 */
            @define-color lavender  #be95ff; /* palette 5 */
            @define-color sapphire  #3ddbd9; /* palette 1 – closest match */
            @define-color sky       #3ddbd9; /* same cyan accent */
            @define-color teal      #3ddbd9; /* re-use cyan */
            @define-color green     #42be65; /* palette 4 */
            @define-color yellow    #ee5396; /* no true yellow – reuse warm pink */
            @define-color peach     #ff7eb6; /* palette 6 */
            @define-color maroon    #ee5396; /* palette 3 */
            @define-color red       #ee5396; /* palette 3 */
            @define-color mauve     #be95ff; /* palette 5 */
            @define-color pink      #ff7eb6; /* palette 6 */
            @define-color flamingo  #ff7eb6; /* palette 6 (slightly lighter) */
            @define-color rosewater #f2f4f8; /* softened highlight */

      * {
          color: @lavender;
          border: 0;
          padding: 0 0;
          font-family: Iosevka Nerd Font;
          font-size: 13px;
          font-weight: bold;
      }

      window#waybar {
          border: 0px solid rgba(0, 0, 0, 0);
          /* border-radius: 10px; */
          /* background:#2d2a2e; */
          /* background-color: rgba(36, 39, 58, 0.85); */
          background-color: rgba(0, 0, 0, 0);
          /* background-color: shade(#1e1e2e, 0.95); */
      }

      #workspaces button {
          color: @base;
          border-radius: 50%;
          /* background-color: @base; */
          margin: 0px 0px;
          padding: 4 6 2 0;
      }

      #workspaces button:hover {
          color: @mauve;
          box-shadow: none;
          /* Remove predefined box-shadow */
          text-shadow: none;
          /* Remove predefined text-shadow */
          border: 0px;
          background: none;
      }

      #workspaces button:hover * {
          color: @mauve;
          background-color: @base;
      }

      #workspaces {
          color: whitesmoke;
      }

      #workspaces {
          border-style: solid;
          background-color: @base;
          opacity: 1;
          padding-left: 5px;
          margin: 8px 0px 8px 8px;
      }

      #workspaces button.active * {
          color: @flamingo;
          border-radius: 20px;
      }

      #mode {
          color: #ebcb8b;
      }

      #clock,
      #custom-swap,
      #custom-cava-internal,
      #battery,
      #cpu,
      #memory,
      #idle_inhibitor,
      #temperature,
      #custom-keyboard-layout,
      #backlight,
      #network,
      #pulseaudio,
      #mode,
      #tray,
      #custom-power,
      #custom-launcher,
      #mpd {
          padding: 5px 8px;
          border-style: solid;
          background-color: shade(@base, 1);
          opacity: 1;
          margin: 8px 0;
      }

      /* -----------------------------------------------------------------------------
        * Module styles
        * -------------------------------------------------------------------------- */
      #mpd {
          border-radius: 10px;
          color: @mauve;
          margin-left: 5px;
          background-color: rgba(0, 0, 0, 0);
      }

      #mpd.2 {
          border-radius: 10px 0px 0px 10px;
          margin: 8px 0px 8px 6px;
          padding: 4px 12px 4px 10px;
      }

      #mpd.3 {
          border-radius: 0px 0px 0px 0px;
          margin: 8px 0px 8px 0px;
          padding: 4px;
      }

      #mpd.4 {
          border-radius: 0px 10px 10px 0px;
          margin: 8px 0px 8px 0px;
          padding: 4px 10px 4px 14px;
      }

      #mpd.2,
      #mpd.3,
      #mpd.4 {
          background-color: @base;
          font-size: 14px;
      }

      #mode {
          border-radius: 10px;
          color: @mauve;
          margin-right: 5px;
      }

      #custom-cava-internal {
          border-radius: 10px;
          color: @mauve;
      }

      #custom-swap {
          border-radius: 10px;
          color: @base;
          margin-left: 15px;
          background-color: @mauve;
      }

      #clock {
          /* background-color:#a3be8c; */
          color: @sky;
          margin: 8px 10px;
      }

      #backlight {
          color: @yellow;
          /* border-bottom: 2px solid @yellow; */
          border-radius: 10px 0 0 10px;
      }

      #battery {
          color: #d8dee9;
          /* border-bottom: 2px solid #d8dee9; */
          border-radius: 0 10px 10px 0;
          margin-right: 10px;
      }

      #battery.charging {
          color: #81a1c1;
          /* border-bottom: 2px solid #81a1c1; */
      }

      @keyframes blink {
          to {
              color: @red;
              /* border-bottom: 2px solid @red; */
          }
      }

      #battery.critical:not(.charging) {
          color: #bf616a;
          /* border-bottom: 2px solid #bf616a; */
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #cpu {
          color: @sky;
          /* border-bottom: 2px solid @sky; */
      }

      #cpu #cpu-icon {
          color: @sky;
      }

      #memory {
          color: @sky;
      }

      #network.disabled {
          color: #bf616a;
          /* border-bottom: 2px solid #bf616a; */
      }

      #network {
          color: @green;
          /* border-bottom: 2px solid @green; */
          margin-right: 5px;
      }

      #network.disconnected {
          color: #bf616a;
          /* border-bottom: 2px solid #bf616a; */
      }

      #pulseaudio {
          color: @flamingo;
          /* border-bottom: 2px solid @flamingo; */
      }

      #pulseaudio.muted {
          color: #3b4252;
          /* border-bottom: 2px solid #3b4252; */
      }

      #temperature {
          color: @teal;
          /* border-bottom: 2px solid @teal; */
          border-radius: 10px 0 0 10px;
      }

      #temperature.critical {
          color: @red;
          /* border-bottom: 2px solid @red; */
      }

      #idle_inhibitor {
          background-color: #ebcb8b;
          color: @base;
      }

      #tray {
          /* background-color: @base; */
          margin: 8px 10px;
      }

      #custom-launcher,
      #custom-power {}

      #custom-launcher {
          background-color: @mauve;
          color: @base;
          padding: 5px 10px;
          margin-left: 15px;
      }

      #custom-power {
          color: @base;
          background-color: @red;
          margin-left: 5px;
          padding-right: 10px;
          margin-right: 15px;
      }

      #window {
          border-style: hidden;
          margin-left: 10px;
          /* margin-top:1px;
           padding: 8px 1rem; */
          margin-right: 10px;
          color: #eceff4;
      }

      #custom-keyboard-layout {
          color: @peach;
          /* border-bottom: 2px solid @peach; */
          border-radius: 0 10px 10px 0;
          margin-right: 10px;
      }

      /* window#waybar {
           background: #2d2a2e;
       }

       #workspaces button.focused {
           color: #f2e5bc;
       }

       #workspaces button {
           color: #c8b9a9;
       }

       .separator {
           background-color: #c8b9a9;
       }

       #mode {
           color: #ebcb8b;
       }

       #clock {
           color: #a3be8c;
       }

       #battery {
           color: #d8dee9;
       }

       #battery.charging {
           color: #b48ead;
       }

       #battery.critical:not(.charging) {
           color: #bf616a;
       }

       #cpu {
           color: #a3be8c;
       }

       #memory {
           color: #d3869b;
       }

       #network {
           color: #8fbcbb;
       }

       #network.disabled {
           color: #bf616a;
       }

       #network.disconnected {
           color: #bf616a;
       }

       #pulseaudio {
           color: #b48ead;
       }

       #pulseaudio.muted {
           color: #bf616a;
       }

       #temperature {
           color: #8fbcbb;
       }

       #temperature.critical {
           color: #bf616a;
       } */

    '';
  };
}
