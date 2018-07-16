//
//  SortSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/5/5.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation


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
    
}


