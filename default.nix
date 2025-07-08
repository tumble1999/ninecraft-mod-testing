let
  pkgs = import <nixpkgs> { config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };};
  buildNinecraftMod = pkgs.callPackage ./buildNinecraftMod.nix {};
in
  buildNinecraftMod {
    name = "hello";
    src = ./src;
  }