//
//  LibrarySolution4.swift
//  LXMLeetCode
//
//  Created by kook on 2018/11/30.
//  Copyright © 2018 duowan. All rights reserved.
//

import Foundation

/// 303. 区域和检索 - 数组不可变
class NumArray {
    
    var nums: [Int]
    
    init(_ nums: [Int]) {
        self.nums = nums
    }
    
    func sumRange(_ i: Int, _ j: Int) -> Int {
        var sum = 0
        for k in 0 ..< nums.count {
            if k >= i {
                sum += nums[k]
            }
            if k == j {
                break
            }
        }
        return sum
    }
}
