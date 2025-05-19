{ lib
, stdenv
, fetchzip
, makeWrapper
}:

stdenv.mkDerivation rec {
  pname   = "digital-logic-sim";
  version = "0.1.4";          # adjust to the tag / build date you mirrored

  src = fetchzip {
    url    = "https://example.com/DigitalLogicSim_Linux.zip";
    sha256 = "sha256-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"; # ← from nix-prefetch
    stripRoot = false;        # keep the directory structure
  };

  nativeBuildInputs = [ makeWrapper ];

  buildPhase = "true";        # binary-only

  installPhase = ''
    mkdir -p $out/opt/dls
    cp -r * $out/opt/dls

    mkdir -p $out/bin
    makeWrapper $out/opt/dls/DigitalLogicSim.x86_64 \
      $out/bin/digital-logic-sim \
      --chdir $out/opt/dls               \
      --set   LD_LIBRARY_PATH ${stdenv.cc.libc}/lib
  '';

  meta = with lib; {
    description = "Minimalistic digital logic simulator by Sebastian Lague";
    homepage    = "https://sebastian.itch.io/digital-logic-sim";
    license     = licenses.mit;          # confirmed in upstream repo :contentReference[oaicite:1]{index=1}
    platforms   = platforms.linux;
    maintainers = [ maintainers.yourname ];
  };
}

