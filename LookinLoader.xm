//
//  RHRevealLoader.xm
//  RHRevealLoader
//
//  Created by Richard Heard on 21/03/2014.
//  Copyright (c) 2014 Richard Heard. All rights reserved.
//

#include <dlfcn.h>

%ctor {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSDictionary *prefs = [[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.x.lookinloader.plist"] retain];
    NSString *libraryPath = @"/Library/LookinLoader/LookinServer";

    if([[prefs objectForKey:[NSString stringWithFormat:@"LookinEnabled-%@", [[NSBundle mainBundle] bundleIdentifier]]] boolValue]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
            dlopen([libraryPath UTF8String], RTLD_NOW);
            NSLog(@"LookinLoader loaded %@", libraryPath);
        }
    }
    [pool drain];
}
