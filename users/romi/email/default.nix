{
  config,
  pkgs,
  ...
}: {
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
    aliases = ["rh@grtsk.net" "r@sansfontieres.com"];
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
}
