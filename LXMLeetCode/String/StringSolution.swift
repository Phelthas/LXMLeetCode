//
//  StringSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/5/19.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation


class StringSolution {
    
    // func reverseString(_ s: String) -> String {
    //     return String(s.reversed())
    // }
    
    // func reverseString(_ s: String) -> String {
    //     var resultString = ""
    //     for char in s {
    //         resultString.insert(char, at: String.Index.init(encodedOffset: 0))
    //     }
    //     return resultString
    // }
    
    func reverseString(_ s: String) -> String {
        guard s.count > 0 else { return s }
        var array = Array(s)
        var resultString = ""
        for i in (0 ..< array.count).reversed() {
            resultString.append(array[i])
        }
        return resultString
    }
    
    
    /// 颠倒整数
    func reverse(_ x: Int) -> Int {
        var current = x
        var result = 0
        while current != 0 {
            let lastNumber = current % 10
            result = result * 10 + lastNumber
            current = current / 10
            if result > 2147483647 || result < -2147483648 {
                return 0
            }
        }
        return result
    }
}
