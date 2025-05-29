_:
let
  youTubeFeeds =
    users:
    map (userNames: {
      tags = [ "youtube" ];
      url = "https://rsshub.app/youtube/user/@${userNames}";
    }) users;

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
