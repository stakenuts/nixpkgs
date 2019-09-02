{ stdenv, meson, ninja, gettext, fetchurl
, pkgconfig, gtk3, glib, libxml2, gnome-desktop, adwaita-icon-theme
, wrapGAppsHook, gnome3, harfbuzz }:

stdenv.mkDerivation rec {
  pname = "gnome-font-viewer";
  version = "3.33.90";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-font-viewer/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "0409dysyb3vccbqaf3i8542p2l2j8y0qrmn5fqllj18iwr68xi2y";
  };

  doCheck = true;

  nativeBuildInputs = [ meson ninja pkgconfig gettext wrapGAppsHook libxml2 ];
  buildInputs = [ gtk3 glib gnome-desktop adwaita-icon-theme harfbuzz ];

  # Do not run meson-postinstall.sh
  preConfigure = "sed -i '2,$ d'  meson-postinstall.sh";

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = "gnome-font-viewer";
      attrPath = "gnome3.gnome-font-viewer";
    };
  };

  meta = with stdenv.lib; {
    description = "Program that can preview fonts and create thumbnails for fonts";
    maintainers = gnome3.maintainers;
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
