//
//  AlgorithmProblem.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/25.
//

import Foundation



// 实现一个方法 计算100的阶乘


func testAlgorithmProblem(){
    print("---------算法题 BEGIN---------------")
    let result =  dofactorial(first: 0, last: 10)
    print(result)
    print("---------算法题 END---------------")
}

func dofactorial(first:Int, last:Int) -> Int {
    
    var first = first
    let last = last
    
    guard first < last else {
        return 0
    }
    
    if(first == 0){
          if(last == 0){
              //0的阶乘是1
              return 1;
          }else{
              first = 1;
          }
          
      }
    
    var result = 1;

    
    for i in first...last {
        result *= i
        
        if result > INT_MAX {
            // 考虑栈溢出
            return -1
        }
    }
    
    return result
}



//char *memcpy_qi(char *dst, const )
