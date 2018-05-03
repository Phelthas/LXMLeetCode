//
//  ArraySolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/5/3.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class ArraySolution {
    
    func removeDuplicates(nums: inout [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count
        }
        var index = 1
        var last = nums[0]
        for i in 1 ..< nums.count {
            let current = nums[i]
            if current != last {
                nums[index] = current
                last = current
                index += 1
            }
        }
        return index
    }
    
    class func removeDuplicatesSolution() {
        print("从排序数组中删除重复项")
        let arraySolution = ArraySolution()
        var testArray = [1, 1, 1, 1]
        let count = arraySolution.removeDuplicates(nums: &testArray)
        print(testArray[0 ..< count])
    }
    
}
