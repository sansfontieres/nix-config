{
  agenix,
  currentSystem,
  currentSystemName,
  isDarwin,
  pkgs,
  ...
}: {
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    # Binary caches
    settings = {
      substituters = [
        "https://ghostty.cachix.org"
      ];
      trusted-public-keys = [
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      ];
    };
  };

  networking.hostName = currentSystemName;

  # nix-darwin is late on this one
  fonts =
    if !isDarwin
    then {
      packages = with pkgs; [
        inter

        # NOTE: Private repos
        personal-fonts
      ];
    }
    else {};

  environment.systemPackages = [
    agenix.packages."${currentSystem}".default

    pkgs.gitFull
  ];
}
