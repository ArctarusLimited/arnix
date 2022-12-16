{ lib
, stdenv
, fetchzip
, autoPatchelfHook
, makeWrapper
, # other stuff
  db4
, gtk2
, libSM
, libpng12
, sqlite
, ncurses5
, pcsclite
, freetype
, readline
, libXxf86vm
, libXScrnSaver
}:

stdenv.mkDerivation rec {
  pname = "secworld";
  version = "12.80.4";

  src = fetchzip {
    url = "https://backblast.s3.eu-central-003.backblazeb2.com/ncipher/secworld-lin64-${version}.zip";
    sha256 = "sha256-jDQAAsk7Pzk0yaZsi0OxfJnyL43yTjnLtX89iFue/a8=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    db4
    gtk2
    libSM
    libpng12
    sqlite
    ncurses5
    freetype
    readline
    libXxf86vm
    libXScrnSaver
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir $out
    cd $out

    tar xf $src/linux/amd64/devref.tar.gz
    tar xf $src/linux/amd64/ctls.tar.gz
    tar xf $src/linux/amd64/ncsnmp.tar.gz
    tar xf $src/linux/amd64/raserv.tar.gz
    tar xf $src/linux/amd64/jd.tar.gz
    tar xf $src/linux/amd64/ctd.tar.gz
    tar xf $src/linux/amd64/javasp.tar.gz
    tar xf $src/linux/amd64/hwsp.tar.gz
  '';

  # both of these python programs dynamically load libpcsclite.so.1
  postFixup = ''
    wrapProgram $out/opt/nfast/bin/raccmd --set LD_LIBRARY_PATH "${pcsclite.out}/lib"
    wrapProgram $out/opt/nfast/bin/racgui --set LD_LIBRARY_PATH "${pcsclite.out}/lib"
  '';

  meta = with lib; {
    description = "Security World support software";
    homepage = "https://www.entrust.com/digital-security/hsm/products/nshield-software";
    maintainers = with maintainers; [ citadelcore ];
    platforms = [ "x86_64-linux" ];
  };
}
