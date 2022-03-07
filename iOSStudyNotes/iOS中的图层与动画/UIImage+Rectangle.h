//
//  UIImage+Rectangle.h
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Rectangle)
- (UIImage *)imageWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
