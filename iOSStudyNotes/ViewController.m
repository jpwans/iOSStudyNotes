//
//  ViewController.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/11.
//

#import "ViewController.h"

#import "Person.h"
#import <objc/message.h>
#import "Person+Cate.h"
#import "NSString+Category.h"
#import "Test.h"
#import "KVOKVCTest.h"
#import "Worker.h"
@interface ViewController ()
@property (nonatomic, strong) Worker *worker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    Class cls = [Person class];
////    void *
//    
//    // block 对象 匿名函数 代码块
//    UIView * v = [UIView new];
//    [NSNumber new];
//    uint a = 10;
    
//    NSString *testObject  = [NSData data];
//    [testObject stringByAppendingString:@"111"];
//    testObject base
    
//    objc_msgSend(self, @selector(click));
//    objc_msgSend(self, @selector(click));
    
    ((void(*)(id, SEL))objc_msgSend)(self, @selector(click));
    
    Class cls = self.class;
    const char *className = class_getName(cls);
    NSLog(@"%s",className);
    
    
    
    //  如何打印一个类中的所有实例变量
    Person *aPerson = [Person new];
    aPerson.age = 20;
    aPerson.name = @"jack";
    
    unsigned int count = 0;
    NSMutableDictionary *dict = NSMutableDictionary.dictionary;
    Ivar *list = class_copyIvarList([aPerson class], &count);
    for (int i = 0; i < count; i++) {
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(list[i])];
        id ivarValue = [aPerson valueForKey:ivarName];
        [dict setValue:ivarValue?ivarValue:@"" forKey:ivarName];
    }
//    free(list);
    
//
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"ivarName:%@,ivarValue:%@",key,obj);
    }];
    
    // 遍历方法列表 利用运行时访问私有的方法列表
    unsigned int mCount = 0;
    Method *mlist = class_copyMethodList([aPerson class], &mCount);

    for (int i = 0; i < mCount; i++) {
//        const char *methodName = sel_getName(method_getName(*(mlist + i)));
//        NSLog(@"%@ -> %s", NSStringFromClass([aPerson class]), methodName);
//        SEL sel = NSSelectorFromString([NSString stringWithUTF8String:methodName]);
        SEL sel = method_getName(mlist[i]);
        NSLog(@"%@",NSStringFromSelector(sel));
//        [aPerson performSelector:sel];
        
//        if (!_rebindings_head->next) {
//            _dyld_register_func_for_add_image(_rebind_symbols_for_image);
//        } else {
//            uint32_t c = _dyld_image_count();
//            // 遍历所有 image
//            for (uint32_t i = 0; i < c; i++) {
//                // 读取 image header 和 slider
//                _rebind_symbols_for_image(_dyld_get_image_header(i), _dyld_get_image_vmaddr_slide(i));
//            }
//        }
    }


    // 利用KVC 和 RUNTIME 暴力访问私有属性和变量
    Ivar varname = list[0];
    Ivar varage = list[1];
    object_setIvar(aPerson, varname, @"rose");
    object_setIvar(aPerson, varage, @"28");
    NSString *name =object_getIvar(aPerson, varname);
    NSString *age =object_getIvar(aPerson, varage);
    NSLog(@"pName:%@",name);
    NSLog(@"pAge:%@",age);
    
    // 运行时添加一个类  并添加属性
    // class_addIvar 要在objc_allocateClassPair 和 objc_registerClassPair 之间调用不然会破坏原来类成员变量的正确偏移量
    Class myClass = objc_allocateClassPair([NSObject class], "myClass", 0);
    class_addIvar(myClass, "_address", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    class_addIvar(myClass, "_age", sizeof(NSUInteger), log2(sizeof(NSUInteger)), @encode(NSUInteger));
    objc_registerClassPair(myClass);
    
    id object = myClass.new;
    [object setValue:@"china" forKey:@"address"];
    [object setValue:@20 forKey:@"age"];
    NSLog(@"address = %@, age = %@",[object valueForKey:@"address"], [object valueForKey:@"age"]);
    object = nil;
    objc_disposeClassPair(myClass);
    
    
    // 在分类中增加属性（关联对象） 运行时
    
    Person *cate = [Person new];
    cate.address = @"china";
    NSLog(@"cate address = %@",cate.address);
    
//    objc_msgSend() 根据消息的接受者所属类方法缓存列表和方法列表找该方法，找不到就找父类的相应方法，还是找不到那就执行消息转发机制
//    SEL
//    selector 选择器是运行时的方法名字
//    什么是IMP  IMP是函数指针 指向方法实现的首地址
//    IMP
//    [cate eat];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

    [cate performSelector:@selector(eat)];
    
#pragma clang diagnostic pop
    // 先找动态方法解析 resolveInstanceMethod
    // 备用接受者
    
//    isKindOfClass 子类父类都比较都为真
    // isMemberOfClass只能是当前类
    NSLog(@"Person  Person isKindOfClass:%d",[cate isKindOfClass:Person.class]);
    NSLog(@"Person  NSObject isKindOfClass:%d",[cate isKindOfClass:NSObject.class]);
    
    NSLog(@"Person  Person isMemberOfClass:%d",[cate isMemberOfClass:Person.class]);
    NSLog(@"Person  NSObject isMemberOfClass:%d",[cate isMemberOfClass:NSObject.class]);
    
//    class_geti
    // 要初始化
    NSString *string = [NSString string];
    string.newString = @"aaa";
    NSLog(@"string.newString:%@",string.newString);
    
    
    
    ///测试类方法调用  交换了
    [Test classMethod1];
    [Test classMethod2];
    ///测试实例方法调用 交换了
    Test *ts = [Test new];
    [ts instanceMethod1];
    [ts instanceMethod2];
    
    
    

    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    // 运行时添加的实例方法测试
    if ([ts respondsToSelector:@selector(newInsMethod)] ){
        [ts performSelector:@selector(newInsMethod)];
    }
#pragma clang diagnostic pop
    
    // 已经交换了description 方法
    NSLog(@"%@",aPerson);
    
    
//    oc 对象的ISA指针 指向什么？有什么作用？
    // oc中有3个层次的对象：实例对象 类对象 元类
    // 实例对象的ISA指向类对象 类对象Class里面有实例方法列表 类对象的ISA 指向元类 元类有类方法列表
    
//    UITableView 中CELL的复用是由两个数组组成 一个可显示的数组  一个可复用的数组
    //  、高度不固定的时候 尽量将CELL的高度计算好并储存起来
    
    
    // view 间 传值 1，属性2，方法参数 或者代理 3，userdefault 4，通知 5block 6全局变量
    UIDevice *device  =  [UIDevice currentDevice];
    NSLog(@"%@",device.description);
    
    NSDictionary *info_dic = [NSBundle mainBundle].infoDictionary;
    NSLog(@"info_dic:%@",info_dic);
    
    NSDictionary *localized_info_dic = [NSBundle mainBundle].localizedInfoDictionary;
    NSLog(@"localized_info_dic:%@",localized_info_dic);
    
    
    //APNS
    // APP客户端 将UDID和 BID 发送给APNS 服务器
    // APNS服务器返回加密后的devicetoken 给客户端
    // 客户端将devicetoken 发送到自己的应用服务器
    // 自己的应用服务器保存发送过来的devicetoken 在需要用的时候发送消息给APNS
    // APNS验证devicetoken 并将消息推送到APP客户端
    
#define TSNotificationName @"TSNotificationName"
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(click) name:TSNotificationName object:nil];
    
