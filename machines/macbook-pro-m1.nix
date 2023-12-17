{
  config,
  pkgs,
  ...
}: {
  # Don't let nix-darwin take over our business.
  nix.useDaemon = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  programs.zsh.enable = true;
  programs.zsh.shellInit = ''
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
  '';

  programs.fish.enable = true;
  programs.fish.shellInit = ''
    # Nix
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end
    # End Nix
  '';

  environment.shells = with pkgs; [bashInteractive zsh fish];

  services.tailscale.enable = true;
}
