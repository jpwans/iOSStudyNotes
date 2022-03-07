//
//  LanguageTools.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/21.
//

import Foundation

import Alamofire
import SwiftyJSON


class Temperature{
    var value = 37.0
}

class Person {
    var temp: Temperature?
    
    func sick() {
        temp?.value = 41.0
    }
}

func testLT() {
    let A = Person()
    let B = Person()
    let temp =  Temperature()
    
    A.temp = temp
    B.temp = temp
    
    A.sick()
    
    
    // 引用类型在堆上 值类型在栈上
    // 栈上面 运行效率更高
    let result = add(4)
    print(result)
    
    let res = evenSquareNums(from: 0, to: 100)
    
    print(res)
    
    // 函数式编程
    let aa = (0...10).map{$0 * $0}.filter{$0 % 2 == 0}
    print(aa)
    
    
    let chefOne : Chef = SeafoodChef()
    let chefTwo : SeafoodChef = SeafoodChef()
    chefOne.makeFood()
    chefTwo.makeFood()
    
    testRequest()
    
}


protocol Pet {
    var name : String { get set }
}

struct MyDog:Pet {
    var name : String
    
    // mutating 修改结构体中自己的成员变量需要修饰
    mutating func change(name:String){
        self.name = name
    }
}


// autoclosure 可以将表达式右边的值的计算推迟到左边判定为false时，这样避免第一种方法带来的不必要的计算开销了。
//func || (left:Bool, right:@autoclosure() -> Bool) -> Bool {
//    if left {
//        return true
//    }
//    else {
//        return right()
//    }
//}

// 柯里化

//

/// 输入任意一个整数 输出的是这个整数加一个数
func add(_ num:Int) -> (Int) -> Int {
    return {val in
        return num + val
    }
}

//add(2)

// 实现一个函数：求1~100（包括0和100）中为偶数并且恰好是其它数字的平方


func evenSquareNums(from: Int, to: Int) -> [Int] {
    var res = [Int]()
    
    for num in from...to where num % 2 == 0 {
        if (from...to).contains(num * num) {
            res.append( num * num)
        }
    }
    return res
}




@objc protocol SomeProtocol {
    func requiredFunc()
    @objc optional func optionalFunc()
}




//extension SomeProtocol {
//    func optionalFunc() {
//
//    }
//}


class SomeClass: SomeProtocol {
    func requiredFunc() {
        
    }
}


@objc
protocol SomeProtocolDelegate
//:class
{
    func doSomething()
}

class ReSomeClass  {
    weak var delegate: SomeProtocolDelegate?
}


protocol Chef {
//    func makeFood()
}

extension Chef {
    func makeFood() {
        print("Make Food")
    }
}




struct SeafoodChef:Chef {
    func makeFood() {
        print("Cook Seafood")
    }
}



class User {
    var firstName: String = ""
    var lastName: String = ""
    
}
private var middleNameKey : Void?

extension User {
    var middleName : String? {
        get {
            return objc_getAssociatedObject(self, &middleNameKey) as? String
        }
        
        set {
            objc_setAssociatedObject(self, &middleNameKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
}


//DYLD_PRINT_STATISTICS

func testRequest() {

    AF.request("https://httpbin.org/get").response {
        response in
        debugPrint(JSON(response.data))
        debugPrint((response.result))
    }
}
