;; -*- mode: emacs-lisp; coding: utf-8; -*-
(custom-set-variables
 '(w3m-imagick-convert-program "convert.exe")
 '(w3m-imagick-identify-program "identify.exe")
 '(w3m-default-display-inline-images t))
(setq dynamic-library-alist
      '((xpm "libXpm.dll")
        (png "libpng14-14.dll")
        (jpeg "libjpeg.dll")
        (tiff "libtiff3.dll")
        (gif "libungif4.dll" "giflib4.dll")
        (svg "librsvg-2-2.dll")
        (gdk-pixbuf "libgdk_pixbuf-2.0-0.dll")
        (glib "libglib-2.0-0.dll")
        (gobject "libgobject-2.0-0.dll")))
