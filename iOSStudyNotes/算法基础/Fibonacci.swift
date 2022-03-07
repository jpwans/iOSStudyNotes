//
//  Fibonacci.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/21.
//

import Foundation

// F(n) = F(n-1)+F(n-2), n>=2  动态转移方程

func Fib() -> Int {
    var (prev, curr) = (0, 1)
    
    for _ in 1 ..< 100 {
        (curr, prev) = (curr + prev, curr)
    }
    
    return curr
}

//func Fib(_ n: Int) -> Int {
//    // 定义初始状态
//    guard n > 0 else {
//        return 0
//    }
//
//    if n == 1 || n == 2 {
//        return 1
//    }
//    return Fib(n-1) + Fib(n-2)
//}
let number = 92
var nums = Array(repeating: 0, count: number)


func Fib(_ n: Int) -> Int {
    // 定义初始状态
    guard n > 0 else {
        return 0
    }
    
    if n == 1 || n == 2 {
        return 1
    }
    
    
    //如果已经计算过，则直接调用无需重复计算
    
    if nums[n-1] != 0 {
        return nums[n-1]
    }
    
    // 将计算的值传入数组
    nums[n-1] = Fib(n - 1) + Fib(n - 2)
    return nums [n-1]
}


func testFIB() {
    
    let result = Fib(number)
    
    print(result)
    
   let distance = wordDistance("abc", "xyz")
    print(distance)
}



// 栈溢出 数据溢出 递归写成循环
// hackthon 扫描英文单词后翻译成中文的app
//（1） 缩小误差范围
//（2） 计算出最接近的单词
// 初始状态 dp[0][j] = j, dp[i][0] = i
// 状态转移方程 dp[i][j] = min(dp[i - 1][j-1],dp[i-1][j],dp[i][j-1]) + 1
// 有了初始状态和状态转移方程，那么动态规划的代码就知道了

func wordDistance(_ wordA: String, _ wordB : String) -> Int {
    let  aChars = [Character](wordA)
    let bChars = [Character](wordB)
    let aLen = aChars.count
    let bLen = bChars.count
    
    var dp = Array(repeating: Array(repeating: 0, count: bLen + 1), count: aLen + 1)
    
    for i in 0 ... aLen {
        for j in 0 ... bLen {
            // 初始情况
            if i == 0 {
                dp[i][j] = j
            }
            else if j == 0
            {
                dp[i][j] = i
            }
            else if aChars[i-1] == bChars[j - 1]{
                dp[i][j] = dp[i - 1][j-1]
            }
            else {
                dp[i][j] = min(dp[i-1][j-1], dp[i-1][j], dp[i][j-1]) + 1
            }
        }
    }
    return dp[aLen][bLen]
}


