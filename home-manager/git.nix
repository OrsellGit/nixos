#* Git Configuration
{ lib, pkgs, ...}:
{
  programs = {
    git = {
      enable = true;
      settings = {
        user.name  = "OrsellGaming";
        user.email = "34631691+OrsellGaming@users.noreply.github.com";
        extraConfig = {
          commit.gpgsign = true;
          gpg.format = "ssh"; #? Sign all commits using a SSH key from 1Password
          "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
          user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHISguK84EGMZZpL/Iz6Ug9AEP4BpSw3xIbamAmHgr/l";
          pull.rebase = false;
          push.autoSetupRemote = true;
          core.autocrlf = "input";
        };
      };
      lfs.enable = true;
    };

    lazygit.enable = true;
  };
}
