//
//  SortingAlgorithm.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/19.
//

import Foundation

/*****名称*******时间复杂度*********空间复杂度*********是否稳定****/
/*    冒泡        O(n²)           O(1)                是
 插入        O(n²)            O(1)               是
 选择        O(n²)            O(1)               否
 堆          O(nlogn)         O(1)              否
 归并        O(nlogn)         O(n)               是
 快速        O(nlogn)         O(logn)            否
 桶         O(n)               O(k)             是
 */

// 好的排序算法性能是O(nlogn) 坏的排序算法性能是O(n²)

func testSort (){
    
    //    int []arr = {9,8,7,6,5,4,3,2,1};
    //       sort(arr);
    //       System.out.println(Arrays.toString(arr));
    
    //    let array:[Int] = [9,8,7,6,5,4,3,2,1]
    let array:[Int] = [9,8,4,5,7,1,3,6,2]
    print(array.description);
    
    //   let result = mergeSort(array);
    let result = quicksort(array);
    print(result.description);
    
    //    array.sort() 升序  堆排序 插入 快速排序 依据输入的深度选择最佳的算法来完成
    //    array.sorted(by: >) 降序
    // 字典键值排序
    //    let map = ["ss":"bb"]
    //    let keys = Array(map.keys)
    //    let sortedKeys = keys.sorted(){
    //        return map[$0]! > map[$1]!
    //    }
    
    //    let nums:[Int] = [1,2,3,4,5,6,7,8,9]
    //    let target = 13
    //    let b =  binarySearch(nums, target)
    //    print(b)
    
    let nums:[Int] = [1,2,3,4,5,6,7,8,9]
    //    let target = 18
    let a =  binarySearch(nums, 8)
    print("第1种二分查找",a)
    let b =  binarySearch(nums: nums, target: 2)
    print("第2种二分查找",b)
    
    let v = findFirstBadVersion(n: 10)
    print(v)
    
    // 搜索旋转有序数组
    let rotatingnums = [4,5,6,7,0,1,2,3]
    let r =  search(nums: rotatingnums, target: 4)
    print(r)
    let t =  search(nums: rotatingnums, target: 8)
    print(t)
}

// 归并排序
func mergeSort(_ array: [Int]) -> [Int] {
    //    var helper = Array(count:array.count,repeatedValue:0)
    var helper = Array(repeating: 0, count: array.count), array = array
    mergeSort(&array, &helper, 0 , array.count - 1)
    return array;
}

// inout 理解为函数指针
func mergeSort(_ array: inout [Int], _ helper:inout [Int],_ low:Int,_ high:Int) {
    
    guard low < high else {
        return
    }
    
    //    let middle = (high - low)/2 + low
    let middle = (high + low)/2
    mergeSort(&array, &helper, low, middle) //
    mergeSort(&array, &helper, middle + 1, high)
    merge(&array, &helper, low, middle, high)
}

func merge(_ array:inout [Int], _ helper: inout [Int],_ low: Int ,_ middle:Int,_  high:Int) {
    
    // copy both halves into a helper a array
    for i in low ... high {
        helper[i] = array[i]
    }
    
    var helperLeft = low, helperRight = middle + 1, current = low
    
    while helperLeft <= middle && helperRight <= high {
        if helper[helperLeft] <= helper[helperRight] {
            array[current] = helper[helperLeft]
            helperLeft += 1
        }
        else {
            array [current] = helper[helperRight]
            helperRight += 1
        }
        current += 1
    }
    
    guard middle - helperLeft >= 0 else {
        return
    }
    
    for i in 0 ... middle - helperLeft{
        array[current + i] = helper[helperLeft + i]
    }
}


// 快速排序
func quicksort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else {
        return array
    }
    
    let pivot = array[array.count/2]
    let left = array.filter{$0 < pivot}
    let middle = array.filter{$0 == pivot}
    let right = array.filter{$0 > pivot}
    
    return quicksort(left) + middle + quicksort(right)
}


// 桶排序
// 微软面试题  有红球 黄球 蓝球 若干个 要求所有的红球放在黄球的前面，最后放上所有的蓝球

// 二分搜索 O（logn）

