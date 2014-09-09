#!/bin/bash
# Right now this depends on manually building from the gui and archiving 
# into the build directory. Clearly this is sub-optimal and will be fixed ASAP.

cd build

pkgbuild --root 360Controller 360Controller.pkg
pkgbuild --root Pref360Control Pref360Control.pkg
pkgbuild --root Wireless360Controller Wireless360Controller.pkg
pkgbuild --root WirelessGamingReceiver WirelessGamingReceiver.pkg
productbuild --distribution ./Distribution.xml --package-path . ./360ControllerInstaller.pkg
productsign --sign "Developer ID Installer" 360ControllerInstaller.pkg Installer.pkg
