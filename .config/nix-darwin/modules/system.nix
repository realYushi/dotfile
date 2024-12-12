{ pkgs, ... }:

  ###################################################################################
  #
  #  macOS's System configuration
  #
  #  All the configuration options are documented here:
  #    https://daiderd.com/nix-darwin/manual/index.html#sec-options
  #
  ###################################################################################
{
  system = {
    stateVersion = 5;
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      dock={
        orientation = "right";
        autohide = true;
        autohide-time-modifier = 0.0;
        autohide-delay=0.0;
        expose-animation-duration=0.0;
        mru-spaces=false;
        show-recents=false;
        static-only=true;
      };
      
      finder={
        AppleShowAllExtensions=true;
        AppleShowAllFiles=true;
        ShowPathbar=true;
        FXPreferredViewStyle="clmv";
        FXEnableExtensionChangeWarning=false;
        _FXSortFoldersFirst=true;
        _FXShowPosixPathInTitle=true;
        QuitMenuItem=true;
      };
      alf={
        allowdownloadsignedenabled=1;
      };
      menuExtraClock={
        Show24Hour=true;
        ShowDate=2;
        ShowDayOfWeek=false;

      };
      trackpad={
        ActuationStrength=0;
        Clicking=true;
        TrackpadThreeFingerDrag=true;
        TrackpadRightClick = true;
      };
      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;  # disable beep sound when pressing volume up/down key
        ApplePressAndHoldEnabled = true;  # enable press and hold
        InitialKeyRepeat = 15;  # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        KeyRepeat = 3;  # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)
        NSAutomaticCapitalizationEnabled = false;  
        NSAutomaticDashSubstitutionEnabled = false;  
        NSAutomaticPeriodSubstitutionEnabled = false; 
        NSAutomaticQuoteSubstitutionEnabled = false;  
        NSAutomaticSpellingCorrectionEnabled = false; 
        NSNavPanelExpandedStateForSaveMode = true;  
        NSNavPanelExpandedStateForSaveMode2 = true;

      };
      CustomUserPreferences = {
        "com.apple.print.PrintingPrefs" = {
        # Automatically quit printer app once the print jobs complete
        "Quit When Finished" = true;
      };
       "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
      # Turn on app auto-update
      "com.apple.commerce".AutoUpdate = true;

      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        # Check for software updates daily, not just once per week
        ScheduleFrequency = 1;
        # Download newly available updates in background
        AutomaticDownload = 1;
        # Install System data files & security updates
        CriticalUpdateInstall = 1;
      };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0; # Click wallpaper to reveal desktop
        };
        "com.apple.screensaver" = {
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.ImageCapture".disableHotPlug = true;
      };

    };
  };

  # Add ability to used TouchID for sudo authentication
  #security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;

}
