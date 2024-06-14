//
//  RHRevealLoader.xm
//  RHRevealLoader
//
//  Created by Richard Heard on 21/03/2014.
//  Copyright (c) 2014 Richard Heard. All rights reserved.
//

#include <Foundation/Foundation.h>
#include <dlfcn.h>

%ctor {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    //NSDictionary *prefs = [[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.x.lookinloader.plist"] retain];
    NSString *libraryPath = @"/private/preboot/E9CC79F022012F43DBF23CB479D6560437265815/jb-3gihKswR/procursus/Library/LookinLoader/LookinServer";

    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

    // Skip loading the tweak if the current process is SpringBoard
    if ([bundleIdentifier isEqualToString:@"com.apple.springboard"]) {
        NSLog(@"Skipping LookinLoader for SpringBoard");
        [pool drain];
        return;
    }

    //if([[prefs objectForKey:[NSString stringWithFormat:@"LookinEnabled-%@", [[NSBundle mainBundle] bundleIdentifier]]] boolValue]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
            dlopen([libraryPath UTF8String], RTLD_NOW);
            NSLog(@"LookinLoader loaded %@", libraryPath);
        }
    //}
    [pool drain];
}
