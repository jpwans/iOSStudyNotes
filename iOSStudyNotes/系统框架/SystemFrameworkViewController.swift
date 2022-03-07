//
//  SystemFrameworkViewController.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/22.
//

import UIKit

class SystemFrameworkViewController: UIViewController, UIDropInteractionDelegate, UIDragInteractionDelegate {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dragImgeView: UIImageView!
    
    @IBOutlet weak var dropImgeView: UIImageView!
    
    var progress:CGFloat = 0
    var animator:UIViewPropertyAnimator!
    
    
    
    //    @available(iOS 11.0, *)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        UIViewPropertyAnimator(duration: 2, curve: .linear) {
        //            self.imageView.frame = self.imageView.frame.offsetBy(dx: 200, dy: 0)
        //        }.startAnimation()
        
        //        UIView.animate(withDuration: 2) {
        //            self.imageView.frame = self.imageView.frame.offsetBy(dx: 100, dy: 10)
        //        }
        //
        
        //        let animation = CABasicAnimation.init(keyPath: "position.x")
        //        animation.fromValue = self.imageView.center.x
        //        animation.toValue = self.imageView.center.x + 200
        //        animation.duration = 2
        ////        animation.isRemovedOnCompletion = true
        ////        animation.autoreverses = tr
        //        self.imageView.layer.add(animation, forKey: nil)
        //
        
//        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { b, error in
//            print(error)
//        }
//        UserNotifications
        
        
//        testCodable()
//        raceCondition()
//        priorityInverstion()
        operationTest()
        
        
        
            let user = KVOUser(email: "user@hotmail.com")
            
            let observation = user.observe(\.email){
                (user, change) in
                print("user new email:\(user.email)")
            }
        user.email = "user@outlook.com"
        
//        user.observe(\.email) { KVOUser, NSKeyValueObservedChange<Value> in
//
//        }
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
        view.addGestureRecognizer(gesture)

        animator = UIViewPropertyAnimator.init(duration: 2, curve: .easeOut, animations: {
            self.imageView.frame = self.imageView.frame.offsetBy(dx: 200, dy: 0)
        })
//
//        self.registerForPreviewing(with: <#T##UIViewControllerPreviewingDelegate#>, sourceView: <#T##UIView#>)
        
        self.dragImgeView.isUserInteractionEnabled = true
        self.dropImgeView.isUserInteractionEnabled = true
        
        if #available(iOS 11.0, *) {
            self.dragImgeView.addInteraction(UIDragInteraction(delegate: self))
            self.dropImgeView.addInteraction(UIDropInteraction(delegate: self))
        }
        
        
    }
    
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animator.pauseAnimation()
            progress = animator.fractionComplete
        case .changed:
            let translation = recognizer.translation(in: self.imageView)
            animator.fractionComplete = translation.x/200 + progress
        case .ended:
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }
    
    
    @available(iOS 11.0, *)
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        if interaction.view == dragImgeView {
            let dragImge = dragImgeView.image
            let itemProvider = NSItemProvider(object: dragImge!)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            return[dragItem]
        }
        return []
    }
    
    
    @available(iOS 11.0, *)
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: view)
        let operation: UIDropOperation
        
        if dropImgeView.frame.contains(dropLocation) {
            operation = .copy
        }
        else {
            operation = .cancel
        }
        
        return UIDropProposal(operation: operation)
    }
    
    @available(iOS 11.0, *)
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self) { [weak self](imageItems) in
            self?.dragImgeView.image = nil;
            self?.dropImgeView.image = imageItems.first as? UIImage
        }
    }
    
    
    
    // 多线程
    func multithreading()  {
        let serialQueue =  DispatchQueue(label: "serialQueue")
        serialQueue.sync {
            print(1)
        }
        print(2)
        serialQueue.sync {
            print(3)
        }
        print(4)
        
        //串行异步
        serialQueue.async {
            print(1)
        }
        print(2)
        
        serialQueue.async {
            print(3)
        }
        print(4)
        
        //串行异步嵌套同步
        
        print(1)
        serialQueue.async {
            print(2)
            serialQueue.sync {
                print(3)
            }
        print(4)
        }
        print(5)
        
        //串行同步中嵌套异步
        print(1)
        serialQueue.sync {
            print(2)
            serialQueue.async {
                print(3)
            }
            print(4)
        }
        print(5)
        
    
    }
    
    // 竞态条件
    func raceCondition()  {
        var num = 0
        
        DispatchQueue.global().async {
            for _ in 1...10000 {
                num += 1
            }
        }
        
        for _ in 1...10000 {
            num += 1
        }
        
        print(num) // 小于20000每次都不一样
        
    }

    
    // priorityInverstion 优先倒置 低优先级会因为各种原因高于高优先级
    func priorityInverstion(){
        let highPriorityQueue = DispatchQueue.global(qos: .userInitiated)
        let lowPriorityQueue = DispatchQueue.global(qos: .utility)
        
        let semaphore = DispatchSemaphore(value: 1)
        
        lowPriorityQueue.async {
            semaphore.wait()
            for i in 0...10 {
                print(i)
            }
            semaphore.signal()
        }
        
        highPriorityQueue.async {
            semaphore.wait()
            for i in 11...20 {
                print(i)
                
            }
            semaphore.signal()
        }
    }
    
    func deadLock(){
        let operationA = Operation()
        let operationB = Operation()
        
        // 死锁
        operationA.addDependency(operationB)
        operationB.addDependency(operationA)
        
        
       let serialQueue = DispatchQueue(label: "serial")
        // 死锁
        serialQueue.async {
            serialQueue.async {
                
            }
        }
        

    }
    //竞态条件 测试 用同步效率会低
