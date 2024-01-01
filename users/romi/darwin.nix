{
  pkgs,
  currentSystemUser,
  ...
}: {
  nixpkgs.overlays =
    import ../../lib/overlays.nix
    ++ [];

  homebrew = {
    enable = true;

    brews = [
      "kubernetes-cli"
      "postgis"
      "postgresql"
      "redis"
    ];

    casks = [
      # TODO: Find out if some of them are in nixpkgs
      "affinity-publisher"
      "1password"
      "anki"
      "discord"
      "figma"
      "firefox"
      "google-chrome"
      "microsoft-excel" # Huge
      "openemu"
      "robofont"
      "spotify" # :^(
      "transmit"
      "transmission" # :^)
      "vlc" # :^)
    ];

    masApps = {
      "Reeder" = 1529448980;
      "Strongbox" = 897283731;
      "XCode" = 497799835;
      "Tailscale" = 1475387142;
    };
  };

  users.users."${currentSystemUser}" = {
    home = "/Users/${currentSystemUser}";
    shell = pkgs.fish;
  };
}
