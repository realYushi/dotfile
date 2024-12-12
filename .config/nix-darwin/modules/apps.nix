{ pkgs, ...}: {

  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    neovim
    git
    stow
    tldr
    fzf
    zoxide
    yazi
    thefuck
    eza
    bat
    fd
    trash-cli
    ripgrep
    ffmpeg
  ];
  environment.variables.EDITOR = "nvim";
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      upgrade = true;
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };
    masApps ={
      Endel=1346247457;
      Word=462054704;
      Yoink=457622435;
      nextDns=1464122853;
      snippetsLab=1006087419;
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "antidote"
      "mise"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "google-chrome"
      "visual-studio-code"
      "iterm2"
      "raycast"
      "obsidian"
      "1password"
      "karabiner-elements"
      "keka"
      "lulu"
      "iina"
      "jordanbaird-ice"
      "nikitabobko/tap/aerospace"
      "sourcetree"
      "font-fira-code"
      "font-fira-code-nerd-font"
      "itsycal"
      "anki"
      "bluesnooze"
      "cleanshot"
      "ferdium"
      "HazeOver"
      "chatgpt"
      "windsurf"
      "boltai"
    ];
  };
}
