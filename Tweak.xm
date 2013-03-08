#import <CoreFoundation/CoreFoundation.h> //Whee!!!
extern "C" {
    CFStringRef CFBundleCopyLocalizedString(CFBundleRef bundle, CFStringRef key, CFStringRef value, CFStringRef tableName);
}

static CFStringRef (*orig_CFBundleCopyLocalizedString)(CFBundleRef bundle, CFStringRef key, CFStringRef value, CFStringRef tableName);
CFStringRef new_CFBundleCopyLocalizedString(CFBundleRef bundle, CFStringRef key, CFStringRef value, CFStringRef tableName){
        if(CFStringCompare(key,CFSTR("CALL"),0)==0){ // If this is the "CALL" string
            if([[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.aehmlo.callify.plist"] objectForKey:@"Text"]!=nil && ![[[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.aehmlo.callify.plist"] objectForKey:@"Text"] isEqualToString:@""]){ //If the key is specified and is not empty
                    return CFStringCreateWithCString(NULL,[[[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.aehmlo.callify.plist"] objectForKey:@"Text"] UTF8String],kCFStringEncodingUTF8); //Yes, I know how ugly this is. I'm sorry.
            } else {
                return orig_CFBundleCopyLocalizedString(bundle, key, value, tableName); // Original function - condition not satisfied.
            }
        } else {
            return orig_CFBundleCopyLocalizedString(bundle, key, value, tableName); // See above.
        }
}
%ctor{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    
    MSHookFunction(CFBundleCopyLocalizedString, new_CFBundleCopyLocalizedString, &orig_CFBundleCopyLocalizedString); //This is the most complex part of the whole thing. See iphonedevwiki.net for more info on MSHookFunction().
    
    [pool drain];
}