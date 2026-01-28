{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
	# package = pkgs.vscodium; # TODO: Figure out Remote SSH with VSCodium
    profiles.default.extensions = with pkgs.vscode-extensions; [
      yzhang.markdown-all-in-one
      bbenoist.nix
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [ # TODO: Port all plugins from usual setup to here.
	    {
	    	name = "vscript-snippets";
	    	publisher = "Baptiste-Martinet";
	    	version = "1.0.4";
	    	sha256 = "jZ/h9nXaCz8cHcKKKFW6aevx6QdftfqBXungQ3CjwhU=";
	    }
	    {
	    	name = "vscript-debug";
	    	publisher = "LionDoge";
	    	version = "0.2.7";
	    	sha256 = "CXmSRIK+00bN0ONLuLeIgIMYeM3tqBJ7R6JhveIhv00=";
	    }
	    {
	    	name = "vscode-electricimp";
	    	publisher = "electricimp";
	    	version = "1.0.0";
	    	sha256 = "a23AfdrJTCQYj7vJCDYwdxe7MvoTfH8bGVjB92ktp7w=";
	    }
	    {
	    	name = "better-comments";
	    	publisher = "aaron-bond";
	    	version = "3.0.2";
	    	sha256 = "hQmA8PWjf2Nd60v5EAuqqD8LIEu7slrNs8luc3ePgZc=";
	    }
	    {
	    	name = "remote-ssh";
	    	publisher = "ms-vscode-remote";
	    	version = "0.121.2025071515";
	    	sha256 = "x++DaNxQ80ZQwRNDiWpO9Ygwc5YJeg4lEPcl7Z/DkpI=";
	    }
		{
			name = "catppuccin-vsc";
			publisher = "Catppuccin";
			version = "3.17.0";
			sha256 = "udDbsXAEsJUt3WUU8aBvCi8Pu+8gu+xQkimlmvRZ9pg=";
		}
		{
			name = "catppuccin-vsc-icons";
			publisher = "Catppuccin";
			version = "1.24.0";
			sha256 = "2M7N4Ccw9FAaMmG36hGHi6i0i1qR+uPCSgXELAA03Xk=";
		}
		{
			name = "cpptools";
			publisher = "ms-vscode";
			version = "1.26.3";
			sha256 = "OWnjb1d1yXyygtVvUbPKGCXu4X78CVbqs4S2KBsfdyI=";
		}
		{
			name = "cmake-tools";
			publisher = "ms-vscode";
			version = "1.21.36";
			sha256 = "IqgYnesIz46WmJ7kR8LYnr2kkD33oiupi7CrcV6rGRg=";
		}
		{
			name = "panorama-css";
			publisher = "braemie";
			version = "0.4.2";
			sha256 = "sha256-lzGwtlZ4mUnwfdWn7pLrzrXC3YG+OCXxyKg8jOOuppc=";
		}
    ];

    profiles.default.userSettings = {
		"C_Cpp.errorSquiggles" = "enabled";

		"debug.onTaskErrors" = "showErrors";

	  	"editor.selectionClipboard" = false;
	  	"editor.fontFamily" = "JetBrainsMono Nerd Font";

      	"files.autoSave" = "afterDelay";
		"files.trimTrailingWhitespace" = true;
	  
	  	"git.autofetch" = true;
	  	"git.openRepositoryInParentFolders" = "always";
	  
		"makefile.configureOnOpen" = true;

	  	"merge-conflict.autoNavigateNextConflict.enabled" = true;
	  
	  	"RainbowBrackets.depreciation-notice" = false;

		"redhat.telemetry.enabled" = false;
	  
	  	"terminal.integrated.defaultProfile.linux" = "zsh";
		"terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font"; 

	  	"VScriptDebugger.displayRootTable" = true;
	  
	  	"vsicons.dontShowNewVersionMessage" = true;
	  
	  	"workbench.iconTheme" = "catppuccin-mocha";
	  	"workbench.colorTheme" = "Catppuccin Mocha";
	  	"workbench.secondarySideBar.defaultVisibility" = "hidden";
    };
  };

  home.file.".config/Code/User/snippets" = {
	source = ./code-snippets;
	recursive = true;
  };
}
