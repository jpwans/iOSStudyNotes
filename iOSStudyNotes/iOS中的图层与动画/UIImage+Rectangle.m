//
//  UIImage+Rectangle.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/14.
//

#import "UIImage+Rectangle.h"

@implementation UIImage (Rectangle)
- (UIImage *)imageWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
