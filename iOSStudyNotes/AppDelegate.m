//
//  AppDelegate.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/11.
//

#import "AppDelegate.h"

//@import CrashReporter;
//#import <CrashReporter/CrashReporter.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#if DEBUG
//iOS
[[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
//同时还支持tvOS和MacOS，配置时只需要在/Applications/InjectionIII.app/Contents/Resources/目录下找到对应的bundle文件,替换路径即可
 #endif
    
//    [self setupCrashReporter];
    return YES;
}



//- (void)setupCrashReporter {
//    // It is strongly recommended that local symbolication only be enabled for non-release builds.
//    // Use PLCrashReporterSymbolicationStrategyNone for release versions.
//    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType: PLCrashReporterSignalHandlerTypeMach
//                                                                       symbolicationStrategy: PLCrashReporterSymbolicationStrategyAll];
//    PLCrashReporter *crashReporter = [[PLCrashReporter alloc] initWithConfiguration: config];
//
//    // Enable the Crash Reporter.
//    NSError *error;
//    if (![crashReporter enableCrashReporterAndReturnError: &error]) {
//        NSLog(@"Warning: Could not enable crash reporter: %@", error);
//    }
//
////    if ([crashReporter hasPendingCrashReport]) {
////        NSError *error;
////
////        // Try loading the crash report.
////        NSData *data = [crashReporter loadPendingCrashReportDataAndReturnError: &error];
////        if (data == nil) {
////            NSLog(@"Failed to load crash report data: %@", error);
////            return;
////        }
////
////        // Retrieving crash reporter data.
////        PLCrashReport *report = [[PLCrashReport alloc] initWithData: data error: &error];
////        if (report == nil) {
////            NSLog(@"Failed to parse crash report: %@", error);
////            return;
////        }
////
////        // We could send the report from here, but we'll just print out some debugging info instead.
////        NSString *text = [PLCrashReportTextFormatter stringValueForCrashReport: report withTextFormat: PLCrashReportTextFormatiOS];
////        NSLog(@"%@", text);
////
////        // Purge the report.
////        [crashReporter purgePendingCrashReport];
////    }
//
//}




@end
