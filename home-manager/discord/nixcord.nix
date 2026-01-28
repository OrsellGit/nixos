{pkgs, lib, ...}:
{

  imports = [
    #./slasher.nix # TODO: Maybe repurpose for something else.
  ];

  # vencord theme
  home.file = {
    ".config/vesktop/themes" = {
      source = ./theme;
      recursive = true;
    };
  };

  # TODO: Replace this Vencord setup with the one I usually have that is in the cloud.
  programs.nixcord = {
    enable = true;  # enable Nixcord. Also installs discord package
    discord = {
      vencord.enable = false;
      equicord.enable = true;
    };
    vesktop.enable = false;
    equibop.enable = true;
    config = {
      # themeLinks = [
      #   "https://raw.githubusercontent.com/Xhylo/Visual-Studio-Code-BD-theme/main/VSC-Cord.theme.css"
      # ];
      enabledThemes = [
        "source.css"
        "betterusertags.theme.css"
        "pingedserversfirst.theme.css"
        "randomfixes.theme.css"
        "shadows.theme.css"
      ];
      plugins = {
        betterGifPicker.enable = true;
        betterSessions.enable = true;
        callTimer = {
          enable = true;
          format = "human";
        };
        ClearURLs.enable = true;
        dearrow.enable = true;
        disableCallIdle.enable = true;
        experiments.enable = true;
        fakeNitro.enable = true;
        fakeProfileThemes.enable = true;
        fixCodeblockGap.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendInvites.enable = true;
        friendsSince.enable = true;
        gameActivityToggle.enable = true;
        gifPaste.enable = true;
        greetStickerPicker.enable = true;
        imageLink.enable = true;
        implicitRelationships.enable = true;
        memberCount.enable = true;
        mentionAvatars.enable = true;
        messageLinkEmbeds.enable = true;
        messageLogger.enable = true;
        moreCommands.enable = true;
        messageTags.enable = true;
        moreUserTags.enable = true;
        MutualGroupDMs.enable = true;
        noOnboardingDelay.enable = true;
        noUnblockToJump.enable = true;
        normalizeMessageLinks.enable = true;
        OnePingPerDM.enable = true;
        openInApp.enable = true;
        pauseInvitesForever.enable = true;
        permissionFreeWill.enable = true;
        permissionsViewer.enable = true;
        pictureInPicture.enable = true;
        PinDMs.enable = true;
        platformIndicators.enable = true;
        previewMessage.enable = true;
        userMessagesPronouns.enable = true;
        relationshipNotifier = {
          enable = true;
          notices = true;
        };
        revealAllSpoilers.enable = true;
        serverInfo.enable = true;
        serverListIndicators.enable = true;
        shikiCodeblocks.enable = true;
        showAllMessageButtons.enable = true;
        showConnections.enable = true;
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        showMeYourName.enable = true;
        showTimeoutDuration.enable = true;
        silentMessageToggle.enable = true;
        spotifyCrack.enable = true;
        stickerPaste.enable = true;
        translate.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        unindent.enable = true;
        unsuppressEmbeds.enable = true;
        userVoiceShow.enable = true;
        validReply.enable = true;
        validUser.enable = true;
        vcNarratorCustom = {
          enable = true;
        };
        viewIcons.enable = true;
        voiceDownload.enable = true;
        volumeBooster = {
          enable = true;
          multiplier = 5.0;
        };
        whoReacted.enable = true;
        youtubeAdblock.enable = true;
        webRichPresence.enable = true;
        webScreenShareFixes.enable = true;

        customIdle = {
          enable = true;
          idleTimeout = 0.0;
        };
      };
      transparent = true;
    };
  };

  services.arrpc.enable = true;
}
