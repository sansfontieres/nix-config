{
  agenix,
  currentSystem,
  currentSystemName,
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
  };

  networking.hostName = currentSystemName;
  environment.systemPackages = [
    agenix.packages."${currentSystem}".default

    pkgs.gitFull
  ];
}
