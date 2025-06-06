{ inputs, ... }:
{
  programs.helix = {
    enable = true;
    package = inputs.helix.packages."x86_64-linux".default;
    settings = {
      theme = "carbonfox";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
  };
}