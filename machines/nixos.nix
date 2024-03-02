{
  nixpkgs.config.allowUnfree = true;

  programs.ssh.startAgent = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
}
