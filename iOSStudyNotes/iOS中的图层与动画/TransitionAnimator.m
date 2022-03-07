//
//  TransitionAnimator.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/15.
//

#import "TransitionAnimator.h"


typedef void(^Callback)(void);
@interface TransitionAnimator() <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>
{
    Callback callback;
}

@end

@implementation TransitionAnimator



///
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromV = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toV = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    //将视图添加到containerView
    [containerView addSubview:fromV];
    [containerView addSubview:toV];
    
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.width;
    CGPoint tempPoint = [containerView convertPoint:self.touchPoint fromView:fromV];
    CGRect rect = CGRectMake(tempPoint.x - 1, tempPoint.y -1, 2, 2);
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWith*screenWith) startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.path = endPath.CGPath;
    maskLayer.path = startPath.CGPath;
    toV.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (id)startPath.CGPath;
    animation.toValue = (id)endPath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    
    //视图状态停留在动画结束的那一刻
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [maskLayer addAnimation:animation forKey:@"custom"];
    callback = ^{
        toV.layer.mask = nil;
        [maskLayer removeAnimationForKey:@"custom"];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    };
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    callback();
}
@end
