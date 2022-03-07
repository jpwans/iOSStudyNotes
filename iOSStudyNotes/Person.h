//
//  Person.h
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
- (void)saySomting;

@end

NS_ASSUME_NONNULL_END
