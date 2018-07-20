//
//  SortSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/5/5.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

public class Interval {
    public var start: Int
    public var end: Int
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}


class SortSolution {
    
    class func testArray() -> [Int] {
        return [7, 3, 1, 4, 5, 6, 2]
    }
    
    func quickSort(array: inout [Int]) {
        
        /// 填坑法
        func partition(array: inout [Int], low: Int, high: Int) -> Int {
            var i = low
            var j = high
            let temp = array[i]
            while i < j {
                while i < j && array[j] >= temp {
                    j = j - 1
                }
                if i < j {
                    array[i] = array[j]
                }
                while i < j && array[i] <= temp {
                    i = i + 1
                }
                if i < j {
                    array[j] = array[i]
                }
            }
            array[i] = temp
            return i
        }
        
        
        /// 交换位置的方法
        func partitionWithSwap(array: inout [Int], low: Int, high: Int) -> Int {
            let key = array[low]
            var left = low
            var right = high
            while left < right {
                while left < right && array[right] >= key {
                    right = right - 1
                }
                while left < right && array[left] <= key {
                    left = left + 1
                }
                if left < right {
                    array.swapAt(left, right)
                }
            }
            array.swapAt(low, left)
            return left
        }
        
        func helper(array: inout [Int], low: Int, high: Int) {
            if low < high {
//                let pivot = partition(array: &array, low: low, high: high)
                let pivot = partitionWithSwap(array: &array, low: low, high: high)
                helper(array: &array, low: low, high: pivot - 1)
                helper(array: &array, low: pivot + 1, high: high)
            }
        }
    
        helper(array: &array, low: 0, high: array.count - 1)
    }
    
    class func quickSortSolution() {
        print("快速排序")
        let sortSolution = SortSolution()
        var testArray = SortSolution.testArray()
        sortSolution.quickSort(array: &testArray)
        print(testArray)
        
    }
    
}

extension SortSolution {
    func heapSort(array: inout [Int]) {
        
        /// 调整数组中以location为根节点的子树，使之满足堆定义
        /// length需要进行调整的数组的范围，建立堆时length是完整的数组的长度；调整时length
        func heapAdjust(array: inout [Int], location: Int, length: Int) {

            let target = array[location]
            var i = location
            var j = 2 * i + 1
            while j < length {
                if j + 1 < length && array[j + 1] > array[j] {
                    j = j + 1
                }
                if target > array[j] {
                    break
                }
                array.swapAt(i, j)
                i = j
                j = 2 * j + 1
            }
        }
        
//        /// 对以第s个节点为跟的子树进行筛选
//        /// array[s ... m]中除array[s]外均满足堆定义
//        func heapAdjust(array: inout [Int], location: Int, length: Int) {
//            var s = location
//            let temp = array[s]
//            var j = 2 * s + 1
//            while j < length {
//                if j + 1 < length && array[j] < array[j + 1] {
//                    j = j + 1
//                }
//                if temp > array[j] {
//                    break
//                }
//                array[s] = array[j]
//                s = j
//                j = j * 2 + 1
//            }
//            array[s] = temp
//        }
        
        for i in (0 ... array.count / 2 - 1).reversed() {
            heapAdjust(array: &array, location: i, length: array.count)
        }
        for i in (1 ... array.count - 1).reversed() {
            array.swapAt(0, i)
//            let temp = array[0]
//            array[0] = array[i]
//            array[i] = temp
            heapAdjust(array: &array, location: 0, length: i)
        }
    }
    
    class func heapSortSolution() {
        let sortSolution = SortSolution()
        var testArray = SortSolution.testArray()
        sortSolution.heapSort(array: &testArray)
        print("堆排序")
        print(testArray)
    }
}

extension SortSolution {
    func insertSort(array: inout [Int]) {
        guard array.count > 0 else { return }
        var current = 0
        for i in 1 ..< array.count {
            current = array[i]
            if current < array[i - 1] {
                current = array.remove(at: i)
                if current < array[0] {
                    array.insert(current, at: 0)
                } else {
                    for j in (0 ..< i - 1).reversed() {
                        if current > array[j] {
                            array.insert(current, at: j + 1)
                            break
                        }
                    }
                }
            }
        }
    }
    
    class func insertSortSolution() {
        let sortSolution = SortSolution()
        var testArray = SortSolution.testArray()
        sortSolution.insertSort(array: &testArray)
        print("插入排序")
        print(testArray)
    }
    
}


extension SortSolution {
    

