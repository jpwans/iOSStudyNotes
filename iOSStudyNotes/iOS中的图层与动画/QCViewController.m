//
//  QCViewController.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/14.
//

#import "QCViewController.h"
#import "UIImage+Rectangle.h"
#import "TransitionAnimator.h"
@interface QCViewController () <CALayerDelegate, UITabBarDelegate, UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) CALayer *animationLayer;
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
@property (nonatomic, assign) CGPoint touchPoint;
@end

@implementation QCViewController



- (void) startCustomTransitionAnimation {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 将截图添加到主视图
    UIImageView *coverImageView = [[UIImageView alloc] initWithImage:coverImage];
    coverImageView.frame = self.view.bounds;
    [self.view addSubview:coverImageView];
    
    //
    self.view.layer.contents = (id)[UIImage imageNamed:@"白蓝色海洋照片宣传背景"].CGImage;
    
    [UIView animateWithDuration:1 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverImageView.alpha = 0;
        coverImageView.transform = transform;
        
    } completion:^(BOOL finished) {
        [coverImageView removeFromSuperview];
    }];
    
}

- (void)startKeyframeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"backgroundColor";
    animation.values = @[(id)[UIColor whiteColor].CGColor,
                         (id)[UIColor redColor].CGColor,
                         (id)[UIColor blueColor].CGColor,
                         (id)[UIColor blackColor].CGColor,
                         (id)[UIColor whiteColor].CGColor];
    animation.keyTimes = @[@0,@0.2,@0.5,@0.7,@1];
    animation.duration = 5;
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.view.layer addAnimation:animation forKey:nil];
}

- (IBAction)click:(UIButton *)sender {
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    CATransform3D scaleTransform = CATransform3DMakeScale(1.2, 1.2, 1);
//    animation.toValue = [NSValue valueWithCATransform3D:scaleTransform];
//    animation.duration = 0.5;
//    animation.repeatCount = HUGE_VALF;
//    animation.autoreverses = YES;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    [self.animationLayer addAnimation:animation forKey:@"animationScaleKey"];
//
//    [self position];
//
//    [self startCustomTransitionAnimation];
    [self startKeyframeAnimation];
}
- (void)position {
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"position"];
    ani.toValue = [NSValue valueWithCGPoint:self.view.center];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.duration = 0.5;
    ani.repeatCount = HUGE_VALF;
    ani.autoreverses = YES;
//    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.animationLayer addAnimation:ani forKey:@"PostionAni"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    // Do any additional setup after loading the view.
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 200, 50)];
    CATextLayer *text = [CATextLayer layer];
    text.frame = textView.frame;
    text.string = @"CAText";
    text.foregroundColor = [UIColor whiteColor].CGColor;
    text.backgroundColor = [UIColor blackColor].CGColor;
    text.wrapped = YES;
    text.font = (__bridge CFTypeRef)([UIFont systemFontOfSize:30].fontName);
    text.alignmentMode = kCAAlignmentCenter;
    text.contentsScale = [UIScreen mainScreen].scale;
    [textView.layer addSublayer:text];
    [self.view addSubview:textView];


    // CAShapeLayer 矢量图形子类

    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(200, 100)];

    [path addArcWithCenter:CGPointMake(150, 100) radius:50 startAngle:0 endAngle:2*M_PI clockwise:YES];

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 10;
    layer.lineCap =  kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.path = path.CGPath;
    [self.view.layer addSublayer:layer];
//    layer.position
//    layer.anchorPoint

    [self createGradientLayer];
    [self createPolygon];


  

    NSLog(@"Scale:%f",[UIScreen mainScreen].scale);
    self.view.backgroundColor = [UIColor grayColor];
    // anchorPoint position  调节播放器 播放杆子效果
    self.imageView.layer.anchorPoint = CGPointMake(0.5, 0);  // 朝下移动
    self.imageView.layer.position = CGPointMake(self.imageView.superview.frame.size.width*0.5,500);
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI/12);

