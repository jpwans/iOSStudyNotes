//
//  Person.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/11.
//

#import "Person.h"
#import "objc/runtime.h"
#import "PersonHelper.h"
@interface Person()
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) PersonHelper *helper;
@end

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sex = @"male";
        _helper = [PersonHelper new];
    }
    return self;
}


- (void)saySomting {
    NSLog(@"%s --- %@",__func__,self.name);
}


//+(BOOL)resolveClassMethod:(SEL)sel {
    
//}
// 消息转发的动态方法解析 
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    NSString *str = NSStringFromSelector(sel);
//    if ([str isEqualToString:@"eat"]) {
//        IMP imp = method_getImplementation(class_getInstanceMethod(self, @selector(brealfast)));
//        class_addMethod(self, @selector(eat), imp, "");
//    }
//    return [super resolveInstanceMethod:sel];
//}

- (void)brealfast {
    NSLog(@"%s",__func__);
}


//// 备用接受者
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    NSString *str = NSStringFromSelector(aSelector);
//    if ([str isEqualToString:@"eat"]) {
//        return _helper;
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}


// 完整消息转发 带方法签名

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature && [_helper methodSignatureForSelector:aSelector]) {
        signature = [_helper methodSignatureForSelector:aSelector];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([_helper respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_helper];
    }
}

@end
