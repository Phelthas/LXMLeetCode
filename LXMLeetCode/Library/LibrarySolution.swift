//
//  LibrarySolution.swift
//  LXMLeetCode
//
//  Created by kook on 2018/8/8.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class LibrarySolution {
    
    /// 9 回文数
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        var one = [Int]()
        var two = [Int]()
        var x = x
        while x != 0 {
            let a = x % 10
            one.append(a)
            two.insert(a, at: 0)
            x = x / 10
        }
        return one == two
    }
    
    /// 6. Z字形变换
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows == 1 { return s }
        var array = [Character](s)
        let n = array.count
        var matrix = [[Character]]()
        for i in 0 ..< numRows {
            let a = [Character](repeating: "0", count: n)
            matrix.append(a)
        }
        
        var index = 0
        var i = 0
        var j = 0
        var isVertical = true
        while index < array.count {
            let current = array[index]
            index += 1
            matrix[i][j] = current
            if isVertical {
                i += 1
                if i == numRows {
                    i -= 2
                    j += 1
                    isVertical = false
                }
            } else {
                i -= 1
                j += 1
                if i < 0 {
                    i += 2
                    j -= 1
                    isVertical = true
                }
            }
        }
        array.removeAll()
        for i in 0 ..< numRows {
            for j in 0 ..< n {
                let a = matrix[i][j]
                if a != "0" {
                    array.append(a)
                }
            }
        }
        return String(array)
    }
    
    //27. 移除元素
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        guard nums.count > 0 else { return 0 }
        var i = 0
        var last = nums.count - 1
        while i <= last {
            if nums[i] == val {
                nums[i] = nums[last]
                nums[last] = 0
                last -= 1
            } else {
                i += 1
            }
        }
        return i
    }
    
    /// 367. 有效的完全平方数
    func isPerfectSquare(_ num: Int) -> Bool {
        if num == 1 { return true }
        var left = 0
        var right = num
        while left <= right {
            let mid = (left + right) / 2
            if num / mid == mid && num % mid == 0 {
                return true
            } else if num / mid < mid {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return false
    }
    
    /// 11. 盛最多水的容器
    func maxArea(_ height: [Int]) -> Int {
        var result = 0
        var left = 0
        var right = height.count - 1
        while left < right {
            let m = (right - left) * min(height[left], height[right])
            result = max(result, m)
            if height[left] <= height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        return result
    }
    
    /// 16. 最接近的三数之和 直接遍历肯定超时，我本来想到了思路，但是绝对值跟大于小于的关系没绕过来
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        var array = nums.sorted()
        var diff = Int.max
        var result = 0
        for i in 0 ..< array.count - 2 {
            let a = array[i]
            
            var j = i + 1
            var k = array.count - 1
            while j < k {
                let b = array[j]
                let c = array[k]
                let tempSum = a + b + c
                if abs(tempSum - target) < diff {
                    diff = abs(tempSum - target)
                    result = tempSum
                }
                if tempSum > target {
                    k -= 1
                } else if tempSum < target {
                    j += 1
                } else {
                    return result
                }
            }
        }
        return result
    }
    
    
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        
        var array = nums.sorted()
        var result = [[Int]]()
        guard nums.count >= 4 else { return result }
        
        for i in 0 ..< nums.count - 3 {
            for j in i + 1 ..< nums.count - 2 {
                var left = j + 1
                var right = nums.count - 1
                while left < right {
                    let sum = array[i] + array[j] + array[left] + array[right]
                    if sum == target {
                        let temp = [array[i], array[j], array[left], array[right]]
                        if !result.contains(temp) {
                            result.append(temp)
                        }
                        left += 1
                        right -= 1
                    } else if sum > target {
                        right -= 1
                    } else {
                        left += 1
                    }
                }
            }
        }
        
        return result
    }
    
    
    /// 35. 搜索插入位置
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else { return 0 }
        if target < nums[0] { return 0 }
        
        for i in 0 ..< nums.count {
            let current = nums[i]
            if current == target {
                return i
            } else if current > target {
                return i
            }
        }
        return nums.count
    }
    
    /// 39. 组合总和 ，这题还是有点晕，基本是蒙出来的
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        
        var result = [[Int]]()
        var array = candidates.sorted()
        
        func helper(array:[Int], start: Int, temp: [Int], sum: Int) {
            if sum == target {
                result.append(temp)
                return
            } else if sum > target {
                return
            } else {
                for i in start ..< array.count {
                    var temp = temp
                    temp.append(array[i])
                    helper(array: array, start: i, temp: temp, sum: sum + array[i])
                }
            }
            
        }
        helper(array: array, start: 0, temp: [Int](), sum: 0)
        return result
    }
    
    /// 40. 组合总和 II 完全抄的，没看懂
