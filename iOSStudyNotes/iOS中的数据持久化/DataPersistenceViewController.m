//
//  DataPersistenceViewController.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/15.
//

#import "DataPersistenceViewController.h"

//#import "sqlite.h"
@interface DataPersistenceViewController ()

@end

@implementation DataPersistenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSUserDefaults
    // Property List
    // Archive
    // SQLite
    // CoreData
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self usePropertyList];
    [self useKeyedArchiver];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"NSUserDefaults:%@",userDefaults);
}

- (void)useUserDefaults {
        // 存储自定义对象 需要归档 解档 成data数据再存储
        // 自定义对象需要实现nscoding协议
    
}

- (void)usePropertyList {
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"]];
    NSLog(@"从工程PList读取:%@",data);
    
    [data setObject:@"444" forKey:@"d"];
    NSLog(@"将要写入的数据：%@",data);
                                 
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/demo.plist"];
    
    [data writeToFile:filePath atomically:YES];
    
    // 读取
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"从沙盒读取的数据:%@",dic);
    
}

- (void)useKeyedArchiver {
    NSString *homeDictory = NSHomeDirectory();
    NSString *homePath = [homeDictory stringByAppendingPathComponent:@"testAchiver"];
    
    NSArray *array = @[@"obj1",@"obj2",@"obj3"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    
    NSArray *unarchivedArray;
    if (data.length) {
        unarchivedArray = [NSKeyedUnarchiver unarchivedObjectOfClass:NSArray.class fromData:data error:nil];
    }
    NSLog(@"%@",unarchivedArray);
}

- (void)sandbox {
    // 获取沙盒主目录路径
    NSString *homeDir = NSHomeDirectory();
    
    // 获取Documents目录路径
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    // 存放文件
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        
    NSString *fileName = [path stringByAppendingPathComponent:@"myfile"];

    NSString *content = @"测试数据";

    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];

    BOOL result = [contentData writeToFile:fileName atomically:YES];

    //文件存放在Documents目录
    
    // 获取Library的目录路径
    NSString *libDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];

    // 获取Caches目录路径
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];

}

@end
