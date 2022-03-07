//
//  Test.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/13.
//

#import "Test.h"

#import <objc/runtime.h>
#import "Test2.h"
@implementation Test



+ (void)classFun {
    NSLog(@"%s",__func__);
}
- (void)objFunc {
    NSLog(@"%s",__func__);
}



void instanceMethod(id self, SEL _cmd) {
    NSLog(@"收到消息执行这个方法");
    
}

//# 添加自定义方法
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(instanceMethod)) {
//        class_addMethod(self, sel, (IMP)instanceMethod, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}




//# 转发

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(instanceMethod)) {
//        return [Test2 new];
//    }
//    return nil;
//}

#pragma mark - 方法签名转发

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *selName = NSStringFromSelector(aSelector);
    if ([selName isEqualToString:@"instanceMethod"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = [anInvocation selector];
    Test2 *test2 = [Test2 new];
    if ([test2 respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:test2];
    }
}




- (void)instanceMethod1 {
    NSLog(@"%s",__func__);
}
- (void)instanceMethod2 {
    NSLog(@"%s",__func__);
}

+ (void)classMethod1 {
    NSLog(@"%s",__func__);
}
+ (void)classMethod2 {
    NSLog(@"%s",__func__);
}

+ (void)load {

    // 方法的交换
   Class class = [self class];

    SEL selInsMethod1 = @selector(instanceMethod1);
    SEL selInsMethod2 = @selector(instanceMethod2);
    SEL selClassMethod1 = @selector(classMethod1);
    SEL selClassMethod2 = @selector(classMethod2);

    Method insMethod1 = class_getInstanceMethod(class, selInsMethod1);
    Method insMethod2 = class_getInstanceMethod(class, selInsMethod2);
    Method classMethod1 = class_getClassMethod(class, selClassMethod1);
    Method classMethod2 = class_getClassMethod(class, selClassMethod2);
    
    
    //替换类方法和实例方法的实现
//    {
//        if (!insMethod1 || !insMethod2) {
//            NSLog(@"实例方法交换失败");
//            return;
//        }
//
//        method_exchangeImplementations(insMethod1, insMethod2);
//
//        if (!classMethod1 || !classMethod2) {
//            NSLog(@"类方法交换失败");
//            return;
//        }
//        method_exchangeImplementations(classMethod1, classMethod2);
//    }
    
    // 重新设置类中某个方法的实现
    IMP impInsMethod1 = method_getImplementation(insMethod1);
    IMP impInsMethod2 = method_getImplementation(insMethod2);
    IMP impClassMethod1 = method_getImplementation(classMethod1);
    IMP impClassMethod2 = method_getImplementation(classMethod2);
//    
//    method_setImplementation(insMethod1, impInsMethod2);
//    method_setImplementation(insMethod2, impInsMethod1);
//    method_setImplementation(classMethod1, impClassMethod2);
//    method_setImplementation(classMethod2, impClassMethod1);
    
    // 替换类中某个方法的实现
    const char* typeInsMethod1 = method_getTypeEncoding(insMethod1);
    const char* typeInsMethod2 = method_getTypeEncoding(insMethod2);
    const char* typeClassMethod1 = method_getTypeEncoding(classMethod1);
    const char* typeClassMethod2 = method_getTypeEncoding(classMethod2);
    
    // 替换insMethod1的实现为insMethod2的实现
    class_replaceMethod(class, selInsMethod1, impInsMethod2, typeInsMethod2);
    
    // 替换insMethod2的实现为insMethod1的实现
    class_replaceMethod(class, selInsMethod2, impInsMethod1, typeInsMethod1);
    
//#error 类方法
    // 替换类方法的实现  类方法没法调换
    class_replaceMethod(class, selClassMethod1, impClassMethod2, typeClassMethod2);
    class_replaceMethod(class, selClassMethod2, impClassMethod1, typeClassMethod1);
    
    

    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    /* 为类添加新的方法*/
    SEL selNewInsMethod = @selector(newInsMethod);
    BOOL isInsAdded = class_addMethod(class, selNewInsMethod, impInsMethod1, typeInsMethod1);
    if (!isInsAdded) {
        NSLog(@"新实例方法添加失败！");
    }
#pragma clang diagnostic pop
    
    
    
    
}


@end
