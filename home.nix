{ config, pkgs, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos/dotfiles";

  link = path:
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in

{
  home.username = "elrond";
  home.homeDirectory = "/home/elrond";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # Dotfiles from ./dotfiles
  home.file = {
    ".config/hypr".source = link ".config/hypr";
    ".config/kitty".source = link ".config/kitty";
    ".config/niri".source = link ".config/niri";
    ".config/nvim".source = link ".config/nvim";
    ".config/nvim-vscode".source = link ".config/nvim-vscode";
    ".zshrc".source = link ".zshrc";
    ".ideavimrc".source = link ".ideavimrc";
  };

  services.kdeconnect.enable = true;

  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
  };


  home.packages = [
    inputs.helium.packages.${pkgs.system}.default
    inputs.noctalia.packages.${pkgs.system}.default
    inputs.qt6ct-kde.packages.${pkgs.system}.default

    # user packages / desktop related
    pkgs.home-manager
    pkgs.prismlauncher
    pkgs.steam
    pkgs.protonplus
    pkgs.termius
    pkgs.vscode
    pkgs.obsidian

    # terminal tools
    pkgs.yazi
    pkgs.kitty
    pkgs.opencode
    pkgs.blueman
    pkgs.fastfetch
    pkgs.btop
    pkgs.herdr
    pkgs.cursor-cli
    pkgs.github-cli

    # zsh config related
    pkgs.eza
    pkgs.zoxide
    pkgs.bat
    pkgs.ncdu

    # fonts
    pkgs.adwaita-fonts
    pkgs.nerd-fonts.jetbrains-mono

    # hyprland and desktop tools
    pkgs.hyprpicker
    pkgs.hyprshot
    pkgs.satty
    pkgs.brightnessctl
    pkgs.playerctl
    pkgs.wl-clipboard
    pkgs.kdePackages.dolphin
    # idk if these are needed or not but I added this while I was trying to fix empty open with tab on dolphin
    pkgs.kdePackages.kio
    pkgs.kdePackages.kdf
    pkgs.kdePackages.kio-fuse
    pkgs.kdePackages.kio-extras
    pkgs.kdePackages.kio-admin
    pkgs.kdePackages.qtwayland
    pkgs.kdePackages.plasma-integration
    pkgs.kdePackages.plasma-workspace
    pkgs.kdePackages.kdegraphics-thumbnailers
    pkgs.kdePackages.breeze-icons
    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.kservice
    pkgs.kdePackages.ark
    pkgs.kdePackages.gwenview
    pkgs.haruna
    pkgs.shared-mime-info
    pkgs.apple-cursor
    pkgs.nwg-look
    pkgs.adw-gtk3
    pkgs.kdePackages.kio
    pkgs.kdePackages.kservice
    pkgs.tela-icon-theme

  ];
}