//    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
//        var sortNums = candidates.sorted()
//        var tmp = [Int]()  // current set for testing
//        var rlt = [[Int]]() // the result set
//
//        // subtrack a num from candidates to find the combination:
//        func backtrack(_ nums: inout [Int], _ tmp: inout [Int], _ start:Int, _ tg:Int, _ rlt:inout[[Int]]) {
//            if tg==0 { // find one and put into result;
//                rlt.append(tmp)
//                return
//            }
//            if start >= nums.count || nums[start] > tg { return } // go on condictions
//            for i in start...nums.count-1 {
//                if tg < nums[i] { return }
//                if i != start && nums[i]==nums[i-1] { continue } // skip the same num been used
//                tmp.append(nums[i])
//                backtrack(&nums, &tmp, i+1, tg-nums[i], &rlt)
//                tmp.removeLast()
//            }
//        }
//
//        backtrack(&sortNums, &tmp, 0, target, &rlt)
//        return rlt
//    }
    
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var array = candidates.sorted()
        var result = [[Int]]()
        
        func helper(start: Int, temp: [Int], sum: Int) {
            if sum == target {
                result.append(temp)
                return
            }
            if start >= array.count || sum > target {
                return
            }
            for i in start ..< array.count {
                if sum + array[i] > target { return }
                if i != start && array[i] == array[i - 1] { continue }//这一句是关键,一次递归取一个数放到temp里面，而一次for循环里的操作是平级的，也就是都是当第start个数来用，如果这时候有跟前一个数相等的，就直接跳过就行了。比如array是[1,1,1,2,3],那只需要分别取1，2，3为第一个数递归就行了，不能讲1取三次！
                var temp = temp
                temp.append(array[i])
                helper(start: i + 1, temp: temp, sum: sum + array[i])
            }
        }
        helper(start: 0, temp: [Int](), sum: 0)
        return result
    }
    
    /// 47 全排列 II  跟40有点像
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var array = nums.sorted()
        var n = nums.count
        var result = [[Int]]()
        func helper(remain: [Int], temp: [Int]) {
            if temp.count == n {
                result.append(temp)
            } else {
                for i in 0 ..< remain.count {
                    if 0 == i || remain[i] != remain[i - 1] {
                        var newRemain = remain
                        let current = newRemain.remove(at: i)
                        var newTemp = temp
                        newTemp.append(current)
                        helper(remain: newRemain, temp: newTemp)
                    }
                }
            }
        }
        helper(remain: array, temp: [Int]())
        return result
    }
    
    /// 58. 最后一个单词的长度 这么简单的题居然边界条件调了半天。。。
    func lengthOfLastWord(_ s: String) -> Int {
        guard s.count > 0 else { return 0 }
        let array = [Character](s)
        var i = array.count - 1
        while i >= 0 {
            if array[i] == " " {
                i -= 1
                if i < 0 {
                    return 0
                }
            } else {
                var j = i - 1
                while j >= 0 {
                    if array[j] == " " {
                        return i - j
                    } else {
                        j -= 1
                    }
                }
                return i - j
            }
        }
        return array.count
    }
}
