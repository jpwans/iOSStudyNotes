//
//  main.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/11.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>
#import "Test.h"
#import "fishhook.h"


//static int (*orig_close)(int);
//static int (*orig_open)(const char *, int, ...);
//
//int my_close(int fd) {
//  printf("Calling real close(%d)\n", fd);
//  return orig_close(fd);
//}
//
//int my_open(const char *path, int oflag, ...) {
//  va_list ap = {0};
//  mode_t mode = 0;
//
//  if ((oflag & O_CREAT) != 0) {
//    // mode only applies to O_CREAT
//    va_start(ap, oflag);
//    mode = va_arg(ap, int);
//    va_end(ap);
//    printf("Calling real open('%s', %d, %d)\n", path, oflag, mode);
//    return orig_open(path, oflag, mode);
//  } else {
//    printf("Calling real open('%s', %d)\n", path, oflag);
//    return orig_open(path, oflag, mode);
//  }
//}


int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
//        Test *test = [Test new];
//        [test instanceMethod];
        
//        [Test instancesRespondToSelector:<#(SEL)#>]
//        [Test respondsToSelector:<#(SEL)#>];
//        @selector(sdad)
//        id nsobj = [[NSObject alloc] init];
//        void *p = (__bridge void*)nsobj;
//        id nsobjs = (__bridge id)p;
//        NSObject *o =  NSObject.alloc.init;
//        
//        [self ]
//        [test se]
        
//        dispatch_sync(dispatch_get_main_queue(), ^{
//           NSLog(@"2");
//        });
//    exit(0);
        
//        rebind_symbols((struct rebinding[2]){{"close", my_close, (void *)&orig_close}, {"open", my_open, (void *)&orig_open}}, 2);
//
//           // Open our own binary and print out first 4 bytes (which is the same
//           // for all Mach-O binaries on a given architecture)
//           int fd = open(argv[0], O_RDONLY);
//           uint32_t magic_number = 0;
//           read(fd, &magic_number, 4);
//           printf("Mach-O Magic Number: %x \n", magic_number);
//           close(fd);
        
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}


