#!/bin/bash
rm 360ControllerInstaller.pkg
rm -rf build

xcodebuild -workspace 360ControllerWorkspace.xcworkspace -scheme 360Controller -archivePath ./build/360Controller archive
xcodebuild -workspace 360ControllerWorkspace.xcworkspace -scheme Pref360Control -archivePath ./build/Pref360Control archive
xcodebuild -workspace 360ControllerWorkspace.xcworkspace -scheme Wireless360Controller -archivePath ./build/Wireless360Controller archive
xcodebuild -workspace 360ControllerWorkspace.xcworkspace -scheme WirelessGamingReceiver -archivePath ./build/WirelessGamingReceiver archive

pkgbuild --root build/360Controller.xcarchive/Products build/360Controller.pkg
pkgbuild --root build/Pref360Control.xcarchive/Products build/Pref360Control.pkg
pkgbuild --root build/Wireless360Controller.xcarchive/Products build/Wireless360Controller.pkg
pkgbuild --root build/WirelessGamingReceiver.xcarchive/Products build/WirelessGamingReceiver.pkg

productbuild --distribution ./Distribution.xml --sign "Developer ID Installer" --package-path build ./360ControllerInstaller.pkg
