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

extension ArraySolution {
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        if nums.count <= 1 {
            return false
        }
        
        // 如果包含重复就返回-1，否则返回基准位置
        func containsDuplicatePartition(array: inout [Int], start: Int, end: Int) -> Int {
            var left = start
            var right = end
            let key = array[start]
            while left < right {
                while right > left && array[right] > key {
                    right = right - 1
                }
                if left != right && array[right] == key {
                    return -1
                }
                while left < right && array[left] < key {
                    left = left + 1
                }
                if left != right && array[left] == key {
                    return -1
                }
                if left < right {
                    array.swapAt(left, right)
                }
                
            }
            array.swapAt(start, left)
            return left
        }
        
        
        func recursionHelper(array: inout [Int], start: Int, end: Int) -> Bool {
            if start < end {
                let pivot = containsDuplicatePartition(array: &array, start: start, end: end)
                if pivot == -1 {
                    return true
                } else {
                    let leftResult = recursionHelper(array: &array, start: start, end: pivot - 1)
                    let rightResult = recursionHelper(array: &array, start: pivot + 1, end: end)
                    return leftResult || rightResult
                }
                
            }
            return false
        }
        var array = nums
        return recursionHelper(array: &array, start: 0, end: array.count - 1)
    
        /* 通过的答案，用了系统自带的排序函数，貌似用Set更简单
        if nums.count <= 1 {
            return false
        }
        
        let array = nums.sorted()
        var last = array[0]
        for i in 1 ..< array.count {
            let current = array[i]
            if current == last {
                return true
            } else {
                last = current
            }
        }
        return false
        */
    }
    
    
    class func containsDuplicateSolution() {
        print("包含重复")
        let arraySolution = ArraySolution()
        let testArray = [1, 2, 3, 2]
        print(arraySolution.containsDuplicate(testArray))
    }
}

