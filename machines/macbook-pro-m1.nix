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
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '';

  # HACK: looks like my nix pkgs are after system bins
  programs.fish.enable = true;
  programs.fish.shellInit = ''
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end

    fish_add_path --move --prepend --path /etc/profiles/per-user/$USER/bin
  '';

  # It doesn't get itself into path if enabled, nix-darwin is strange in
  # this regard.
  environment.extraInit =
    if config.homebrew.enable
    then ''
      eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
    ''
    else null;

  environment.shells = with pkgs; [bashInteractive zsh fish];

  services.tailscale.enable = true;
}
