#* Terminal, shell, and other extensions.
{ pkgs, lib, ... }:
{
    #? TERMINAL EMULATOR
    programs.kitty = {
        enable = true;
        enableGitIntegration = true;
        shellIntegration.enableZshIntegration = true;
        font = {
            name = "JetBrainsMono Nerd Font";
            size = 10;
        };
        settings = {
            shell = "zsh";
            background_opacity = 0.5;
            confirm_os_window_close = 0;
            cursor_trail = 3;
            cursor_trail_decay = "0.1 0.2";
            cursor_trail_start_threshold = 0;
            cursor_shape = "beam";
        };
    };

    #? CONFIG FILES FOR SHELL
    home.file = {
        ".p10k.zsh" = { source = ./.p10k.zsh; };
        ".zshrc.override" = { source = ./.zshrc.override; }; #! Current unstable build of Home Manager causes a conflict because it already has a zshrc file for some reason, so this needs to get loaded after the one already included.
    };

    #? TERMINAL SHELL
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion = {
            enable = true;
            highlight = "fg=#A8A8A8,underline";
            strategy = [ "completion" ];
        };
        syntaxHighlighting.enable = true;

        initContent = lib.mkOrder 500 '' # Start the theme as the first thing the shell should do.
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            source ~/.zshrc.override
        '';

        shellAliases = {
            logoutnow = "hyprctl dispatch exit";
            nswitch = "nh os switch -- --show-trace";
            nbuild = "nh os build -- --show-trace";
            nboot = "nh os boot -- --show-trace";
            lg = "lazygit";
            nukserver = "ssh orsell@10.0.0.112";
            windows10 = "quickemu --vm ~/Desktop/VMs/windows-10-English-United-States.conf --display spice";
            #nix-find-pkg="function f() { nix-instantiate --eval-only --expr \"(import <nixpkgs> {nixpkgs.config.allowUnfree = true;}).$1.outPath\"; }; f";
        };

        plugins = [
            #{
                # name = "zsh-powerlevel10k";
                # src = pkgs.fetchFromGitHub {
                #     owner = "romkatv";
                #     repo = "powerlevel10k";
                #     rev = "v1.20.0";
                #     sha256 = "ES5vJXHjAKw/VHjWs8Au/3R+/aotSbY7PWnWAMzCR8E=";
                # };
            #}

            # {
            #     name = "";
            #     src = pkgs.zsh-powerlevel10k;
            #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            # };

            { # TODO: Isn't working.
                name = "zsh-nix-shell";
                file = "nix-shell.plugin.zsh";
                src = pkgs.fetchFromGitHub {
                    owner = "chisui";
                    repo = "zsh-nix-shell";
                    rev = "v0.8.0";
                    sha256 = "Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
                };
            }
        ];

        oh-my-zsh = {
            enable = true;
            plugins = [
                "virtualenv"
                "vscode"
                "github"
                "git-lfs"
                "git-prompt"
                # TODO: Fix the below three plugins.
                # "viper-env"
                # "tmux-ssh-syncing"
                # "xxh-plugin-zsh-ohmyzsh"
            ];
        };
    };

    #? MULT-TERMINALS
    programs.tmux = {
        enable = true;
        clock24 = false;
        extraConfig = ''
        set -g default-command ${pkgs.zsh}/bin/zsh
        set -g status-right "#[fg=orange,bg=black]%A, %d %b %Y"
        set -g mouse on
        '';
    };

    #? NixOS direnv
    programs.direnv = {
        enable = true;
    };

    #? NixOS Command Helper
    programs.nh = {
        enable = true;
        flake = "/home/orsell/nixos";
    };
}