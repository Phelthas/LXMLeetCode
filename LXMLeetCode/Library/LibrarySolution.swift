//
//  LibrarySolution.swift
//  LXMLeetCode
//
//  Created by kook on 2018/8/8.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class Library {
    
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
}
