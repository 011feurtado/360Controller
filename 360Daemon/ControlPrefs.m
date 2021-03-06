/*
 MICE Xbox 360 Controller driver for Mac OS X
 Copyright (C) 2006-2013 Colin Munro
 
 ControlPrefs.m - code to read and write shared preferences
 
 This file is part of Xbox360Controller.
 
 Xbox360Controller is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.
 
 Xbox360Controller is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with Foobar; if not, write to the Free Software
 Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
#import "ControlPrefs.h"

void SetAlertDisabled(int index)
{
    NSString *prop;
    NSNumber *value;

    prop = [NSString stringWithFormat:@"%@%i", D_SHOWONCE, index];
    value = [NSNumber numberWithBool:TRUE];
    CFPreferencesSetValue((CFStringRef)prop, (__bridge CFPropertyListRef)(value), DOM_DAEMON, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    CFPreferencesSynchronize((CFStringRef)DOM_DAEMON, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
}

BOOL AlertDisabled(int index)
{
    NSString *prop;
    BOOL result;
    CFPropertyListRef value;
    
    result = FALSE;
    prop = [NSString stringWithFormat:@"%@%i", D_SHOWONCE, index];
    value = CFPreferencesCopyValue((CFStringRef)prop, DOM_DAEMON, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    if (value != NULL)
    {
        result = [((__bridge NSNumber*)value) boolValue];
        CFRelease(value);
    }
    return result;
}

void SetController(NSString *serial, NSDictionary *data)
{
    CFPreferencesSetValue((CFStringRef)serial, (__bridge CFPropertyListRef)(data), DOM_CONTROLLERS, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    CFPreferencesSynchronize(DOM_CONTROLLERS, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
}

NSDictionary* GetController(NSString *serial)
{
    CFPropertyListRef value;
    
    CFPreferencesSynchronize(DOM_CONTROLLERS, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    value = CFPreferencesCopyValue((CFStringRef)serial, DOM_CONTROLLERS, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    return ((__bridge NSDictionary*)value);
}

NSString* GetSerialNumber(io_service_t device)
{
    CFTypeRef value;
    
    value = IORegistryEntrySearchCFProperty(device, kIOServicePlane, CFSTR("USB Serial Number"), kCFAllocatorDefault, kIORegistryIterateRecursively);
    if (value == NULL)
        value = IORegistryEntrySearchCFProperty(device, kIOServicePlane, CFSTR("SerialNumber"), kCFAllocatorDefault, kIORegistryIterateRecursively);
    return ((__bridge NSString*)value);
}

void ConfigController(io_service_t device, NSDictionary *config)
{
    IORegistryEntrySetCFProperties(device, (__bridge CFTypeRef)(config));
}

void SetKnownDevices(NSDictionary *devices)
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:devices];
    CFPreferencesSetValue((CFStringRef)D_KNOWNDEV, (__bridge CFPropertyListRef)(data), DOM_CONTROLLERS, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    CFPreferencesSynchronize(DOM_CONTROLLERS, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
}

NSDictionary* GetKnownDevices(void)
{
    CFPreferencesSynchronize(DOM_CONTROLLERS, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    return [NSKeyedUnarchiver unarchiveObjectWithData: CFBridgingRelease(CFPreferencesCopyValue((CFStringRef)D_KNOWNDEV, DOM_CONTROLLERS, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost))];
}
