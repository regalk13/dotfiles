{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}
