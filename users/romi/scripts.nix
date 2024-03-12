let
  script_path = "bin/scripts";
in {
  home.file = {
    "${script_path}/🐰" = {
      source = ../../scripts + "/🐰.rc";
      executable = true;
    };

    "${script_path}/bisync_home" = {
      source = ../../scripts + "/bisync_home.rc";
      executable = true;
    };

    "${script_path}/finger" = {
      source = ../../scripts/finger.janet;
      executable = true;
    };

    "${script_path}/git-co" = {
      source = ../../scripts/git-co.rc;
      executable = true;
    };

    "${script_path}/patoggle" = {
      source = ../../scripts/patoggle.rc;
      executable = true;
    };

    "${script_path}/s" = {
      source = ../../scripts/s.rc;
      executable = true;
    };
  };
}
