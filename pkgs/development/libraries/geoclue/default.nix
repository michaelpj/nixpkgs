{ fetchurl, stdenv, intltool, pkgconfig, gtk-doc, docbook_xsl, docbook_xml_dtd_412, glib, json-glib, libsoup, libnotify, gdk_pixbuf
, modemmanager, avahi, glib-networking, wrapGAppsHook, gobjectIntrospection
# doc build currently seems to be broken
, enableDocs ? false
, withDemoAgent ? false
}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "geoclue-${version}";
  version = "2.4.11";

  src = fetchurl {
    url = "https://www.freedesktop.org/software/geoclue/releases/${stdenv.lib.versions.majorMinor version}/${name}.tar.xz";
    sha256 = "07gk2fbl1wg4fbqj5f1vap3xvw0dszisllfdx81hbbxcwkvpyf81";
  };

  outputs = [ 
    "out" 
    "dev" 
  ] ++ optionals enableDocs [ "devdoc"];

  nativeBuildInputs = [
    pkgconfig intltool wrapGAppsHook gobjectIntrospection
  ] ++ optionals enableDocs [ gtk-doc docbook_xsl docbook_xml_dtd_412 ];

  buildInputs = [
    glib json-glib libsoup avahi
  ] ++ optionals withDemoAgent [
    libnotify gdk_pixbuf
  ] ++ optionals (!stdenv.isDarwin) [ modemmanager ];

  propagatedBuildInputs = [ glib glib-networking ];

  configureFlags = [
    "--with-systemdsystemunitdir=$(out)/etc/systemd/system"
    "--enable-introspection"
    "--enable-gtk-doc=${if enableDocs then "yes" else "no"}"
    "--enable-demo-agent=${if withDemoAgent then "yes" else "no"}"
  ] ++ optionals stdenv.isDarwin [
    "--disable-silent-rules"
    "--disable-3g-source"
    "--disable-cdma-source"
    "--disable-modem-gps-source"
    "--disable-nmea-source"
  ];

  # https://gitlab.freedesktop.org/geoclue/geoclue/issues/73
  postInstall = ''
    sed -i $dev/lib/pkgconfig/libgeoclue-2.0.pc -e "s|includedir=.*|includedir=$dev/include|"
  '';

  meta = with stdenv.lib; {
    description = "Geolocation framework and some data providers";
    homepage = https://gitlab.freedesktop.org/geoclue/geoclue/wikis/home;
    maintainers = with maintainers; [ raskin garbas ];
    platforms = with platforms; linux ++ darwin;
    license = licenses.lgpl2;
  };
}
