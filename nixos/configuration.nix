{ lib, config, modulesPath, pkgs, buildGoModule, fetchFromGitHub, ... }: 
{
  imports = [ "${modulesPath}/virtualisation/amazon-image.nix" ];
  system.stateVersion = "24.05";
  networking.hostName = "nixos-machine";  
  environment.systemPackages = with pkgs; [
    vim
    (callPackage ./backloggd-discord.nix {})
  ];
}
