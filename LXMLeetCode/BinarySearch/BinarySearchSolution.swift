//
//  BinarySearchSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/9/5.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class BinarySearchSolution {
    /// 704. 二分查找
    func search(_ nums: [Int], _ target: Int) -> Int {
        
        func helper(start: Int, end: Int) -> Int {
            if start == end {
                if nums[start] == target {
                    return start
                } else {
                    return -1
                }
            }
            let mid = (start + end) / 2
            let current = nums[mid]
            if current == target {
                return mid
            }
            if current > target {
                return helper(start: start, end: mid)
            } else {
                return helper(start: mid + 1, end: end)
            }
        }
        return helper(start: 0, end: nums.count - 1)
    }
}
