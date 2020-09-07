let
  moz_overlay = import (
    builtins.fetchGit {
      url = "git@github.com:mozilla/nixpkgs-mozilla.git";
      rev = "efda5b357451dbb0431f983cca679ae3cd9b9829";
    }
  );
  
  native-pkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
  pkgs = import <nixpkgs> {
    crossSystem = native-pkgs.lib.systems.examples.armv6l-unknown-linux-musleabihf;
  };

  rust = (native-pkgs.rustChannels.stable.rust.override {
    targets = [
      "armv7-unknown-linux-musleabihf"
    ];
  });
in
native-pkgs.pkgsCross.armv7l-hf-multiplatform.pkgsStatic.stdenv.mkDerivation {
  name = "hello-remarkable";
  nativeBuildInputs = [ rust ];
  src = ./.;
}
