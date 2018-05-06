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
        
        func helper(array: inout [Int], low: Int, high: Int) {
            if low < high {
                let pivot = partition(array: &array, low: low, high: high)
                helper(array: &array, low: low, high: pivot - 1)
                helper(array: &array, low: pivot + 1, high: high)
            }
        }
    
        helper(array: &array, low: 0, high: array.count - 1)
    }
    
    class func quickSortSolution() {
        let sortSolution = SortSolution()
        var testArray = SortSolution.testArray()
        sortSolution.quickSort(array: &testArray)
        print("快速排序")
        print(testArray)
    }
    
}

extension SortSolution {
    func heapSort(array: inout [Int]) {
        
        /// 对以第s个节点为跟的子树进行筛选
        /// array[s ... m]中除array[s]外均满足堆定义
        func heapAdjust(array: inout [Int], s: Int, m: Int) {
            var s = s
            let temp = array[s]
            var j = 2 * s + 1
            while j < m {
                if j + 1 < m && array[j] < array[j + 1] {
                    j = j + 1
                }
                if temp > array[j] {
                    break
                }
                array[s] = array[j]
                s = j
                j = j * 2 + 1
            }
            array[s] = temp
        }
        
        for i in (0 ... array.count / 2 - 1).reversed() {
            heapAdjust(array: &array, s: i, m: array.count)
        }
        for i in (1 ... array.count - 1).reversed() {
            let temp = array[0]
            array[0] = array[i]
            array[i] = temp
            heapAdjust(array: &array, s: 0, m: i)
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

