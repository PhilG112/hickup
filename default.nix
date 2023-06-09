{ compiler ? "ghc902" }:

let
    config = {
        packageOverrides = pkgs: rec {
            haskell = pkgs.haskell // {
                packages = pkgs.haskell.packages // {
                    "${compiler}" = pkgs.haskell.packages."${compiler}".override {
                        overrides = haskellPackagesNew: haskellPackagesOld: rec {
                            hickup = haskellPackagesNew.callPackage ./hickup.nix {};    
                        };
                    };
                };
            };
        };
    };
    pkgs = import <nixpkgs> { inherit config; };
in
    { hickup = pkgs.haskell.packages.${compiler}.hickup;
    }
