//
//  MultithreadingViewController.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/15.
//

#import "MultithreadingViewController.h"


typedef void (^block)(void);
@interface MultithreadingViewController ()
@property (nonatomic, strong) NSString *name;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) block myBlock;
@property (nonatomic, strong) dispatch_source_t timer; // 必须用强引用指针 计时器才会生效


@end

@implementation MultithreadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [NSThread mainThread];
    
//    GCD
//    NSLog(@"开始异步任务");
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//       [NSThread sleepForTimeInterval:4];
//        NSLog(@"异步任务执行完毕");
//    });
//    NSLog(@"结束异步任务");
    
//    NSLog(@"开始同步任务");
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//       [NSThread sleepForTimeInterval:4];
//        NSLog(@"同步任务执行完毕");
//    });
//    NSLog(@"结束同步任务");
   
    
    //并发队列
    dispatch_queue_t concurrent_queue = dispatch_queue_create("并发队列", DISPATCH_QUEUE_CONCURRENT);
    
    // 串行队列
    dispatch_queue_t serial_queue = dispatch_queue_create("并发队列", DISPATCH_QUEUE_SERIAL);
    
//    dispatch_get_main_queue()  // 主线程
//    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//#define DISPATCH_QUEUE_PRIORITY_HIGH 2
//#define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
//#define DISPATCH_QUEUE_PRIORITY_LOW (-2)
//#define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
    
    // 延迟
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC));
    dispatch_after(delay, dispatch_get_main_queue(),
                   ^{
        
    });
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        
    });
    dispatch_group_async(group, queue, ^{
        
    });
    dispatch_group_async(group, queue, ^{
        
    });
    dispatch_group_notify(group, queue, ^{
    
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"sss");
        }];
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    [op start];
    
    NSBlockOperation *bop = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s %d",__func__,__LINE__);
    }];
    [bop addExecutionBlock:^{
        NSLog(@"%s %d %@",__func__,__LINE__,[NSThread currentThread]);
        }];
    [bop start];
    
//{
//    // 操作依赖
//    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
//    NSOperation *c = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%s %d CCCC",__func__,__LINE__);
//    }];
//
//    NSOperation *a = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%s %d AAA",__func__,__LINE__);
//    }];
//
//    NSOperation *b = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%s %d BBB",__func__,__LINE__);
//    }];
//
//    [c addDependency:a];
//    [c addDependency:b];
//
//    [mainQueue addOperation:c];
//    [mainQueue addOperation:a];
//    [mainQueue addOperation:b];
//}
//
//    NSOperation 能取消能依赖 提供面向对象接口 复杂项目用这个
//     简单项目用GCD 官方优化了
    
    
    [self barrier];
//    [self lock];
    
//    Cocoa 多线程
//    NSThread  OC对象
//  GCD  C语言封装
// GCD 的OC封装 NSOperation
    // c语言 pthread
    
    // 串行队列 同步 当前线程FIFO执行  异步 其它线程FIFO执行
    // 并行队列 同步 当前线程FIFO执行  异步 其它线程多条线程 异步执行
    
//    [self whenGCDCreateNewThread];
//    只有异步提交才会开启新线程 异步提交并发 会开启多个新线程
    // 同步提交 串行还是并行 都只能在当前线程同步执行 不会开启新线程
    // 如果当前是主线程 不可在主线程开启同步任务 否则会造成死锁而报错。
    
    
//    GCD 死锁
    // A等待B B等待A 所以会死锁
    // 解决死锁 可以使用异步
// 或者放在串行队列中
    
    // 建耗时间的操作放在全局并发中 耗时任务完成后 再返回到主队列 执行相应的UI操作。
    
    // NSOperation 线程同步是添加依赖
//    GCD 实现线程同步
//    组队列
    // 阻塞任务
    // 信号量机制
    

//    [self synchronization];
    
    //    [self sessionGet];
//    [self controlMaximum];
    
    
    // 延时
//    [self performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>]
    // 隐式创建子线程 不会 阻塞主线程
//    [NSThread sleepForTimeInterval:10]  会阻塞主线程
//    [self createTimer];
    
//    NSTimer * timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"%@",[NSThread currentThread]);
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [timer invalidate];
// NSTimer 开启定时任务  确保添加到NSRunLoop NSRunLoop已经启动。
    // timerWithTimeInterval 需要添加到runloop
    // scheduledTimerWithTimeInterval 这个不需要自动执行
//    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"%@  %d",[NSThread currentThread], __LINE__);
//    }];
//    [self createCADisplayLink];
}
- (void)createCADisplayLink {
    // 屏幕刷新率绑定在一起 精度高
    // 跳帧次数取决于CPU的忙碌程度
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLink_SEL)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode ];
    
    [displayLink setPaused:YES];
    [displayLink setPaused:NO];
    [displayLink setPreferredFramesPerSecond:5]; // 设置每几帧调用一次 默认为1  每秒调用几次？
    
//    [displayLink invalidate];
//    displayLink = nil;
    
    // 网络请求的依赖关系
    //
//    NSOperation 依赖
//    GCD 组队列 阻塞任务 信号量机制
}

- (void)displayLink_SEL {
    NSLog(@"%s %d",__func__,__LINE__);
}
- (void)createTimer {
    static NSTimeInterval i = 0;
    // 在指定线程上定义计时器
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //开始时间
    dispatch_time_t when  = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    // 设置计时器
    dispatch_source_set_timer(_timer, when, 1.0 * NSEC_PER_SEC, 0);
    // 计时器回调
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timeLabel.text = [@(i) stringValue];
        });
       NSLog(@"%f",i);
        i++;
    });
    dispatch_resume(_timer);
    self.timer = _timer;
}

