//
//  Student.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/14.
//

#import "Worker.h"

@implementation Worker


- (NSString *)infomation {
    return [NSString stringWithFormat:@"Worker_name:%@, Worker_age:%ld",self.person.name,(long)self.person.age];
}

- (void)setInfomation:(NSString *)infomation {
    NSArray * array = [infomation componentsSeparatedByString:@"#"];
    [self.person setName:[array objectAtIndex:0]];
    [self.person setAge:[[array objectAtIndex:1] integerValue]];
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingInfomation {
    return [NSSet setWithObjects:@"person.name",@"person.age", nil];
}

@end