//(1)mid 被定义在 while 循环外面，如果被定义在里面，则每次循环都要重新给 mid 分
//配内存空间,从而会造成不必要的浪费;而被定义在循环之外,则每次循环只是重新赋值 解决算
//可以写
//(2)每次重新给 mid 赋值不能写成mid=(right+left)/2。这种写法表面上看没有问题
//但当数组非常长、算法又已经搜索到了最右边部分时，right+left 就会非常大，造成溢出
//导致程序崩溃。所以，解决问题的办法是写成mid=(right-left)/2+ left。


// 假设nums是一个升序数组
func binarySearch(_ nums:[Int], _ target: Int) -> Bool{
    var left = 0, mid = 0, right = nums.count - 1
    
    while left <= right {
        mid = (right - left)/2 + left
        if nums[mid] == target {
            return true
        }
        else if nums[mid] < target {
            left = mid + 1
        }
        else {
            right = mid + 1
        }
    }
    return false
}




func binarySearch(nums:[Int],target:Int) -> Bool{
    return binarySearch(nums: nums, target: target, left: 0, right: nums.count - 1)
}

func binarySearch(nums:[Int], target:Int, left:Int, right:Int) -> Bool {
    guard left <= right else {
        return false
    }
    
    let mid = (right - left)/2 + left
    
    if nums[mid] == target {
        return true
    }
    else if nums[mid] < target {
        return binarySearch(nums: nums, target: target, left: mid + 1, right: right)
    }
    else {
        return binarySearch(nums: nums, target: target, left: left, right: mid - 1)
    }
}


// 排序面试题
// 合并多个会议时间 3-5点  4-6点 合并成为 3-6点

public class MeetingTime {
    public var start: Int
    public var end: Int
    public init (_ start:Int, _ end: Int)
    {
        self.start = start
        self.end = end
    }
}

func merge(meetingTimes: [MeetingTime]) -> [MeetingTime] {
    
    guard meetingTimes.count > 1 else {
        return meetingTimes
    }
    
    let meetingTimes = meetingTimes.sorted(){
        if $0.start != $1.start {
            return $0.start < $1.start
        }
        else {
            return $0.end < $1.end
        }
    }
    
    //新建结果数组
    var res = [MeetingTime]()
    res.append(meetingTimes[0])
    
    for i in 1..<meetingTimes.count {
        let last = res[res.count - 1]
        let current = meetingTimes[i]
        if current.start > last.end {
            res.append(current)
        }
        else {
            last.end = max(last.end, current.end)
        }
    }
    return res
}


// 版本崩溃

func findFirstBadVersion(n:Int) -> Int {
    //处理特殊情况
    guard n >= 1 else {
        return -1
    }
    
    var left = 1, right = n, mid = 0
    
    while left < right {
        mid = (right - left) / 2 + left
        if isBadVersion (version: mid) {
            right = mid
        }
        else {
            left = mid + 1
        }
    }
    
    return left // return right 同样正确
}

func isBadVersion(version:Int) -> Bool {
    // 假设第三个版本是崩溃的
    if version >= 3 {
        return true
    }
    return false
}

// 搜索旋转有序数组

func search(nums: [Int], target:Int) -> Int {
    var (left, mid, right) = (0, 0, nums.count - 1)
    
    while left <= right {
        mid = (right - left)/2 + left
        if nums[mid] == target {
            return mid
        }
        
        if nums[mid] >= nums[left] {
            if nums[mid] > target && target >= nums[left] {
                right = mid - 1
            }
            else {
                left = mid + 1
            }
        }
        else {
            if nums[mid] < target && target <= nums[right] {
                left = mid + 1
            }
            else {
                right = mid - 1
            }
        }
    }
    return -1
}


//DFS 深度优先搜索 前序遍历  递归
//BFS 广度优先搜索 层级遍历  循环

//
//func dfs(_ root:Node?) {
//    guard let root = root else {
//        return
//    }
//
//    visit(root)
//    root.visited = true
//
//    for node in root.neighbors {
//        if !node.visited {
//            dfs(node)
//        }
//    }
//}
//
//func bfs(_ root:Node?)  {
//    var queue = [Node]()
//
//    if let root = root {
//        queue.append(root)
//    }
//
//    while !queue.isEmpty {
//        let current = queue.removeFirst()
//
//        visit(current)
//        current.visited = true
//
//        for node in current.neighbors {
//            if !node.visited  {
//                queue.append(node)
//            }
//        }
//    }
//}
