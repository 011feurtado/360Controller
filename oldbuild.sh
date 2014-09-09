#!/bin/bash
cd Feedback360
xcodebuild -configuration Release
if [ $? -ne 0 ]
  then
    echo "******** BUILD FAILED ********"
    exit 1
fi
cd ../DriverTool
xcodebuild -configuration Release
if [ $? -ne 0 ]
  then
    echo "******** BUILD FAILED ********"
    exit 1
fi
cd ../360Controller
xcodebuild -configuration Release
if [ $? -ne 0 ]
  then
    echo "******** BUILD FAILED ********"
    exit 1
fi
cd ../360Daemon
xcodebuild -configuration Release
if [ $? -ne 0 ]
  then
    echo "******** BUILD FAILED ********"
    exit 1
fi
cd ../WirelessGamingReceiver
xcodebuild -configuration Release
if [ $? -ne 0 ]
  then
    echo "******** BUILD FAILED ********"
    exit 1
fi
cd ../Wireless360Controller
xcodebuild -configuration Release
if [ $? -ne 0 ]
  then
    echo "******** BUILD FAILED ********"
    exit 1
fi
cd ../Pref360Control
xcodebuild -configuration Release 
if [ $? -ne 0 ]
  then
    echo "******** BUILD FAILED ********"
    exit 1
fi
echo "** File signatures **"
spctl -a -v 360Controller/build/Deployment/360Controller.kext
spctl -a -v 360Controller/build/Deployment/360Controller.kext/Contents/PlugIns/Feedback360.plugin
spctl -a -v 360Daemon/build/Release/360Daemon
spctl -a -v Pref360Control/build/Deployment/Pref360Control.prefPane
spctl -a -v Pref360Control/build/Deployment/Pref360Control.prefPane/Contents/Resources/DriverTool
spctl -a -v WirelessGamingReceiver/build/Release/WirelessGamingReceiver.kext
spctl -a -v Wireless360Controller/build/Release/Wireless360Controller.kext
spctl -a -v --type install Install360Controller/build/Install360Controller.pkg
echo "*** DONE ***"
