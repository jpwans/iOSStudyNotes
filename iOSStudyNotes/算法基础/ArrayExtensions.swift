//
//  ArrayExtensions.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/20.
//

import Foundation


//extension Array {
//    func indexForInsertingObject(object:AnyObject, compare :(
//        (a:AnyObject, b:AnyObject) -> Int)
//    ) -> Int {
//        var left = 0
//        var right = self.count
//        var mid = 0
//
//        while left < right {
//            mid = (right - left) / 2 + left
//
//            if compare(a:self[mid] as! AnyObject, b:object) < 0 {
//                left = mid + 1
//            }
//            else {
//                right = mid
//            }
//        }
//        return left
//    }
//}
//
//let insertIdx = news.indexForInsertingObject(object: singleNews) {(a,b) -> Int in
//    let newsA = a as! News
//    let newsB = b as! News
//    return newsA.compareDate(newsB)
//}
//
//news.inster(singleNews, at: insertIdx)
//

