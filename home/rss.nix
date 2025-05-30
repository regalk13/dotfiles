_:
let
  youTubeFeeds =
    users:
    map (userNames: {
      tags = [ "youtube" ];
      url = "https://rsshub.app/youtube/user/@${userNames}";
    }) users;
  news = [
    {
      tags = [
        "linux"
        "news"
        "hardware"
      ];
      url = "https://www.phoronix.com/rss.php";
    }
    {
      tags = [
        "linux"
        "news"
      ];
      url = "https://www.cyberciti.com/atom/atom.xml";
    }
  ];
  mathFeeds = [
    {
      tags = [ "math" ];
      url = "https://terrytao.wordpress.com/feed/";
    } # Terence Tao
    {
      tags = [
        "math"
        "science"
      ];
      url = "https://www.quantamagazine.org/tag/mathematics/feed/";
    } # Quanta Magazine
    {
      tags = [
        "math"
        "algorithms"
      ];
      url = "https://jeremykun.com/feed/";
    } # Math ∩ Programming
    {
      tags = [
        "math"
        "science"
      ];
      url = "https://www.quantamagazine.org/feed/";
    }
    {
      tags = [
        "math"
      ];
      url = "https://eli.thegreenplace.net/feeds/all.atom.xml";
    }
  ];

  embeddedFeeds = [
    {
      tags = [
        "embedded"
        "firmware"
      ];
      url = "https://interrupt.memfault.com/feed.xml";
    } # Interrupt
    {
      tags = [ "embedded" ];
      url = "https://embeddedartistry.com/feed/";
    } # Embedded Artistry
    {
      tags = [ "embedded" ];
      url = "https://porzechowski.github.io/blog/feed.xml";
    }
    {
      tags = [ "embedded" ];
      url = "https://www.ganssle.com/blog/feed.rss";
    }
  ];

  rustFeeds = [
    {
      tags = [
        "rust"
        "lang"
      ];
      url = "https://blog.rust-lang.org/feed.xml";
    } # Rust core blog
    {
      tags = [
        "rust"
        "weekly"
      ];
      url = "https://this-week-in-rust.org/rss.xml";
    } # TWiR
    {
      tags = [
        "rust"
        "tutorials"
      ];
      url = "https://fasterthanli.me/index.xml";
    } # fasterthanli.me
  ];

  systemsFeeds = [
    {
      tags = [
        "c"
        "systems"
      ];
      url = "https://nullprogram.com/feed/";
    } # Null Program
    {
      tags = [
        "pentesting"
      ];
      url = "https://128nops.blogspot.com/rss.xml";
    }
    {
      tags = [
        "systems"
      ];
      url = "https://queue.acm.org/rss/feeds/queuecontent.xml";
    }
    {
      tags = [
        "zig"
        "systems"
      ];
      url = "https://andrewkelley.me/rss.xml";
    }
    {
      tags = [
        "systems"
        "rust"
        "functional"
        "ocaml"
      ];
      url = "https://priver.dev/blog/index.xml";
    }
    {
      tags = [
        "systems"
        "singularity"
      ];
      url = "https://geohot.github.io/blog/feed.xml";
    }
    {
      tags = [
        "cs"
        "systems"
      ];
      url = "https://www.rfleury.com/feed";
    }
    {
      tags = [
        "cs"
        "systems"
        "robotics"
      ];
      url = "https://commandpattern.org/feed/";
    }
    {
      tags = [
        "cs"
        "systems"
        "ml"
      ];
      url = "https://ludwigabap.bearblog.dev/feed/";
    }
    {
      tags = [
        "systems"
        "AI"
        "singularity"
      ];
      url = "http://lesserwrong.com/feed.xml";
    }
  ];
in
{
  programs.newsboat = {
    enable = true;
    browser = "zen";
    autoReload = false;
    urls =
      youTubeFeeds [
        "LukeSmithxyz"
      ]
      ++ news
      ++ mathFeeds
      ++ embeddedFeeds
      ++ rustFeeds
      ++ systemsFeeds;

    extraConfig = ''
      bind-key j down
      bind-key k up
    '';
  };
}
