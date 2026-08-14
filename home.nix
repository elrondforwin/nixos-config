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
    ".config/nvim".source = link ".config/nvim";
    ".config/nvim-vscode".source = link ".config/nvim-vscode";
    ".zshrc".source = link ".zshrc";
    ".ideavimrc".source = link ".ideavimrc";
    ".config/xdg-desktop-portal/Hyprland-portals.conf".source = link ".config/xdg-desktop-portal/Hyprland-portals.conf";
  };

  services.kdeconnect.enable = true;

  # Hyprland 0.56 has no built-in systemd integration; activate
  # graphical-session.target so xdg-desktop-portal can start.
  systemd.user.targets.hyprland-session = {
    Unit = {
      Description = "Hyprland session";
      Wants = [ "graphical-session.target" ];
    };
  };

  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
  };


  home.packages = [
    inputs.helium.packages.${pkgs.system}.default
    inputs.noctalia.packages.${pkgs.system}.default
    inputs.qt6ct-kde.packages.${pkgs.system}.default
    inputs.fetch.packages.${pkgs.system}.default
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro
    inputs.llm-agents.packages.${pkgs.system}.omp

    # user packages / desktop related
    pkgs.home-manager
    pkgs.prismlauncher
    pkgs.protonplus
    pkgs.termius
    pkgs.vscode
    pkgs.obsidian
    pkgs.qbittorrent
    pkgs.obs-studio
    pkgs.gnome-font-viewer
    pkgs.libsecret

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
    pkgs.ripgrep
    pkgs.nh

    # zsh config related
    pkgs.eza
    pkgs.zoxide
    pkgs.bat
    pkgs.ncdu

    # fonts
    pkgs.adwaita-fonts
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.iosevka

    # hyprland and desktop tools
    pkgs.hyprpicker
    pkgs.hyprshot
    pkgs.satty
    pkgs.brightnessctl
    pkgs.playerctl
    pkgs.wl-clipboard
    pkgs.kdePackages.dolphin
    pkgs.kdePackages.plasma-workspace
    pkgs.kdePackages.ark
    pkgs.kdePackages.gwenview
    pkgs.haruna
    pkgs.shared-mime-info
    pkgs.apple-cursor
    pkgs.nwg-look
    pkgs.nwg-displays
    pkgs.adw-gtk3
    pkgs.kdePackages.kio
    pkgs.kdePackages.kservice
    pkgs.tela-icon-theme

    # development

    pkgs.jdk25
    pkgs.rustc
    pkgs.cargo
    pkgs.sqlite
    pkgs.nodejs
    pkgs.bun

  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.kde.dolphin.desktop";
      "application/zip" = "org.kde.ark.desktop";
      "text/plain" = "nvim.desktop";
      "image/jpeg" = "org.kde.gwenview.desktop";
      "image/png" = "org.kde.gwenview.desktop";
      "image/jpg" = "org.kde.gwenview.desktop";
    };
  };

}
