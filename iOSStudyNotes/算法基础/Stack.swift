//
//  Stack.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/17.
//

import Foundation


//class Stack: NSObject {
//    var stack : [AnyObject]
//    var isEmpty : Bool {return stack.isEmpty}
//    var peek : AnyObject? {return stack.last}
//
//   override init() {
//        stack = [AnyObject]()
//    }
//
//    func push(object:AnyObject) -> Void {
//        stack.append(object)
//    }
//
//    func pop() -> AnyObject? {
//        if !isEmpty {
//            return stack.removeLast()
//        }
//        else {
//            return nil
//        }
//    }
//}


// 后进先出
// push pop isEmpty peek size
protocol Stack {
    //持有元素的类型
    associatedtype Element
    
    //是否为空
    var isEmpty: Bool {get}
    // 栈的大小
    var size:Int {get}
    //栈顶元素
    var peek:Element? {get}
    
    // 进栈
    mutating func push(_ newElement:Element)
    // 出栈
    mutating func pop() -> Element?
}

struct IntegerStack: Stack {
    
    typealias Element = Int
    private var stack = [Element]()
    
    var isEmpty: Bool {return stack.isEmpty}
    
    var size: Int {return stack.count}
    
    var peek: Element? {return stack.last}
    
    mutating func push(_ newElement: Element) {
        stack.append(newElement)
    }
    
    mutating func pop() -> Element? {
        return stack.popLast()
    }
}


// 先进先出
// enqueuq dequeue isEmpty peek size
protocol Queue {
    // 持有元素类型
    associatedtype Element
    
    //是否为空
    var isEmpty: Bool {get}
    //队列的大小
    var size: Int {get}
    // 队首元素
    var peek:Element? {get}
    
    // 入列
    mutating func enqueue(_ newElement:Element)
    // 出列
    mutating func dequeue()->Element?
}


struct IntegerQueue:Queue {
    typealias Element = Int
    
    var isEmpty: Bool {return left.isEmpty && right.isEmpty}
    
    var size: Int {return left.count + right.count}
    
    var peek: Element? {return left.isEmpty ? right.first : left.last}
    
    mutating func enqueue(_ newElement: Int) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
    
    private var left = [Element]()
    private var right = [Element]()
}


//栈和队列的互相转换

// 用栈实现队列
struct MyQueue {
    
     var stackA : IntegerStack
     var stackB : IntegerStack
    
    var isEmpty:Bool {
        return stackA.isEmpty && stackB.isEmpty;
    }
    
    var peek:Any? {
        mutating get {
            shift()
            return stackB.peek;
        }
    }
    
    init() {
        stackA = IntegerStack()
        stackB = IntegerStack()
    }
    
    mutating func enqueue(object:Int) {
        stackA.push(object)
    }
    
    mutating func dequeue() -> Any? {
        shift()
        return stackB.pop()
    }
    
    fileprivate mutating func shift (){
        if stackB.isEmpty {
            while !stackA.isEmpty {
                stackB.push(stackA.pop()!)
            }
        }
    }
}

struct MyStack {
    var queueA : IntegerQueue
    var queueB : IntegerQueue
    
    init() {
        queueA = IntegerQueue()
        queueB = IntegerQueue()
    }
    
    var isEmpty: Bool {
        return queueA.isEmpty && queueB.isEmpty;
    }
    
    var peek : Any? {
        mutating get {
            shift()
            let peekObj = queueA.peek
            queueB.enqueue(queueA.dequeue()!)
            swap()
            return peekObj
        }
    }
    
    var size : Int {
        return queueA.size
    }
    
    mutating func push(object : Int)  {
        queueA.enqueue(object)
    }
    
    mutating func pop() -> Any? {
        shift()
        let popObject = queueA.dequeue()
        swap()
        return popObject
    }
    
    private mutating func shift (){
        while queueA.size != 1 {
            queueB.enqueue(queueA.dequeue()!)
        }
    }
    
    
    private mutating func swap() {
        (queueA, queueB) = (queueB, queueA)
    }
}



// 栈和队列面试实战题
// 给出一个文件的绝对路径，要求将其简化。举一个例子，路径是“/HOME/”，简化后为“/home”;路径是“/a/.b/../../c/”,简化后为“/c”。

func simplifyPath(path:String) -> String {
    // 用数组来实现栈的功能
    var pathStack = [String]()
    // 拆分原路径
    let paths = path.components(separatedBy: "/")
    
    
    for path in paths {
        //对于“.” 我们直接跳过
        guard path != "." else {
            continue
        }
        //对于“..” 使用pop 操作
        if path == ".." {
            if (pathStack.count > 0) {
                pathStack.removeLast()
            }
        }
        else if path != "" {
            pathStack.append(path)
        }
    }
    
//    let total = pathStack.count
    // 将栈中的内容转化为优化的新路径
    let res = pathStack.reduce(""){total, dir in "\(total)/\(dir)"}
    
    
    return res.isEmpty ? "/" : res
}

// 二叉树
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_val:Int) {
        self.val = _val
    }
    
    //计算树的最大深度
    func maxDepth(root: TreeNode?) -> Int
    {
        guard let root = root else {
            return 0
        }
        return max(maxDepth(root: left), maxDepth(root: root.right)) + 1
    }
    
    // 判断一棵二叉树是否为二叉查找数
    func isValidBST(root: TreeNode?) -> Bool {
        return _helper(node: root, nil, nil)
    }
    
    private func _helper(node: TreeNode?, _ min:Int?, _ max:Int?) -> Bool {
        guard let node = node else {
            return true
        }
        
        // 所有右子树节点的值都必须大于根节点的值
        if let min = min, node.val <= min {
            return false
        }
        
        // 所有的左子树节点的值都必须小于根节点的值
        if let max = max , node.val >= max {
            return false
        }
        return _helper(node: node.left, min, node.val)
        && _helper(node: node.right, node.val, max)
    }
    
    // 二叉树的遍历
    // 用栈实现前序排列 返回的是一个数组？
    func preorderTraversal(root: TreeNode?) -> [Int] {
        var res = [Int]()
        var stack = [TreeNode]()
        var node = root
        
        while !stack.isEmpty || node != nil {
            if node != nil {
                res.append(node!.val)
                stack.append(node!)
                node = node!.left
            }
            else {
                node = stack.removeLast().right!
            }
        }
        return res
    }
    
    
    // 二叉树面试题 设计一个展示二叉树的app  用tableview  cell可以复用
    //层级遍历
    func levelOrder(root: TreeNode?) -> [[Int]] {
        var res = [[Int]]()
        var queue = [TreeNode]()
        if let root = root {
            queue.append(root)
        }
        
        while queue.count > 0 {
            let size = queue.count
            var level = [Int]()
            
            for _ in 0 ..< size {
                let node = queue.removeFirst()
                level.append(node.val)
                
                if let left = node.left {
                    queue.append(left)
                }
                    
                if let right = node.right {
                    queue.append(right)
                }
            }
            res.append(level)
        }
        return res
    }
}



