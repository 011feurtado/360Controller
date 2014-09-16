# XBox 360 Controller driver for Mac OS X
Copyright (C) 2006-2013 Colin Munro
Copyright (C) 2014 Steve Luzynski

Project page: http://sluzynsk.github.io/360Controller
Project repo: https://github.com.io/sluzynsk/360Controller
More info at: http://www.luzynski.com
Download link: http://www.luzynski.com/downloads/360ControllerInstaller.pkg

## Current release: 1.0.0d13 - beta 1 for Yosemite 10.10.

## About
This driver supports the Microsoft Xbox 360 controller, including access to rumble motors and LEDs,
on the Mac OS X platform. It includes a plugin for the Apple Force Feedback Framework so some games
will be able to activate them, along with a Preference Pane with which allows you to test everything
is installed correctly. Both wired 360 controllers connected via USB, and wireless 360 controllers
connected via the Wireless Gaming Receiver for Windows, are supported.

The driver was originally created by Colin Munro. In 2014, I contacted Colin offering my help in updating the
driver to run properly under Mac OS X 10.10 "Yosemite". My email went unanswered. Given that Colin has
not updated the driver in over a year, and that he has not answered my attempts at contacting him, I have
decided to fork the driver and update it. If Colin and I do sync up we will likely re-merge efforts;
for now consider this version to be the definitive version for newer versions of Mac OS.

As for why it needed updating - starting with 10.10, Apple requires that kexts (device drivers) for Mac
follow some new rules. One of them is that they be digitally signed by a paid Mac developer. In order
to sign the driver I needed to be able to build it; as my development machine is 10.10 based I was forced
to update the driver to compile on 10.10. This required many changes which are outlined in the developer section below.

## Licence
This driver is licensed under the GNU Public License. A copy of this license is included in the
distribution file, please inspect it before using the binary or source.

## Installation
Simply complete the installer package to install the driver. The driver will recommend you restart -
if you do not, the driver will only be usable if the controller is already connected or connected
within a minute after the installer completes. If you are interested in installing as a developer please see below.

## Usage
The driver exposes a standard game pad with a number of standard controls, so any game that supports
gaming devices should work. In some cases this may need an update from the manufacturer of the game or
a patched version. The Preference Pane uses the standard Mac OS X Frameworks for accessing HID devices
and accessing Force Feedback capabilities, so should be a good test that the installation is functional.

## Known Problems/Todo
Colin's last version of the driver had some functionality I have temporarily had to remove:
* Force feedback is currently disabled until I can rewrite it into the main driver (not a plugin).
* I also had to remove the feature that allowed the preference pane to rewrite the Info.plist for the driver as that cannot be allowed any longer in a signed driver.

This is the old Todo list. These things are still in play once I get the above issues fixed.
* The rumble motor test on the triggers of the Preference Pane bypasses the Force Feedback Framework functionality, so isn't actually testing it. It really should, for completeness (and it'd help adding support for more complex effects) - this test is now disabled in the normal release anyway.
* Force Feedback plugin may make effects run slower (e.g. longer time) than they should.
* Driver probably needs to be more resilient to errors and odd cases.
* Better Force Feedback "emulation".
* Extra settings? E.g. trigger deadzones, control remapping.
* Someone has requested old Xbox Controller support too. It is unlikely that I will do this.


## Contact me
Please feel free to contact me with any comments, questions and so on using the form at the URL at the
top of the file.

## Developer info
Anything below this probably doesn't affect end users, so you can stop reading now if you just want to use the driver.

## Building
The distribution currently consists of multiple projects contained in an XCode workspace - one for the driver
(implemented in C++, as an I/O Kit C++ class), one for the force feedback support plugin (implemented in
C, as an I/O Kit COM plugin) and one for the Preference Pane (implemented in Objective C as a preference pane plugin).
There are additional projects for the wireless receiver. These should probably all be in a single project
but Colin didn't start it out that way and I've not yet made that happen.

To build, use the standard Xcode build for Deployment on each of the projects. Right now the Feedback plugin builds
but it cannot be installed into the main controller bundle as it breaks the signature. Also, the build script
does not work and is only included for reference.

## Debugging
Most of the debugging I did was via printing out text. In 360Controller, you can use IOLog(), and the
output will appear in system.log. In Feedback360 normal fprintf(stderr,...), and the output will appear
on the console of whatever application is attempting to use Force Feedback. In Pref360Control NSLog() works
as it's an Objective C program, and will output to the console of the Preferences application.

## Other information
I wrote the driver from scratch, using Apple documentation and drivers simply as a reference and not
basing it upon any existing source. As such, some things may be done strangely or incorrectly, so excuse any
weirdness. I've also tried to include comments to explain generally what's going on :)

You will be unable to install kexts you build yourself unless you have a kext signing enabled Developer ID,
or you put your Mac into kext debugging mode - i.e. "kext-dev-mode=1". If you don't know what any of that means,
just run the binary installer package that I provide.
