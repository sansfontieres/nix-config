{
  pkgs,
  currentSystem,
  currentSystemName,
  currentSystemUser,
  inputs,
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
    inputs.agenix.packages."${currentSystem}".default

    pkgs.gitFull
  ];
}
