#!/bin/bash
rm 360ControllerInstaller.pkg
rm -rf build

cp welcome.rtf resources
cp license.txt resources

xcodebuild -workspace 360ControllerWorkspace.xcworkspace -scheme 360Controller -archivePath ./build/360Controller archive
xcodebuild -workspace 360ControllerWorkspace.xcworkspace -scheme Pref360Control -archivePath ./build/Pref360Control archive
xcodebuild -workspace 360ControllerWorkspace.xcworkspace -scheme 360Daemon -archivePath ./build/360Daemon archive
xcodebuild -workspace 360ControllerWorkspace.xcworkspace -scheme Wireless360Controller -archivePath ./build/Wireless360Controller archive
xcodebuild -workspace 360ControllerWorkspace.xcworkspace -scheme WirelessGamingReceiver -archivePath ./build/WirelessGamingReceiver archive

# Right now I'm building the Daemon but not packaging it until i figure
# out what in the hell it does and why I care

pkgbuild --root build/360Controller.xcarchive/Products build/360Controller.pkg
pkgbuild --root build/Pref360Control.xcarchive/Products build/Pref360Control.pkg
pkgbuild --root build/Wireless360Controller.xcarchive/Products build/Wireless360Controller.pkg
pkgbuild --root build/WirelessGamingReceiver.xcarchive/Products build/WirelessGamingReceiver.pkg

productbuild --distribution ./Distribution.xml --sign "Developer ID Installer" --package-path build --resources ./resources ./360ControllerInstaller.pkg

open ./360ControllerInstaller.pkg

