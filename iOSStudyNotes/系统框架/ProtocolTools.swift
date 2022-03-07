//
//  ProtocolTools.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/23.
//

import Foundation
import Alamofire
//POP和OOP

protocol Request {
    func send(info: Info)
}

protocol Info{}

class UserRequest:Request {
    func send(info: Info){}
}

class UserInfo: Info {
    
}

class MockUserRequest: Request {
    func send(info: Info) {
        
    }
}


func testUserRequest() {
    let userRequest = MockUserRequest()
    userRequest.send(info: UserInfo())
}

// 消除动态分发的风险  protocol 必须要实现    不然在编译阶段就会报错

protocol Flyable { }

protocol Bird {
    var name: String { get }
    var canFly: Bool { get }
    
}

extension Bird {
    var canFly : Bool { return self is Flyable}
    
}

struct ButterFly : Flyable{
    
}

struct Penguin: Bird {
    var name = "Penguin"
}
struct Eagle:Bird,Flyable {
    var name = "Eagle"
}

enum FlyablePokemon : Flyable {
    case Pidgey
    case Duduo
}


protocol Food {}

struct Fish:Food {}
struct Bone:Food {}

protocol Animal {
    associatedtype FoodType = Food
    
    func eat(food: FoodType)
    func greet(other: Self)
}

struct Cat: Animal {
    func eat(food: Fish) {
//        guard let _ = food as? Fish else {
            print("猫只吃鱼")
//            return
//        }
    }
    
    func greet(other: Cat) {
//        if let _ = other as? Cat {
            print("喵")
//        }
//        else {
//            print("猫很骄傲，不会对其他动物打招呼")
//        }
    }
}


struct Dog: Animal {
    func eat(food: Bone) {
//        guard let _ = food as? Bone else {
            print("狗只啃骨头")
//            return
//        }
    }
    
    func greet(other: Dog) {
//        if let _ = other as? Dog {
            print("汪汪")
//        }
//        else {
//            print("狗很骄傲，不会对其他动物打招呼")
//        }
    }
}


extension Array where Element: Comparable {
    
    public var isSorted: Bool {
        
        var previousIndex = startIndex
        var currentIndex = startIndex + 1
        
        while currentIndex != endIndex {
            
            if self[previousIndex] > self[currentIndex] {
                return false
            }
            
            previousIndex = currentIndex
            currentIndex = currentIndex + 1
        }
        return true
    }
    
    func binarySearch<T: Comparable>(sortedElements:[T], for element: T) -> Bool {
        // 确保输入的数组是按序排列的
        assert(sortedElements.isSorted)
        
        var lo = 0 ,hi = sortedElements.count - 1
        
        while lo <= hi {
            let mid = lo + (hi - lo)/2
            
            if sortedElements[mid] == element {
                return true
            }
            else if sortedElements[mid] < element {
                lo = mid + 1
            }
            else {
                hi = mid - 1
            }
        }
        
        return false
    }
}


// 单元测试

var dataLoaded: Data?

func test_loadContent_shouldReturnData() {
    let url = "https://app-info.rtf"
//    let session = MockUserRequest.send(Session)
}
