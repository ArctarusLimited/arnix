{ pkgs, root }:
{
  nativeBuildInputs = (with pkgs; [
    python3
    nixFlakes
    colmena
    nixos-generate
    consul-template
    inix-helper
  ]) ++ (with pkgs.python3Packages; [
    black
    coloredlogs
    hvac
    icmplib
    kubernetes
    tabulate
    paramiko
    Fabric

    # not supported on x86_64-darwin, breaks `nix flake check`
    # tpm2-pytss
  ]);
}