    /// 合并了两个有序数组
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        var i = m - 1
        var j = n - 1
        var k = m + n - 1
        while i >= 0 || j >= 0 {
            if i < 0 {
                nums1[k] = nums2[j]
                j = j - 1
                k = k - 1
            } else if j < 0 {
                nums1[k] = nums1[i]
                i = i - 1
                k = k - 1
            } else if nums1[i] >= nums2[j] {
                nums1[k] = nums1[i]
                i = i - 1
                k = k - 1
            } else {
                nums1[k] = nums2[j]
                j = j - 1
                k = k - 1
            }
        }
    }
    
    // 第一个错误的版本
    func firstBadVersion(n: Int) -> Int {
        
        func isBadVersion(n: Int) -> Bool {
            return arc4random() % 2 == 0
        }
        
        var start = 1
        var end = n
        var center = 0
        while start < end {
            center = start / 2 + end / 2    //!!!注意！！！这里必须不能是（start + end）/ 2，因为两个数之和可能就溢出了。。。。。。。。。。。因为这个超时了半天都不知道怎么错的，还是去网上搜了一下才知道
            if isBadVersion(n: center) {
                end = center
            } else {
                start = center + 1
            }
        }
        return start
    }
}



// MARK: - 中级算法
extension SortSolution {
    
//    ///75. 分类颜色 这算是 计数排序？？？
//    func sortColors(_ nums: inout [Int]) {
//        var count0 = 0
//        var count1 = 0
//        var count2 = 0
//        for num in nums {
//            if num == 0 {
//                count0 += 1
//            } else if num == 1 {
//                count1 += 1
//            } else if num == 2 {
//                count2 += 1
//            }
//        }
//    }
    
    ///75. 分类颜色 进阶算法，只用常数空间，一遍扫描; 设立的三个指针 i，j，k是精髓之处，一定要理解这三个指针的含义，i，j，k分别指向当前已处理好的字符串的最后一个0，1，2。
    func sortColors(_ nums: inout [Int]) {
        var i = -1
        var j = -1
        var k = -1
        for num in nums {
            if num == 0 {
                k += 1
                nums[k] = 2
                j += 1
                nums[j] = 1
                i += 1
                nums[i] = 0
            } else if num == 1 {
                k += 1
                nums[k] = 2
                j += 1
                nums[j] = 1
            } else if num == 2 {
                k += 1
                nums[k] = 2
            }
        }
    }
    
    /// 347. 前K个高频元素
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var dict = [Int: Int]()
        for num in nums {
            if let count = dict[num] {
                dict[num] = count + 1
            } else {
                dict[num] = 1
            }
        }
        
        //这里用系统自带的排序函数貌似就可以，但我这儿是自己写了个插入排序。。。
        var result = [Int]()
        for key in dict.keys {
            if result.count == 0 {
                result.append(key)
            } else {
                let count = dict[key]!
                if count <= dict[result.last!]! {
                    result.append(key)
                } else {
                    for i in 0 ..< result.count {
                        if count >= dict[result[i]]! {
                            result.insert(key, at: i)
                            break
                        }
                    }
                }
            }
        }
        return Array(result[0 ... k-1])
    }
    
    /// 215 数组中的第K个最大元素，暂时用的快速排序，待优化
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        
        func partition(array: inout [Int], low: Int, high: Int) -> Int {
            guard array.count > 0 else { return 0}
            var left = low
            var right = high
            let temp = array[low]
            while left < right {
                while left < right && array[right] <= temp {
                    right -= 1
                }
                while left < right && array[left] >= temp {
                    left += 1
                }
                if left < right {
                    array.swapAt(left, right)
                }
                
            }
            array.swapAt(left, low)
            return left
        }
        
        func helper(array: inout [Int], low: Int, high: Int) {
            if low < high {
                let povit = partition(array: &array, low: low, high: high)
                helper(array: &array, low: povit + 1, high: high)
                helper(array: &array, low: low, high: povit - 1)
            }
        }
        
        var array = nums
        helper(array: &array, low: 0, high: array.count - 1)
        return array[k - 1]
    }
    
    
