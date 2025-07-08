  let
    pkgs = import <nixpkgs> { config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };};
  fetchApk = pkgs.callPackage ./fetchVersion.nix {};

    mcpe061 = fetchApk {
    url = "https://archive.org/download/MCPEAlpha/PE-a0.6.1-x86.apk";
    hash = "sha256-rfWnsSPGvunJ8rp460dq5rJsnSHXj1IKy3tUt6xpxhI=";
  };
    ninecraftPkgs = builtins.getFlake "github:mcpi-revival/ninecraft";
    #ninecraft = ninecraftPkgs.packages.${pkgs.system}.ninecraft;
    ninecraft = "/nix/store/kzwshkx5mgb29vr8vy29m48ff5s6zc0k-ninecraft-1.2.0";
    startScript = pkgs.writeScript "ninecraft" ''
      NINECRAFT_HOME=ninecraft
      mkdir -p $NINECRAFT_HOME
      cp -r ${import ./.}/* $NINECRAFT_HOME
      ${ninecraft}/bin/ninecraft --home "$NINECRAFT_HOME" --game $(dirname $0)/../share/ninecraft
    '';
    in 
    pkgs.stdenv.mkDerivation rec {
      name = "ninecraft-mod-test";
      src = ./.;
      installPhase = ''
        mkdir -p $out/{bin,share/ninecraft}
        cp ${startScript} $out/bin/${name}
        cp -r ${ninecraftPkgs + "/internal_overrides"} $out/share/ninecraft
        cp -r ${mcpe061}/{lib,assets} $out/share/ninecraft
      '';
    }