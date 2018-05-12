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

extension ArraySolution {
    
    /// 只出现一次的数字
    /// 利用的是异或的性质，想个相同的数异或等于0，任何数和0异或等于本身，即“两个输入相同时为0，不同则为1”
    func singleNumber(_ nums: [Int]) -> Int {
        var result = 0
        for temp in nums {
            result = result ^ temp
        }
        return result
    }
}


extension ArraySolution {
    
    /// 两个数组的交集
    /// 输出结果中每个元素出现的次数，应与元素在两个数组中出现的次数一致。
    /// 我们可以不考虑输出结果的顺序。
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var resultArray = [Int]()
        var array1 = nums1
        var array2 = nums2
        
        while array1.count != 0 && array2.count != 0 {
            let one = array1[0]
            if let index = array2.index(of: one) {
                resultArray.append(one)
                array1.removeFirst()
                array2.remove(at: index)
            } else {
                array1.removeFirst()
            }
        }
        return resultArray
    }
    
    /* 其他人提交的耗时最少的方法，利用字典记录出现次数
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var map = [Int: Int]()
        var result = Array<Int>()
        
        //记录nums1中每个数出现的次数
        for item in nums1 {
            let total = map[item]
            map[item] = (total ?? 0) + 1
        }
        
        //nums2中，如果item在map中有记录，且记录数大于0，就说明item在nums1中也出现过，就把它添加到交集数组中，并让map中的记录数减一
        for item in nums2 {
            if let number = map[item], number > 0 {
                result.append(item)
                map[item] = number - 1
            }
        }
        
        return result
    }
    */
}

extension ArraySolution {
    func plusOne(_ digits: [Int]) -> [Int] {
        
        //再某一位上加一，如果产生进位返回1，否则返回0；index0位个位，1位十位。。。
        func plusOne(array: inout [Int], atIndex index: Int) -> Int {
            if index == array.count {
                array.insert(1, at: 0)
                return 0
            } else {
                let location = array.count - 1 - index
                var temp = array[location]
                temp = temp + 1
                array[location] = temp % 10
                if temp > 9 {
                    return 1
                } else {
                    return 0
                }
            }
        }
        
        var resultArray = digits
        var index = 0
        while true {
            let advance = plusOne(array: &resultArray, atIndex: index)
            if advance == 0 {
                break
            } else {
                index += 1
            }
        }
        return resultArray
    }
}
