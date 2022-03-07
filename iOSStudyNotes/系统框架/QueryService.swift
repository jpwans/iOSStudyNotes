//
//  QueryService.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/22.
//

import Foundation

enum QueryError : String {
    case InvaldURL = "Invald URL"
    case InvaldResponse = "Invald Response"
}

// 给定API网址 返回用户数据
class QueryService {
    typealias QueryResult = (User?, String?) -> Void
    
    var user:User?
    var errorMessage: String?
    
    let defaultSession = URLSession (configuration: .default)
    var dataTask:URLSessionDataTask?
    
    func queryUsers(url:String, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        guard let url = URL(string: url) else {
            DispatchQueue.main.async {
                completion(self.user, QueryError.InvaldURL.rawValue)
            }
            return
        }
        
        
        dataTask = defaultSession.dataTask(with: url, completionHandler: {[weak self]data, response
            , error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                self?.errorMessage = error.localizedDescription
            }
            else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200
            {
                self?.user = self?.convertDataToUser(data)
            }
            else {
                self?.errorMessage = QueryError.InvaldResponse.rawValue
            }
            
            DispatchQueue.main.async {
                completion(self?.user,self?.errorMessage)
            }
        })
        
        dataTask?.resume()

    }
    
    
    func convertDataToUser(_ data:Data) -> User {
        return User.init()
    }
}
