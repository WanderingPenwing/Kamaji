# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-unstable,
  options,
  ...
}: let
  hostname = "boiler"; # to alllow per-machine config
in {
  imports = [
    ./boiler-hardware.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = hostname;

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  users.users.penwing = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN/SQbXjL6O2zjKFdybiMLu7Imc10IGrTMUnRtIxf0jJ nicolas.pinson31@gmail.com"
        ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    fastfetch
  ]);

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
