# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    pandas
    requests
    pylint
  ]; 
  python-with-my-packages = python3.withPackages my-python-packages;
  config = {
    allowUnfree = true;
 };
   

  pkgsUnstable = import <nixos-unstable> { inherit config; };


in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nixpkgs.config = config;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 
  #hardware.pulseaudio.tcp.enable =true;
  
  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant
  networking = {
	networkmanager.enable = true;
	firewall.allowedTCPPorts = [ 4317 ]; 
	
  }; 
  time.timeZone = "America/Los_Angeles";


  fonts.enableFontDir = true;
  fonts.enableCoreFonts = true;
  fonts.enableGhostscriptFonts = true;

  fonts.fonts = with pkgs; [
    corefonts
    inconsolata
    liberation_ttf
    dejavu_fonts
    bakoma_ttf
    gentium
    ubuntu_font_family
    terminus_font
  ];
  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  
  
  #hardware.opengl.driSupport32Bit = true;
 # hardware.pulseaudio.support32Bit = true;
 

  hardware.bluetooth = {
    enable = true;
    extraConfig = "
      [General]
      Enable=Source,Sink,Media,Socket, Gateway
 
	# Switch to master role for incoming connections (defaults to true)
	Master=true
	 
	# If we want to disable support for specific services
	# Defaults to supporting all implemented services
	#Disable=Gateway,Source,Socket
	Disable=Socket
	 
	# SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
	# Defaults to HCI
	#SCORouting=HCI
 
	# Automatically connect both A2DP and HFP/HSP profiles for incoming
	# connections. Some headsets that support both profiles will only connect the
	# other one automatically so the default setting of true is usually a good
	# idea.
	AutoConnect=true
	 
	# Headset interface specific options (i.e. options which affect how the audio
	# service interacts with remote headset devices)
	[Headset]
	 
	# Set to true to support HFP, false means only HSP is supported
	# Defaults to true
	HFP=true
 
	# Maximum number of connected HSP/HFP devices per adapter. Defaults to 1
	MaxConnected=2
	 
	# Set to true to enable use of fast connectable mode (faster page scanning)
	# for HFP when incoming call starts. Default settings are restored after
	# call is answered or rejected. Page scan interval is much shorter and page
	# scan type changed to interlaced. Such allows faster connection initiated
	# by a headset.
	FastConnectable=true
	 
	# Just an example of potential config options for the other interfaces
	#[A2DP]
	#SBCSources=1
	#MPEG12Sources=0
    ";
  };
  hardware.facetimehd.enable = true;
#  hardware.pulseaudio.enable = true;
 hardware.opengl.driSupport32Bit = true;
 
  

  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     #Ide/Text editor
     vim
     vscode
     jetbrains.idea-community
     radare2

     #Compilers
     jdk
     pkgsUnstable.ruby
     bundler
     gcc


     #Utliities
     wget
     git
     redshift
     keepassx2
     multimc
     pkgsUnstable.wine
     winetricks
     pkgsUnstable.playonlinux
     pavucontrol	
     quicksynergy
     yubioath-desktop
	   yubikey-manager
	   yubikey-personalization-gui
     

     #Browsers
     firefox
     chromium

     #social Media
     steam
     discord
		
     #System Utlietes
     paprefs
     bluez
     blueman
     dpkg
     p7zip
     mplayer
     xscreensaver
     qscreenshot
     fcitx-engines.mozc
	   fcitx
     anthy
	
     #Essitnals
     vlc
     anki
     thunderbird
     calibre

	   #wall papers
     gtk-engine-murrine
	   plasma5.plasma-workspace-wallpapers 
	   plasma-workspace-wallpapers 
     lxappearance
     plasma5.kde-gtk-config
     materia-theme
     plasma5.breeze-gtk 
     gtk_engines
     adapta-gtk-theme
     adapta-backgrounds
     arc-kde-theme 
   ]; 
 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user seissions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true; 
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
#    extraconfig = "
#    if [ x"$SESSION_MANAGER" != x ] ; then
#    /usr/bin/pactl load-module module-x11-xsmp "display=$DISPLAY session_manager=$SESSION_MANAGER" > /dev/null
#    fi
#    ";
  };
  #hardware.bluetooth.enable = true; 
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.enableTCP = false;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "mac";
  services.xserver.videoDrivers = [ "intel" ];
  
  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  
  services.xserver.multitouch.enable = true;
  services.xserver.multitouch.invertScroll = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  ###############################
  ## Input Method Editor (IME) ##
  ###############################

  # This enables "fcitx" as your IME.  This is an easy-to-use IME.  It supports many different input methods.
  i18n.inputMethod.enabled = "fcitx";

  # This enables "mozc" as an input method in "fcitx".  This has a relatively
  # complete dictionary.  I recommend it for Japanese input.
  i18n.inputMethod.fcitx.engines = with pkgs.fcitx-engines; [ mozc anthy ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.saggins = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    description = "Saggins";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "messagebus"
      "systemd-journal"
      "disk"
      "audio"
      "video"
      "plugdev"
      "hidraw"
      "bluez"
    ];
    createHome = true;
    home = "/home/saggins";
    
  };
  # Yubikey
  services.udev.extraRules = ''
    
      ACTION!="add|change", GOTO="u2f_end"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0116",MODE="0660", GROUP="plugdev", TAG+="uaccess"
  ''; 

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
