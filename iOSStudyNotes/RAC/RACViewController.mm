//
//  RACViewController.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/16.
//

#import "RACViewController.h"
#import <ReactiveObjc/ReactiveObjC.h>

#import <SDWebImage/UIImageView+WebCache.h>

#include <stdio.h>
#include <iostream>
@interface RACViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        int a = 0;
        [subscriber sendNext:@(a)];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"x:%@",x);
    }];
    
//    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//            NSLog(@"text:%@",x);
//        }];
    
    [[self.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
            return value.length > 6 ;
        }] subscribeNext:^(NSString * _Nullable x) {
          NSLog(@"text value:%@",x);
        }];
    
    [[self.textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
            return @(value.length);
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"text Length:%@",x);
    }] ;
    
    [[[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] throttle:2] subscribeNext:^(__kindof UIControl * _Nullable x) {
           NSLog(@"click");
        }];
    
    //将某个对象的text属性绑定到uitextfield 的text上
//    RAC(self.model,text) = self.textField.rac_textSignal;
    
    NSArray *numbers = @[@1,@2,@3,@4];
    [numbers.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
                NSLog(@"numbers:%@",x);
    }];
//    [self.view setBackgroundColor:[UIColor redColor]];
//    MKAnnotationView *a = [MKAnnotationView]
    
//    NSMutableDictionary *dict;
//    [dict setValue:@"a" forKey:@"b"];
//    NSLog(@"%@",dict);
//    [self respondsToSelector:@selector(aaa)];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://img2.baidu.com/it/u=2488442131,81741953&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500"]  placeholderImage:[UIImage imageNamed:@"螃蟹"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    
//    Analyze 可以分析出未使用的僵尸对象
//    [numbers draw];
    
    int n = 'e';
    switch (n--) {
        default:
            NSLog(@"error");
        case 'a':
        case 'b':
            NSLog(@"good");
            break;
        case 'c':
            NSLog(@"pass");
        case  'd':
            NSLog(@"warn");
            

    }
    
//    Class cls = Nil;//
    // Nil 用于表示Objective-C类（Class）类型的变量值为空
    // oc对象用nil
    // NULL C++ (void *)0
//    NSNull ，NSNull是一个Objective-C类，只不过这个类相当特殊，因为它表示的是空值，即什么都不存。它也只有一个单例方法+[NSUll null]。该类通常用于在集合对象中保存一个空的占位对象。
    
//    int array[4][4]={ {1,2,8,9}, {2,4,9,2}, {4,7,10,13}, {6,8,11,15}};
//    int target = 7;
    
    NSArray *array =
    @[
        @[@1,@2,@8,@9],
        @[@2,@4,@9,@12],
        @[@4,@7,@10,@13],
        @[@6,@8,@11,@15]
    ];
    
//    NSInteger target = 7;
    
    BOOL a = [self find:7 array:array];
    BOOL b = [self find:5 array:array];
    
    NSLog(@"有没有7：%d",a);
    NSLog(@"有没有5：%d",b);
    
    char arrayss[] = "china";
//    arrayss.co
    /// 数组最后多个'\0'
    NSLog(@"array:%lu",sizeof(arrayss));
    
    
//    static 是 c /c ++都存在的关键字
    // 被static 修饰的全局变量 只能在本模块使用 本地全局变量  普通全局变量可以供外部其它模块使用
//    staticString
    // static 在函数体内部 只会初始化一次 不会被销毁  相当于有记忆功能 下次调用还是上一次的值  普通变量就没有记忆功能
//    static 函数 本地模块中
}
static void what(){
    
}
//static + (void)sss


//在一个二维数组中（每个一维数组的长度相同），
//每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。
//请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。

- (BOOL)find:(NSInteger)target array:(NSArray *)array {
    NSInteger rows = array.count;
    NSInteger cols = ((NSArray *)[array firstObject]).count;
    if (rows == 0 || cols == 0) {
        return NO;
    }
    if (target < [(array[0][0]) integerValue] || target > [(array[rows - 1][cols - 1]) integerValue]) {
        return NO;
    }
    
    NSInteger i = 0;
    NSInteger j = cols - 1;
    while (i<rows && j>=0) {
        if (target > [(array[i][j]) integerValue]) {
            i++;
        }
        else if (target < [(array[i][j]) integerValue]){
            j--;
        }
        else {
            return YES;
        }
    }
    return NO;
}

bool find(int target, int array[4][4] ) {
    
//    int rows = array.size;
    
    return false;
}




+ (instancetype) sharedInstance {
    dispatch_once_t once = 0;
    static id shared = nil;
    dispatch_once(&once, ^{
       shared = [[self alloc] init];
    });
    
    return shared;
    
}



//void fun1 (int i) {
//    static int value = i;
//    printf("%d ",++value);
//}
//
//void fun2(int i) {
//    int value = i;
//    printf("%d ", ++value);
//}
//
//void execute(){
//    printf("fun1:");
//    fun1(0);
//    fun1(4);
//    fun1(7);
//    printf("fun2:");
//    fun2(0);
//    fun2(4);
//    fun2(7);
//}



@end
