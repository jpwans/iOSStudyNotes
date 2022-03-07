//
//  LanguageToolsObjc.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/21.
//

#import "LanguageToolsObjc.h"

@implementation LanguageToolsObjc



- (void) test {
    // 滑动列表的时候计时器暂停
    // 1.将计时器放在 NSRunLoopCommonModes
    // 2.放到另外一个线程 与主线程互不干扰
    
    [[NSRunLoop currentRunLoop]addTimer:[NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
        }] forMode:NSRunLoopCommonModes];
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       [NSTimer timerWithTimeInterval:1 target:self selector:@selector(aaa) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] run];
        
    });
    
}
@end
