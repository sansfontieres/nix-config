{pkgs, ...}: let
  identityAgent =
    if pkgs.stdenv.isDarwin
    then ''
      Host *
        IdentityAgent ~/.strongbox/agent.sock
    ''
    else "";
in {
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;

    extraConfig = ''
      ${identityAgent}

      Host gh sh
        User git

      Host gh
        HostName github.com

      Host sh
        HostName git.sr.ht

      Host fugu-dashboard
        HostName server11.openbsd.amsterdam
        Port 31415

      Host rsyncnet
        HostName zh2416.rsync.net
        User zh2416

      # Tailscale
      Host fugu innocence macbook-pro-m1 tumult zaibatsu
        User romi
    '';
  };
}