//GCD 什么时候创建新的线程
- (void)whenGCDCreateNewThread {
    NSLog(@"%s",__func__);
    dispatch_queue_t serialQueue = dispatch_queue_create("serial.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    
    // 串行队列 提交同步任务  当前线程同步操作
    dispatch_sync(serialQueue, ^{
        NSLog(@"serial_syn_a:%@",[NSThread currentThread]);
    });
    dispatch_sync(serialQueue, ^{
        NSLog(@"serial_syn_c:%@",[NSThread currentThread]);
    });
    dispatch_sync(serialQueue, ^{
        NSLog(@"serial_syn_b:%@",[NSThread currentThread]);
    });
    
    // 串行队列 提交异步任务 其它单个子线程同步操作
    dispatch_async(serialQueue, ^{
        NSLog(@"serial_asyn_a:%@",[NSThread currentThread]);
    });
    dispatch_async(serialQueue, ^{
        NSLog(@"serial_asyn_c:%@",[NSThread currentThread]);
    });
    dispatch_async(serialQueue, ^{
        NSLog(@"serial_asyn_b:%@",[NSThread currentThread]);
    });
    
    // 并行队列 提交同步任务 当前线程的同步操作
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"concurrent_syn_a:%@",[NSThread currentThread]);
    });
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"concurrent_syn_b:%@",[NSThread currentThread]);
    });
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"concurrent_syn_c:%@",[NSThread currentThread]);
    });
    
    // 并行队列 提交异步任务 其它多个子线程的异步操作
    dispatch_async(concurrentQueue, ^{
        NSLog(@"concurrent_asyn_a:%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"concurrent_asyn_b:%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        NSLog(@"concurrent_asyn_c:%@",[NSThread currentThread]);
    });
}

- (void)controlMaximum {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(5);
    for (int i = 0 ; i < 1000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"任务 ：%d 开始",i);
            [NSThread sleepForTimeInterval:10];
            NSLog(@"任务 ：%d 结束",i);
            dispatch_semaphore_signal(semaphore);
            
        });
        
    }
    [NSThread sleepForTimeInterval:1000];
}

// 线程同步
- (void)synchronization {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"耗时任务1开始");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"任务1结束");
        dispatch_semaphore_signal(semaphore);
    });
    NSLog(@"任务中间间隔结束");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"耗时任务2开始");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"任务2结束");
        dispatch_semaphore_signal(semaphore);
    });
    
    [NSThread sleepForTimeInterval:10];
    
    
}

- (void)block {
    void (^myBlockss)(void) = ^{
        
    };
    
    int (^myBlock1)(int) = ^(int a){
            return a;
    };
    
    int(^myBlock2)(void) = ^{
      return 100;
    };
    
    typedef void(^blocks)(void);
    blocks bbb = ^ {
        
    };
    
    // block 内部不能修改外部的值
    // 如果要—
    
    __block int c = 1;
    
    // 当block 作为成员变量的时候 在block 内部再调用self属性或者方法 才会引起循环引用
    // 临时变量的block 不会造成循环引用
    // 当self 被释放的 可能造成找不到的情况 控制器对象被pop了
    // 下面那种情况只有在POP的时候才行 其它情况不要乱使用
    __weak typeof(self) weakSelf = self;
    self.myBlock = ^{
      __strong typeof(self) strongSelf = weakSelf;
        NSString *name = strongSelf.name;
    };
}

- (void)sessionGet {
    
    NSURL *url = [NSURL URLWithString:@"https://img2.baidu.com/it/u=3092155743,2393474180&fm=253&fmt=auto&app=138&f=JPEG?w=334&h=500"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return;
        }
//        self.imageView.image = [UIImage imageWithData:data];
        UIImage *image = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = [UIImage imageWithData:data];
            //    self.view.layer.contents = (id)image.CGImage;
                }];
    }];
    
    [task resume];
    
}

- (void)lock {
    self.name = @"bob";
    
    __weak typeof(self) weakSelf = self;
    NSLock *alock = [[NSLock alloc] init];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        @synchronized (weakSelf.name) {
//            if ([alock tryLock]) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                NSLog(@"%d %@",__LINE__,[NSThread currentThread]);
                weakSelf.name = @"jack";
                [NSThread sleepForTimeInterval:5];
        dispatch_semaphore_signal(semaphore);
//                [alock unlock];
//            }
          
//        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        @synchronized (weakSelf.name) {
//        if ([alock tryLock]) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"%d %@",__LINE__,[NSThread currentThread]);
            weakSelf.name = @"rose";
        dispatch_semaphore_signal(semaphore);
//            [alock unlock];
//        }
//        }
    });

    // synchronized 同对象同关键字 才会互斥 相同锁的对象才会互斥
}


- (void)barrier {
    // 并发堵塞
    dispatch_queue_t concurrent_queue = dispatch_queue_create("并发队列", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrent_queue, ^{
        NSLog(@"dispatch_async aaa");
    });
    dispatch_async(concurrent_queue, ^{
        NSLog(@"dispatch_async bbb");
    });
    dispatch_barrier_async(concurrent_queue, ^{
        NSLog(@"dispatch_barrier_async 0000");
    });
    dispatch_async(concurrent_queue, ^{
        NSLog(@"dispatch_async ccc");
    });
    dispatch_async(concurrent_queue, ^{
        NSLog(@"dispatch_async ddd");
    });
    
}

- (void) run
{
    NSLog(@"%s",__func__);
}

- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait {
    
}

- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait modes:(NSArray<NSString *> *)array {
    
}

+ (instancetype)sharedInstance {
    static dispatch_once_t once = 0;
    static id sharedInstance = nil;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

@end
