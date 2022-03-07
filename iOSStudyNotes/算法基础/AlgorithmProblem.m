//
//  AlgorithmProblem.m
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/25.
//

#import "AlgorithmProblem.h"

@implementation AlgorithmProblem


long long dofactorial(int min, int max){
    if(min > max){
        return 0;
    }
    if(min == 0){
        if(max == 0){
            //0的阶乘是1
            return 1;
        }else{
            min = 1;
        }
        
    }
    long long result = 1;
    for (int i = min; i <= max; i++) {
        result *= i;
     
        if(result > INT_MAX){
            //考虑溢出
            return -1;
        }
    }
    return result;
}


//char *memcpy_qi(char *dst, const char* src, int cl)
//{
//    assert(dst != NULL && src != NULL);
//    char *ret = dst;
//    if (dst >= src && dst <= src+ cl-1) //内存重叠，从高地址开始复制
//    {
//        //挪开空间
//        dst = dst+ cl-1;
//        //将指针挪到结尾
//        src = src+ cl-1;
//        while (cl-)
//            *dst- = *src-;
//    }
//    else    //正常情况，从低地址开始复制
//    {
//        while (cl—)
//            *dst++ = *src++;
//    }
//
//    return ret;
//}

//char * strcpy_qi(char *dst,const char *src)
//{
//    assert(dst != NULL && src != NULL);
//    char *ret = dst;
//    memcpy_qi(dst, src, strlen(src)+1);
//    return ret;
//}


- (void)testAlgorithmProblem {
    long long result = dofactorial(0, 100);
    printf("result = %lld", result);
    
}


// 两个类最近的公共父类

- (NSArray *)superClasses:(Class)class {
    
    if (class == nil) {
        return @[];
    }
    NSMutableArray * result = [NSMutableArray array];
    while (class != nil) {
        [result addObject:class];
        class = [class superclass];
    }
    return  [result copy];
//    return [resu];
}

- (Class)commonClass1:(Class)classA andClass:(Class)classB {
    NSArray *arr1 = [self superClasses:classA];
    NSArray *arr2 = [self superClasses:classB];
    NSInteger count = arr1.count < arr2.count ? arr1.count : arr2.count;
    Class resultClass ;
    
    for (NSUInteger i = 0; i < count; i++) {
        Class classA = arr1[count - i - 1];
        Class classB = arr2[count -i - 1];
        if (classA == classB) {
            resultClass = classA;
        }
        else {
            break;
        }
    }
    
    return  resultClass;
}


// 用两个骰子表示一个月的完整日期
//问题是这样的：现有两个骰子，每个骰子6个面，全是空的，现在需要用这两个骰子表示年月日中的日的全部情况(1-31),1号算01，一个骰子只能表示一位，且不能两位都用同一个骰子，那么在这种情况下，每个骰子的六个面上该怎么刻数字呢？

//骰子A ： 0、1、2、3、4、5
//骰子B ： 0、1、2、6、7、8

@end
