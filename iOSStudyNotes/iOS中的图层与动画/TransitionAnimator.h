//
//  TransitionAnimator.h
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CGPoint touchPoint;
@end

NS_ASSUME_NONNULL_END
