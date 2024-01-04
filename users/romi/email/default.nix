{
  config,
  pkgs,
  ...
}: let
  xdg = config.xdg;
in {
  imports = [
    ./mblaze.nix
  ];

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch = {
    enable = true;
    new.tags = [];
  };

  accounts.email.maildirBasePath = "Mail";

  accounts.email.accounts.telecom = {
    primary = true;
    realName = "Romi Hervier";
    address = "romi@grtsk.net";
    aliases = ["rh@grtsk.net" "romi@sansfontieres.com" "r@sansfontieres.com"];
    imap.host = "imap.fastmail.com";
    passwordCommand = "${pkgs.coreutils}/bin/cat ${config.age.secrets.telecom.path}";
    maildir.path = "";

    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
    };

    msmtp.enable = true;

    smtp = {
      host = "smtp.fastmail.com";
      port = 565;
    };

    userName = "telecom@sansfontieres.com";

    notmuch.enable = true;
  };

  home.sessionVariables = rec {
    MAILDIR = "${config.home.homeDirectory}/Mail";
    MBLAZE = "${xdg.configHome}/mblaze";
    MBLAZE_PAGER = "${pkgs.less}/bin/less -cR";
    MBLAZE_LESSKEY = "${MBLAZE}/mlesskey";
    MCOLOR_CUR = 2;
    MCOLOR_MISS = 1;
    MCOLOR_FROM = 8;
    MCOLOR_HEADER = 8;
    MCOLOR_FOOTER = 8;
    MCOLOR_SIG = 8;
    MCOLOR_SEP = 8;
    MCOLOR_QUOTE = 4;
    MCOLOR_QQUOTE = 5;
    MCOLOR_QQQUOTE = 4;
  };
}
