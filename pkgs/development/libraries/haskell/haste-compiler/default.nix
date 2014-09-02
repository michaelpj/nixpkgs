# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, binary, blazeBuilder, bzlib, dataBinaryIeee754
, dataDefault, either, filepath, ghcPaths, HTTP, monadsTf, mtl
, network, random, shellmate, systemFileio, tar, transformers
, utf8String, websockets
}:

cabal.mkDerivation (self: {
  pname = "haste-compiler";
  version = "0.4.1";
  sha256 = "15v4c6rxz4n0wmiys6mam8xprcdq8kxnhpwcqnljshr8wlyihn8b";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    binary blazeBuilder bzlib dataBinaryIeee754 dataDefault either
    filepath ghcPaths HTTP monadsTf mtl network random shellmate
    systemFileio tar transformers utf8String websockets
  ];
  meta = {
    homepage = "http://github.com/valderman/haste-compiler";
    description = "Haskell To ECMAScript compiler";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
