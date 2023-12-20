{currentSystemName, ...}: {
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
  networking.computerName = currentSystemName;
}
