{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    # inputs.digital-logic-sim.packages.x86_64-linux.fork16bit
    inputs.digital-logic-sim.packages.x86_64-linux.default
  ];
}
