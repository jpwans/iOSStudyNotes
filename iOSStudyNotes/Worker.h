//
//  Student.h
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/14.
//

#import <Foundation/Foundation.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Worker : NSObject
@property (nonatomic, strong) NSString *infomation;
@property (nonatomic, strong) Person *person;
@end

NS_ASSUME_NONNULL_END
