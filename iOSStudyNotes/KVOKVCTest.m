//
//  KVOKVCTest.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/14.
//

#import "KVOKVCTest.h"



@interface Major : NSObject
{
    @private
    NSString *majorName;
}
@end

@implementation Major



@end

@interface Student : NSObject
{
    @private
    NSString *name;
}
@property (nonatomic, strong) Major *major;
@end

@implementation Student



@end

@interface KVOKVCTest()
@property (nonatomic, strong) Student *student;
@end

@implementation KVOKVCTest

- (void)test {
    _student = [[Student alloc] init];
    _student.major = [[Major alloc] init];
    
    [_student setValue:@"Sam" forKey:@"name"];
    [_student setValue:@"ENGLISH" forKeyPath:@"major.majorName"];
    
    NSLog(@"%@",[_student valueForKey:@"name"]);
    NSLog(@"%@",[_student valueForKeyPath:@"major.majorName"]);
    
    [_student addObserver:self forKeyPath:@"major.majorName" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self->_student setValue:@"CHINESE" forKeyPath:@"major.majorName"];
    }];
//
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
//
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        [_student setValue:@"CHINESE" forKeyPath:@"major.majorName"];
//    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"major.majorName"]) {
        NSString *oldVlaue = [change objectForKey:NSKeyValueChangeOldKey];
        NSString *newVlaue = [change objectForKey:NSKeyValueChangeNewKey];
        
        NSLog(@"oldVlaue:%@",oldVlaue);
        NSLog(@"newVlaue:%@",newVlaue);
//        NSLog(@"change:%@",change);
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
//    [super dealloc];
    [_student removeObserver:self forKeyPath:@"major.majorName"];
}
@end
