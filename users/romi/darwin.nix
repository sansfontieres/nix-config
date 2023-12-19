{
  inputs,
  pkgs,
  ...
}: {
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
      "kitty" # For the protocol things
      "microsoft-excel" # Huge
      "openemu"
      "robofont"
      "spotify" # :^(
      "transmit"
      "transmission" # :^)
      "vlc" # :^)
    ];
  };

  users.users.romi = {
    home = "/Users/romi";
    shell = pkgs.fish;
  };
}
