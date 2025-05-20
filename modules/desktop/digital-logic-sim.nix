{
  inputs,
  ...
}:
{
    environment.systemPackages = [
        inputs.digital-logic-sim.packages.x86_64-linux.fork16bit
    ];
}
