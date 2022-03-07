//
//  Test.h
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test : NSObject

- (void)instanceMethod;

+ (void)classFun;
- (void)objFunc;

- (void)instanceMethod1;
- (void)instanceMethod2;

+ (void)classMethod1;
+ (void)classMethod2;
@end

NS_ASSUME_NONNULL_END
