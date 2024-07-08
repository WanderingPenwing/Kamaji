{
  stdenv,
  lib,
  fetchurl,
  libxkbcommon,
  patchelf,
  autoPatchelfHook,
  glib,
  libGL,
  libGLU,
  atk,
  gdk-pixbuf,
  webkitgtk,
  gtk3-x11,
}:
stdenv.mkDerivation rec {
  pname = "jiji";
  version = "v1.0.1";

  src = fetchurl {
    url = "https://github.com/WanderingPenwing/Jiji/releases/download/${version}/jiji-${version}.tar.gz";
    hash = "sha256-xng7MDH4uI6hbvvkgzgQHQwiFCiph/NjvkKBhFwQvC8=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    glib
    libGL
    libGLU
    atk
    gdk-pixbuf
    webkitgtk
    gtk3-x11
  ];

  buildInputs = [
    libxkbcommon
    patchelf
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D jiji $out/bin/jiji
    runHook postInstall
  '';

  # lib.optionalString (!stdenv.isDarwin)
  postFixup = ''
    patchelf --add-needed ${libxkbcommon}/lib/libxkbcommon-x11.so  $out/bin/jiji
    patchelf --add-needed ${libGL}/lib/libGL.so  $out/bin/jiji
    patchelf --add-needed ${libGLU}/lib/libGLU.so  $out/bin/jiji
  '';

  meta = with lib; {
    description = "My Light Messenger";
    homepage = "https://github.com/WanderingPenwing/Jiji";
  };
}
