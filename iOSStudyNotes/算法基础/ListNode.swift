//
//  ListNode.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/18.
//

import Foundation



// 链表

class ListNode {
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class List {
    var head : ListNode?
    var tail : ListNode?
    
    //尾插法
    func appendToTail(_ val:Int) {
        if tail == nil {
            tail = ListNode(val)
            head = tail
        }
        else {
            tail!.next = ListNode(val);
            tail = tail!.next
        }
    }
    
    //头插法
    func appendToHead(_ val:Int)  {
        if head == nil {
            head = ListNode(val)
            tail = head
        }
        else {
            let temp = ListNode(val)
            temp.next = head
            head = temp
        }
    }
    

}


func testListNode() {
//    print()
//let result =  partition([1,5,3,2,4,2], 3)
//    let leftResult = getLeftList([1,5,3,2,4,2], 3)
//    ListNode(0)
    let list:List = List.init()
    list.appendToTail(1)
    list.appendToTail(5)
    list.appendToTail(3)
    list.appendToTail(2)
    list.appendToTail(4)
    list.appendToTail(2)
    
    // 上面这个会直接改变list里面的值
//    let leftResult:ListNode = getLeftList(list.head, 3)!
//    print(leftResult);
    
    let allResult:ListNode = partition(list.head, 3)!
    print(allResult);
    
    
}

//    给出一个链表和一个值x，要求将链表中所有小于x的值放到左边，所有大于或等于x的
//    值放到右边，并且原链表的节点顺序不能变 注意，在
//    例如:1→5→3→2→4→2，给定 x=3，则要返回 1→2→2→5→3→4。 里引入它
//    一个节点
//    直觉告诉我们，对于这道题目，要先处理左边(比x小的节点)，然后再处理右边(比x 点的引入
//    大的节点)，最后再把左右两边连起来。
//    点。

// 处理比x小的放在左边 比x 大的放在右边
func partition(_ head:ListNode?, _ x:Int) -> ListNode? {
    //引入Dummy 节点
    let prevSDummy = ListNode(0),postDummy = ListNode(0)
    var prev = prevSDummy, post = postDummy
    
    var node = head
    
    //用尾插法处理左边和右边
    while node != nil {
        if node!.val < x {
            prev.next = node
            prev = node!
        }
        else {
            post.next = node
            post = node!
        }
        node = node!.next
    }
    
    // 防止构成环
    post.next = nil
    // 左右拼接
    prev.next = postDummy.next
    
    return prevSDummy.next
}

// 处理比x小的放在左边
func getLeftList(_ head: ListNode?,_ x:Int) -> ListNode? {
    let dummy = ListNode(0)
    var pre = dummy, node = head
    
    while node != nil {
        if node!.val < x {
            pre.next = node
            pre = node!
        }
        node = node!.next
    }
    
    // 防止构成环
    pre.next = nil
    return dummy.next
}



// 快行指针
// 检测环
// 用两个指针同时访问链表，其中一个的速度是另外一个的两倍，如果它们变成相等的了，那么这个链表就有环了，这就是快行指针的实际使用，代码如下：

func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head
    
    while fast != nil && fast!.next != nil {
        slow = slow!.next
        fast = fast!.next!.next
        
        if slow === fast {
            return true
        }
    }
    return false
}

// 删除链表中 倒数第n个节点。例:1 2 3 4 5 n=2 返回 1 2 3 5
//注意，给定N的长度小于等于链表的长度

func removeNthFromEnd(head: ListNode?, _ n:Int) -> ListNode? {
    guard let head = head else{
        return nil
    }
    
    let dummy = ListNode(0)
    dummy.next = head  // 处理头为空的边界问题
    var prev:ListNode? = dummy
    var post:ListNode? = dummy
    
    for _ in 0 ..< n {
        if post == nil {
            break
        }
        post = post!.next
    }
    
    
    //同时
    while post != nil && post!.next != nil {
        prev = prev!.next
        post = post!.next
    }
    
    // 删除节点
    prev!.next = prev!.next!.next
    return dummy.next
}

func testRemoveNthFromEnd()
{
    let list:List = List.init()
    list.appendToTail(1)
    list.appendToTail(2)
    list.appendToTail(3)
    list.appendToTail(4)
    list.appendToTail(5)
    let n = 2
    
    let result:ListNode = removeNthFromEnd(head: list.head, n)!
    print(result)
    
}
