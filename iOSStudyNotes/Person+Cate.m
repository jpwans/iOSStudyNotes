//
//  Person+Cate.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/13.
//

#import "Person+Cate.h"
#import "objc/runtime.h"

@implementation Person (Cate)
- (id)address {
    return objc_getAssociatedObject(self, @"address");
}

- (void)setAddress:(NSString *)address {
    objc_setAssociatedObject(self, @"address", address, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//+ (void)load {
//    Method description = class_getInstanceMethod(self.class, @selector(description));
//    Method customDescription = class_getInstanceMethod(self.class, @selector(customDescription));
//    method_exchangeImplementations(description, customDescription);
//}

//- (NSString *)customDescription {
//    return [NSString stringWithFormat:@"%s",__func__];
//}


@end
