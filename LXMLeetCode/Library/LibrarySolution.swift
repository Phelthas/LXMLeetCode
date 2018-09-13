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
    
    /// 16. 最接近的三数之和
}
