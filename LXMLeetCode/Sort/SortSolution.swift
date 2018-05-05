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
