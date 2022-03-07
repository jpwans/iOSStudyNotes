//
//  Memory.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/15.
//

#import "Memory.h"
#import <UIKit/UIKit.h>
typedef void (^MyBlock)(void);
@interface Memory()
@property (nonatomic, strong) MyBlock block;
@property (nonatomic, copy) NSString *name;
- (void) print;
@end

@implementation Memory
- (void) print {
    
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        NSLog(@"%@",weakSelf.name);
    };
    self.block();
    
//    CAAnimation delegate 是强引用 所以动画完成要移除动画
//    NSNotificationCenter 只是保存了对象的地址 注册用完一定要移除 不然发送消息 通知对象的时候对象可能已经释放变成野指针 可能会造成程序崩溃
    //
    NSArray *array = [NSArray new];
    [array copy];
//     只有不可变数组的copy是浅拷贝 浅拷贝是复制了内存地址 深拷贝是开辟了新的内存空间并且复制原有的内容
    
}
@end
