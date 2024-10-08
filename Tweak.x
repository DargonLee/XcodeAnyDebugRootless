#import <Foundation/Foundation.h>
#include <dlfcn.h>

static void* _SMJobSubmit;

%hookf(Boolean, _SMJobSubmit, CFStringRef domain, CFDictionaryRef job, CFTypeID auth, CFErrorRef *outError)
{
    NSMutableDictionary* mjob = [(__bridge NSDictionary*)job mutableCopy];
    if (job != nil && mjob[@"ProgramArguments"] != nil)
    {
        NSArray* argv = mjob[@"ProgramArguments"];

        NSLog(@"_SMJobSubmit argv=%@", argv);

        if ([argv[0] hasSuffix:@"/debugserver"])
        {
            NSMutableArray* new_argv = [argv mutableCopy];

            new_argv[0] = @"/var/jb/usr/bin/debugserver_xcode";

            mjob[@"UserName"] = @"root";
            mjob[@"ProgramArguments"] = new_argv;
        }

        job = (__bridge_retained CFDictionaryRef)mjob;     
    }
    return %orig;
}

%ctor {
    _SMJobSubmit = dlsym(RTLD_DEFAULT, "SMJobSubmit");
}
