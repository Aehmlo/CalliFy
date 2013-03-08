#import <Preferences/Preferences.h>
#import <Foundation/NSTask.h>
@interface CalliFyPrefsListController: PSListController {
}
@end

@implementation CalliFyPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"CalliFyPrefs" target:self] retain];
	}
	return _specifiers;
}
-(void)killPhoneApp{
    NSTask *killPhoneAppTask=[[NSTask alloc] init];
    [killPhoneAppTask setLaunchPath:@"/usr/bin/killall"];
    [killPhoneAppTask setArguments:[NSArray arrayWithObject:@"MobilePhone"]];
    [killPhoneAppTask launch];
    [killPhoneAppTask waitUntilExit];
    [killPhoneAppTask release];
}
@end

// vim:ft=objc
