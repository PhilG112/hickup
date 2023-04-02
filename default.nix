let
    pkgs = import <nixpkgs> {};
in
    {
        hickup = pkgs.haskellPackages.callPackage ./hickup.nix {};
    }