//    func getUser(id : String) throws -> User {
//        try serialQueue.sync{
//        return try Storage.getUser(id: id)
//        }
//    }
//
//    func setUser:(_ user:User) throws {
//        try serialQueue.sync{
//
//            try Storage.setUser(user)
//        }
//    }
    
    
    let concurrentQueue = DispatchQueue(label: "concurrent")
    
    // 并行队列配合异步操作 再加上逃逸闭包
    enum Result<T> {
        case value(T)
        case error(Error)
    }
    
//    func getUser(id: String, completion:(Result<User>) -> Void) {
//        try concurrentQueue.async {
//            do {
//               user =  try Storage.getUser(id: id)
//                completion(.value(user))
//            } catch  {
//                completion(.error(error))
//            }
//        }
//
//        return user
//    }
//
//
//    func setUser(_ user :User,completion:(Result<T>) ->Void)  {
//        try concurrentQueue.async {
//            do {
//                try Storage.setUser(user)
//                completion(.value())
//            } catch  {
//                completion(.error(error))
//            }
//        }
//
//    }
    
    //读取操作用并行队列  用SYNC返回结果  写操作barrier flag
    
//        func getUser(id : String) throws -> User {
//            var user:User!
//            try concurrentQueue.sync{
//                user =  try Storage.getUser(id: id)
//            }
//            return user
//        }
    
    
//        func setUser(_ user :User,completion:(Result<T>) ->Void)  {
//            try concurrentQueue.async(flags:.barrier) { //并行队列只有当前写操作
//                do {
//                    try Storage.setUser(user)
//                    completion(.value())
//                } catch  {
//                    completion(.error(error))
//                }
//            }
//        }
    
    func operationTest()  {
        
//        let multiTasks = BlockOperation()
//
//        multiTasks.completionBlock = {
//            print("所有的任务完成！")
//        }
//        multiTasks.addExecutionBlock {
//            print("任务1开始")
//            sleep(1)
//        }
//        multiTasks.addExecutionBlock {
//            print("任务2开始")
//            sleep(2)
//        }
//        multiTasks.addExecutionBlock {
//            print("任务3开始")
//            sleep(3)
//        }
//        multiTasks.start()
//
//
//        let multiTaskOperation = OperationQueue()
//
//        multiTaskOperation.addOperation {
//            print("multiTaskOperation1")
//            sleep(1)
//        }
//        multiTaskOperation.addOperation {
//            print("multiTaskOperation2")
//            sleep(2)
//        }
//
//        multiTaskOperation.addOperation {
//            print("multiTaskOperation3")
//            sleep(3)
//        }
//        multiTaskOperation.waitUntilAllOperationsAreFinished()
//
//
        
        let queue = OperationQueue()
        let sumOperation = ArraySumOperation(nums: Array(1...1000))
        
        queue.addOperation(sumOperation)
        sumOperation.cancel()
//        queue.cancelAllOperations()
        sumOperation.completionBlock = {
            print(sumOperation.sum)
        }
    }
}


class imageFilterOperation: Operation {
    var intputImage : UIImage?
    var outputImage : UIImage?
    
    override func main() {
//        outputImage = filter(image: intputImage)
    }
}


class ArraySumOperation: Operation {
    let nums:[Int]
    var sum : Int
    
     init(nums: [Int]) {
        self.nums = nums
        self.sum = 0
        super.init()
    }
    
    override func main() {
        for num in nums {
            if isCancelled {
                return
            }
            sum += num
        }
    }
    
}

//KVO
@objcMembers class KVOUser : NSObject {
    
    dynamic var email: String
     init(email: String) {
         self.email = email
    }
}




