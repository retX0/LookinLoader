// -----------------------------------------------------------
// LookinLoader.xm – single source compatible with rootful & rootless
// -----------------------------------------------------------
//  • Uses ROOT_PATH_NS when <rootless.h> is present (rootless build).
//  • Falls back to plain paths when building rootful.
// -----------------------------------------------------------

#include <Foundation/Foundation.h>
#include <dlfcn.h>

// Conditionally include <rootless.h> (only present when building rootless).
#if __has_include(<rootless.h>)
  #import <rootless.h>
  #define LL_PATH(p) ROOT_PATH_NS(p)      // /var/jb/... at runtime
#else
  #define LL_PATH(p) @(p)                 // direct path for rootful
#endif


%ctor {
    @autoreleasepool {
        NSLog(@"[LookinLoader] Skipping injection into SpringBoard");

        NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
        if ([bundleID isEqualToString:@"com.apple.springboard"]) {
            return;
        }

        BOOL enabled = NO;
        NSString *globalPrefsPath = @"/var/mobile/Library/Preferences/dev.ret0.lookinloader.plist";
        NSDictionary *prefsDict = [NSDictionary dictionaryWithContentsOfFile:globalPrefsPath];
        NSArray *enabledApps = [prefsDict objectForKey:@"enabledApps"];

        if (enabledApps && [enabledApps containsObject:bundleID]) {
            enabled = YES;
        }

        if (!enabled) {
            return;
        }

        NSString *libPath = LL_PATH(@"/Library/LookinLoader/LookinServer");
        if ([[NSFileManager defaultManager] fileExistsAtPath:libPath]) {
            dlopen(libPath.UTF8String, RTLD_NOW);
            NSLog(@"[LookinLoader] Loaded %@", libPath);
        } else {
            NSLog(@"[LookinLoader] Library not found at %@", libPath);
        }
    }
}

