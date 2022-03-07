//
//  NSString+Category.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/13.
//

#import "NSString+Category.h"
#import <objc/runtime.h>

@implementation NSString (Category)


- (NSString *)newString {
        return objc_getAssociatedObject(self, @"newString");
}

- (void)setNewString:(NSString *)newString {
    objc_setAssociatedObject(self, @"newString", newString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
