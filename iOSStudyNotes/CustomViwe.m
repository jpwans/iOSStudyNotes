//
//  CustomViwe.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/12.
//

#import "CustomViwe.h"

@interface CustomViwe()

@property (nonatomic, strong) NSString *name;

@end

@implementation CustomViwe


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    return [super pointInside:point withEvent:event];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        objc_msgSend(self)
    }
    return self;
}

@dynamic name;


@end