//    /// 162. 寻找峰值, 这个时间复杂度是O(n)的，要二分查找才是O(logN)的
//    func findPeakElement(_ nums: [Int]) -> Int {
//        guard nums.count > 0 else { return -1}
//        var last = Int.min
//        for i in 0 ..< nums.count {
//            let current = nums[i]
//            if current > last && i == nums.count - 1 {
//                return i
//            } else {
//                let next = nums[i + 1]
//                if current > last && current > next {
//                    return i
//                } else {
//                    last = current
//                }
//            }
//        }
//        return -1
//    }
    
    /// 162. 寻找峰值, 二分查找才是O(logN)的
    /*
     如果中间元素大于其相邻的后续元素，则中间元素左侧（包括中间元素）必然包含一个局部最大值，如果中间元素小于其相邻的后续元素，则中间元素右侧必然包含一个局部最大值。直到最后左边沿和右边沿相遇，我们找到所求峰值。
     我们选择左右边沿相遇作为结束条件，以及只和后续元素mid+1比较，可以避免考虑当mid为0时，mid-1为负值的特殊情况。题目中只是让我们假设num[-1] = num[n] = 负无穷，实际上，数组是无法得到这两个值的，指针会越界。
     这里，我们还需要注意的是，当中间元素大于其相邻的后续元素时，说明中间元素左侧（包含中间元素）必然包含一个局部最大值，这时，中间元素也可能是峰值点，所以移动时，end = mid, 而不能跨过中间元素end = mid -1. 而相反情况，中间元素小于其向相邻后续元素，则中间元素右侧比包含一个局部最大值，这时候中间元素一定不是局部最大点，start = mid + 1.
     */
    func findPeakElement(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return -1}
        var left = 0
        var right = nums.count - 1
        while left <= right {
            if left == right {
                return left
            }
            let mid = (left + right) / 2
            if nums[mid] < nums[mid + 1] {
                left = left + 1
            } else {
                right = mid
            }
        }
        return left
    }
    
    /// 34. 在排序数组中查找元素的第一个和最后一个位置, 自己想的算法
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        guard nums.count > 0 else { return [-1, -1] }
        
        func findLowestIndex(left: Int, right: Int) -> Int {
            if left == right {
                if nums[left] == target {
                    return left
                } else {
                    return -1
                }
            }
            let mid = (left + right) / 2
            if nums[mid] >= target {
                return findLowestIndex(left: left, right: mid)
            } else {
                return findLowestIndex(left: mid + 1, right: right)
            }
        }
        
        func findHighestIndex(left: Int, right: Int) -> Int {
            if left == right {
                if nums[right] == target {
                    return right
                } else {
                    return -1
                }
            }
            let mid = Int(ceil(Float(left + right) / 2.0))
            
            if nums[mid] <= target {
                return findHighestIndex(left: mid, right: right)
            } else {
                return findHighestIndex(left: left, right: mid - 1)
            }
        }
        
        let left = findLowestIndex(left: 0, right: nums.count - 1)
        let right = findHighestIndex(left: 0, right: nums.count - 1)
        return [left, right]
        
    }
    
    ///56. 合并区间 这个题目有点恶心，断点调了N遍。。。看别人博客，先排序再合并会简单很多，时间复杂度也会降低很多
    func merge(_ intervals: [Interval]) -> [Interval] {
        guard intervals.count > 1 else { return intervals }
        var result = [Interval]()
        var couldMerge = false
        
        func helper(_ intervals: [Interval]) -> [Interval] {
            var result = intervals
            var i = 0
            while i < result.count - 1 {
                let one = result[i]
                var j = i + 1
                while j < result.count {
                    let two = result[j]
                    if one.end >= two.start && one.start <= two.end {
                        one.start = min(one.start, two.start)
                        one.end = max(one.end, two.end)
                        result.remove(at: j)
                        couldMerge = true
                    } else {
                        j += 1
                    }
                }
                i += 1
            }
            return result
            
        }
        result = helper(intervals)
        while couldMerge == true {
            couldMerge = false
            result = helper(result)
        }
        return result
    }
    
    //33搜索旋转排序数组 居然超出时间限制，理论上这个也是O(logn)的时间复杂度啊,这里想错了，第一遍找旋转的点，应为不是排序数组，所以第一遍不是logn
//    func search(_ nums: [Int], _ target: Int) -> Int {
//        if nums.count == 0 { return -1 }
//        if nums.count == 1 { return nums[0] == target ? 0 : -1 }
//        var index = nums.count - 1
//        var result = -1
//
//        func findIndex(left: Int, right: Int) {
//            if left <= right {
//                let mid = (left + right) / 2
//                if mid == 0 && nums[0] > nums[1] {
//                    index = 0
//                    return
//                } else if mid == nums.count - 1 {
//                    return
//                } else if nums[mid] > nums[mid + 1] && nums[mid] > nums[mid - 1] {
//                    index = mid
//                    return
//                } else {
//                    findIndex(left: 0, right: mid - 1)
//                    findIndex(left: mid + 1, right: right)
//                }
//            }
//        }
//
//        func findTarget(left: Int, right: Int) {
//            if left <= right {
//                let mid = (left + right) / 2
//                if nums[mid] == target {
//                    result = mid
//                } else if nums[mid] > target {
//                    findTarget(left: left, right: mid - 1)
//                } else {
//                    findTarget(left: mid + 1, right: right)
//                }
//            }
//        }
//
//        findIndex(left: 0, right: nums.count - 1)
//
//        findTarget(left: 0, right: index)
//        if result != -1 {
//            return result
//        }
//        findTarget(left: index + 1, right: nums.count - 1)
//
//        return result
//    }
    
    ///   注意一点：因为是排序数组旋转得来的，所以第一个数组中的任意一个值都大于第二个数组的最大值
    
}


