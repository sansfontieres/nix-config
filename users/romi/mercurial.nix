{
  programs.mercurial = {
    enable = true;
    aliases = {
      untrack = "rm -Af";
    };
    userName = "Romi Hervier";
    userEmail = "r@sansfontieres.com";

    extraConfig = {
      diff.git = 1;
      color = {
        "desc.here" = "bold blue";
        "log.activebookmark" = "green bold underline";
        "log.bookmark" = "green";
        "log.branch" = "cyan";
        "log.description" = "yellow";
        "log.summary" = "yellow";
        "log.tag" = "magenta";
        mode = "auto";
      };

      smtp = {
        host = "smtp.fastmail.com";
        port = "587";
        tls = "true";
        username = "telecom@sansfontieres.com";
      };

      patchbomb = {
        flagtemplate = "{{separate(' ', 'example', flags)}}";
        intro = "never";
      };
      # TODO: Figure out extensions.
      # [extensions]
      # beautifygraph=
      # color=
      # convert=
      # graphlog=
      # hgext.bookmarks=
      # hggit=
      # histedit=
      # patchbomb=
      # rebase=
      # strip=
    };
  };
}
