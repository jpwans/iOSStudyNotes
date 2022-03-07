import UIKit
import Foundation

import PlaygroundSupport
//
//PlaygroundPage.current.needsIndefiniteExecution = true
//
//var greeting = "Hello, playground"
//
//let url = URL(string: "api.org/get")
//
//let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//    do {
//        let  dict = try JSONSerialization.jsonObject(with: data!, options: [])
//        print(dict)
//    }
//    catch {
//        print("error")
//    }
//}

// 实现一个10行的列表每行随机显示一个0~100的整数

//import UIKit
//import PlaygroundSupport

class ViewController:UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(Int(arc4random_uniform(100)))"
        return cell
    }
}

PlaygroundPage.current.liveView = ViewController()


