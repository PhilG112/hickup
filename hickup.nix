{ mkDerivation, aeson, base, containers, lib, mtl, servant
, servant-server, text
}:
mkDerivation {
  pname = "hickup";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base containers mtl servant servant-server text
  ];
  license = lib.licenses.mit;
  mainProgram = "hickup";
}
