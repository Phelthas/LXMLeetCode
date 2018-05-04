//
//  ArraySolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/5/3.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class ArraySolution {
    
    
    /// 从排序数组中删除重复项
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

extension ArraySolution {
    
    
    /// 向右旋转数组k位, 网上看到reverse3次的算法，不懂原理是什么。。。有空研究下
    func rotate(nums: inout [Int], _ k: Int) {
        let realK = k % nums.count
        if nums.count <= 1 || realK <= 0 {
            return
        }
        let subarray = nums[nums.count - realK ... nums.count - 1]
        for i in (realK ... nums.count - 1).reversed() {
            nums[i] = nums[i - realK]
        }
        nums[0...realK-1] = subarray
    }
    
    class func rotateRightSolution() {
        print("向右旋转数组k位")
        let arraySolution = ArraySolution()
        var testArray = [1, 2, 3, 4, 5, 6, 7]
        arraySolution.rotate(nums: &testArray, 3)
        print(testArray)
    }
    
}

