#include <dlfcn.h>
#include <time.h>
#import <Foundation/Foundation.h>

static void* _SMJobSubmit;
static int last_inst_time = 0;
static void nouse(){}
static void* _CFPropertyListCreateData = (void*)nouse;

%hookf(CFDataRef, _CFPropertyListCreateData, CFAllocatorRef allocator, CFPropertyListRef propertyList, CFPropertyListFormat format, CFOptionFlags options, CFErrorRef* error) {
    if (CFGetTypeID(propertyList) == CFDictionaryGetTypeID()) {
        NSDictionary* info = (__bridge NSDictionary*)propertyList;
        if (info[@"Service"] != nil && [info[@"Service"] isEqualToString:@"com.apple.mobile.installation_proxy"]) {
            last_inst_time = time(0);
        }
        NSLog(@"_SMJobSubmit => _CFPropertyListCreateData info: %@", info);
    }
	return %orig;
}

%hookf(Boolean, _SMJobSubmit, CFStringRef domain, CFDictionaryRef job, CFTypeID auth, CFErrorRef *outError)
{
    NSMutableDictionary* mjob = [(__bridge NSDictionary*)job mutableCopy];
    if (job != nil && mjob[@"ProgramArguments"] != nil)
    {
        NSArray* argv = mjob[@"ProgramArguments"];
        NSLog(@"_SMJobSubmit argv=%@", argv);

        NSString *path = argv.firstObject;
        NSLog(@"_SMJobSubmit path=%@", path);

        if (time(0) - last_inst_time > 3) // 防止影响Xcode安装调试普通App
        {
            if ([path hasSuffix:@"/debugserver"]) 
            {
                NSMutableArray* new_argv = [argv mutableCopy];
                new_argv[0] = @"/var/jb/usr/bin/debugserver_xcode";
                mjob[@"UserName"] = @"root";
                mjob[@"ProgramArguments"] = new_argv;
                job = (__bridge_retained CFDictionaryRef)mjob;    
            }
        } 
    }
    
    return %orig;
}

%ctor {
    _SMJobSubmit = dlsym(RTLD_DEFAULT, "SMJobSubmit");
}
