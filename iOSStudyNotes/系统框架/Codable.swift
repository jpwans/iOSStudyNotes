//
//  Codable.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/23.
//

import Foundation


enum Gender: String, Codable {
    case Male = "Male"
    case Felmale = "Female"
}


class Customer: Codable {
    let name : String
    let age:Int
    let gender:Gender
    
    init(name: String, age:Int, gender:Gender) {
        (self.name, self.age, self.gender) = (name, age, gender)
    }
}


func testCodable() {
    let customerJsonString = """
    {
        "name":"Cook",
        "age":58,
        "gender":"Male"
    }
    """
    
    //从JSON解码到实例
    if let customerJSONData = customerJsonString.data(using: .utf8)
    {
        let customerDecode = try? JSONDecoder().decode(Customer.self, from: customerJSONData)
        print(customerDecode as Any)
    }
    
    // 从实例编码到JSON
    let customerEncode = Customer(name:"Cook",age:58,gender:Gender.Male)
    let customerEncodedData = try? JSONEncoder().encode(customerEncode)
    
    print(customerEncodedData as Any)
    
    
}
