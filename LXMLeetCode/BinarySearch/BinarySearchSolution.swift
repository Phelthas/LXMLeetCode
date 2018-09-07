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
    
    /// 153. 寻找旋转排序数组中的最小值
    /* 其实没完全搞懂，下面是看别人博客的解释
     如果用二分查找的话，当中间的值大于最右边的值的时候，那么最小值一定在mid和right中间，当中间值小于最左边值的时候，最小值一定在left和mid中间，只有当right mid 和 left的值相同的时候才无法确定 最小值在哪个区间，无法确定的时候让right的值 自减就好，因为right的一定是大于等于最小值的
     */
    func findMin(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return -1 }
        var left = 0
        var right = nums.count - 1
        
        while left < right {
            
            let mid = (left + right)/2;
            
            if nums[mid] > nums[right] {
                
                left = mid + 1;
            } else {
                
                right = mid;
            }
        }
        
        return nums[left]
    }

    /// 658. 找到 K 个最接近的元素,自己想的，别别人提交的只计算下标的方法要复杂了点，理论上不用操作数组的
    func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        
        
        var left = 0
        var right = arr.count - 1
        var index = 0
        while left < right {
            if left == right - 1 {
                if abs(arr[left] - x) <= abs(arr[right] - x) {
                    index = left
                } else {
                    index = right
                }
                break
            }
            let mid = (left + right) / 2
            if arr[mid] == x {
                index = mid
                break
            } else if arr[mid] > x {
                right = mid
            } else {
                left = mid
            }
        }
        var result = [Int]()
        result.append(arr[index])
        left = index - 1
        right = index + 1
        while result.count != k {
            if left < 0 {
                result.append(arr[right])
                right += 1
                continue
            }
            if right > arr.count - 1 {
                result.insert(arr[left], at: 0)
                left -= 1
                continue
            }
            if abs(arr[left] - x) <= abs(arr[right] - x) {
                result.insert(arr[left], at: 0)
                left -= 1
            } else {
                result.append(arr[right])
                right += 1
            }
        }
        
        return result
    }
}
