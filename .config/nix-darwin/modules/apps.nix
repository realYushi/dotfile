{ pkgs, ...}: {

  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    nodejs_23
    zulu23
    dotnet-sdk
    python3


    neovim
    git
    stow
    tldr
    fzf
    zoxide
    direnv
    nix-direnv
    yazi
    thefuck
    opencommit

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
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "antidote"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "google-chrome"
      "visual-studio-code"
      "chatgpt"
      "iterm2"
      "raycast"
      "spotify"
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
      "beeper"
    ];
  };
}