//    [self setMask];
    

    {
        // 在当前屏幕渲染
        [self rectangle];
        
        self.imageView.backgroundColor = [UIColor redColor];
        // 离屏渲染
        self.imageView.layer.cornerRadius = 10;
        self.imageView.layer.masksToBounds = YES;
        
        // 优化离屏渲染的性能损耗
        self.imageView.layer.shouldRasterize = YES; // 可以使离屏渲染的结果缓存到内存中存为位图
        self.imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        UIImageView *aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
        aImageView.image = [UIImage imageNamed:@"白蓝色海洋照片宣传背景"];
        UIGraphicsBeginImageContextWithOptions(aImageView.bounds.size, NO, 1.0);
        
        [[UIBezierPath bezierPathWithRoundedRect:aImageView.bounds cornerRadius:aImageView.frame.size.width] addClip];
        [aImageView drawRect:aImageView.bounds];
        aImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.view addSubview:aImageView];
  
    }

    {
        self.animationLayer = [CALayer layer];
        self.animationLayer.frame = CGRectMake(50, 50, 100, 100);
        self.animationLayer.backgroundColor = [UIColor redColor].CGColor;
        self.animationLayer.delegate = self;
        [self.view.layer addSublayer:self.animationLayer];
//        [UIView animateWithDuration:0.3 animations:^{
//
//                } completion:^(BOOL finished) {
//
//                }];
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  

    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
/// <#Description#>
- (void)setMask {
    
    // MASK
    self.view.layer.contents =(id)[UIImage imageNamed:@"白蓝色海洋照片宣传背景"].CGImage;
//    self.view.layer.contentsGravity = @"resizeAspect";
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                                                 (self.view.bounds.size.width-150)/2,
                                                                                 (self.view.bounds.size.height-150)/2,
                                                                                 150, 150)];
    searchImageView.image = [UIImage imageNamed:@"螃蟹"];
    self.view.layer.mask = searchImageView.layer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static BOOL playing = false;
    if (!playing) {
        self.imageView.transform = CGAffineTransformIdentity;
    }
    else {
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI/12);
    }
    playing = !playing;
    
    
//    //临时禁用隐式动画
//    [CATransaction begin];
//    CATransaction.disableActions = YES; //临时禁用隐式动画
//    CATransaction.animationDuration = 5;
//    self.animationLayer.backgroundColor = [UIColor greenColor].CGColor;
//    [CATransaction commit];
    
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformScale(transform, 0.5, 0.5);
//
//    transform = CGAffineTransformRotate(transform, M_PI_4);
//
//    transform = CGAffineTransformTranslate(transform, 100, 0);
//    self.imageView.transform = transform;
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    if (@available(iOS 13.0, *)) {
        self.imageView.transform3D = transform;
    } else {
        // Fallback on earlier versions
    }
    
    [self startCustomControllerTransitionAnimation:touches.allObjects.firstObject];
}

// 当前屏幕渲染
- (void)rectangle {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];

    UIImage *image = [UIImage imageNamed:@"icon"];
    image = [image imageWithCornerRadius:50 ofSize:imageView.frame.size];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    imageView.backgroundColor = [UIColor redColor];
}

- (void)createGradientLayer
{
    //    CAGradientLayer 硬件加速的高性能绘制图层，渐变色
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 150, 150)];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = containerView.bounds;

    layer.colors = @[(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor];
    layer.locations = @[@0.0,@0.3,@0.5];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    [containerView.layer addSublayer:layer];
    [self.view addSubview:containerView];
}

- (void)createPolygon{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(160, 100)];
    [path addLineToPoint:CGPointMake(100, 160)];
    [path addLineToPoint:CGPointMake(100, 220)];
    [path addLineToPoint:CGPointMake(160, 280)];
    [path addLineToPoint:CGPointMake(220, 220)];
    [path addLineToPoint:CGPointMake(220, 160)];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.lineWidth = 2;
    layer.lineCap =  kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.path = path.CGPath;
    [self.view.layer addSublayer:layer];
    
}




- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
//    animation.type = @"suckEffect";
    
//    animation.subtype = @"fromBottom";
    [self.view.layer addAnimation:animation forKey:nil];
    
}



- (void)startCustomControllerTransitionAnimation:(UITouch *)touch {
    _touchPoint = [touch locationInView:self.view];
    // 自定义转场动画
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor blackColor];
    vc.transitioningDelegate = self;
   
    [self presentViewController:vc animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    TransitionAnimator *animator = [TransitionAnimator new];
    animator.touchPoint = _touchPoint;
    return animator;
}
@end