//    dis
    [[NSNotificationCenter defaultCenter] postNotificationName:TSNotificationName object:nil];
    
    NSNotification *notification = [NSNotification notificationWithName:TSNotificationName object:nil];
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostASAP];
    
    
    
    // KVO KVC
//    [[KVOKVCTest new] test];
    
    // 利用KVC实现高阶消息传递  对数组或者容器中每一个元素进行某种方法操作
    NSLog(@"利用KVC实现高阶消息传递  对数组或者容器中每一个元素进行某种方法操作");
    NSArray *test = @[@"jack",@"sam",@"tom"];
    NSArray * result = [test valueForKey:@"capitalizedString"];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"idx = %lu obj = %@",(unsigned long)idx, obj);
    }];
    
    
    // KVO 观察依赖键
    self.worker = [Worker new];
    self.worker.person = [Person new];
    [self.worker addObserver:self forKeyPath:@"infomation" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
    
    
    // KVO底层原理 系统会在运行时创建一个基于该类的派生类 监听set方法 automaticallyNotifiesObserversForKey
//    [@"ss" setValue:nil forKey:@""];
    //setValue:forKey
    // 1,访问器 2，_key成员变量 3，key属性 4，抛出异常
    
    // delegate 一种回调机制 一对一的关系 委托和代理相关是强关联
    // 通知是观察者模式，一对多的关系 弱关联
    //block 匿名函数 代码块 block 是delegate 另外一种形式 轻便灵活 不需要定义
    // kvo 是用cocoa框架实现的观察者模式
    
}



- (void)click {
  NSLog(@"%s",__func__);
}

//- (void)doesNotRecognizeSelector:(SEL)aSelector {
//
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.worker.person.name = @"rose";
    self.worker.person.age = 20;
}

-(void)dealloc {
    [self.worker removeObserver:self forKeyPath:@"infomation"];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"infomation"]) {
        NSLog(@"%@",change);
    }
}
 

@end
