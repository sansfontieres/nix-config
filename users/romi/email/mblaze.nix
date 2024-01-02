{
  config,
  pkgs,
  ...
}: let
  scripts_dir = "bin/scripts";

  opener =
    if pkgs.stdenv.isDarwin
    then "open"
    else "xdg-open";
in {
  xdg.configFile = {
    "mblaze/filter".text = ''
      text/plain: ${pkgs.mblaze}/bin/mflow -f
      text/html: ${pkgs.w3m}/bin/w3m -dump -o display_link_number=1 -I $PIPE_CHARSET -T text/html
    '';

    "mblaze/headers".text = ''
      Content-Type: text/plain; charset=UTF-8; format=flowed
    '';

    "mblaze/profile".text = ''
      Sendmail: ${pkgs.msmtp}/bin/msmtp
      Sendmail-Args: --read-envelope-from --read-recipients
      Outbox: ${config.accounts.email.accounts.telecom.maildir.absPath}/Drafts
      Local-Mailbox: romi <romi@grtsk.net>
      Alternate-Mailboxes: Romi Hervier <romi@sansfontieres.com>, Romi Hervier <rh@grtsk.net>
      FQDN: sansfontieres.com
      Scan-Format: %-3n %c%u%r %19d %19f %t %2i%s
    '';

    "mblaze/mlesskey".text = ''
      R shell ${pkgs.mblaze}/bin/mrep\n
      D shell ${pkgs.mblaze}/bin/mflag -S . && ${pkgs.mblaze}/bin/mrefile . $MAILDIR/Trash\n
      Y shell ${pkgs.mblaze}/bin/mflag -S . && ${pkgs.mblaze}/bin/mrefile . $MAILDIR/Archive\n
      O shell ${pkgs.mblaze}/bin/mshow -Hr > /tmp/m.eml && ${opener} /tmp/m.eml && rm /tmp/m.eml\n
      S shell ${pkgs.mblaze}/bin/mflag -S . && ${pkgs.mblaze}/bin/mseq -f | ${pkgs.mblaze}/bin/mseq -S\n
      s shell ${pkgs.mblaze}/bin/mflag -s . && ${pkgs.mblaze}/bin/mseq -f | ${pkgs.mblaze}/bin/mseq -S\n
      F shell ${pkgs.mblaze}/bin/mflag -F . && ${pkgs.mblaze}/bin/mseq -f | ${pkgs.mblaze}/bin/mseq -S\n
      f shell ${pkgs.mblaze}/bin/mflag -f . && ${pkgs.mblaze}/bin/mseq -f | ${pkgs.mblaze}/bin/mseq -S\n
    '';
  };

  home.file = {
    "${scripts_dir}/mbrowse" = {
      source = ./mbrowse.rc;
      executable = true;
    };

    "${scripts_dir}/mcolor" = {
      source = ./mcolor.awk;
      executable = true;
    };

    "${scripts_dir}/medraft" = {
      source = ./medraft.rc;
      executable = true;
    };

    "${scripts_dir}/mgthread" = {
      source = ./mgthread.rc;
      executable = true;
    };

    "${scripts_dir}/midrafts" = {
      source = ./midrafts.rc;
      executable = true;
    };

    "${scripts_dir}/mldrafts" = {
      source = ./mldrafts.rc;
      executable = true;
    };

    "${scripts_dir}/mnmq" = {
      source = ./mnmq.rc;
      executable = true;
    };

    # TODO: hook that in ./default.nix
    "${scripts_dir}/mpull" = {
      source = ./mpull.sh;
      executable = true;
    };

    "${scripts_dir}/mquote" = {
      source = ./mquote.sh;
      executable = true;
    };

    "${scripts_dir}/mrefresh" = {
      source = ./mrefresh.rc;
      executable = true;
    };
  };
}
