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

