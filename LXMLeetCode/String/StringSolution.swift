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
    
    /// 翻转字符串
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
    
    // 字符串中的第一个唯一字符
    func firstUniqChar(_ s: String) -> Int {
        var dict = [Character : Int]()
        for temp in s {
            if let current = dict[temp] {
                dict[temp] = current + 1
            } else {
                dict[temp] = 1
            }
        }
        for key in s {
            if dict[key] == 1 {
                let result = s.index(of: key)
                return s.distance(from: s.startIndex, to: result!)
            }
        }
        return -1
    }
    
    //有效的字母异位词
    func isAnagram(_ s: String, _ t: String) -> Bool {
//        let one = s.sorted()
//        let two = t.sorted()
//        return one == two
        var dictOne = [Character : Int]()
        for temp in s {
            dictOne[temp] = (dictOne[temp] ?? 0) + 1
        }
        var dictTwo = [Character : Int]()
        for temp in t {
            dictTwo[temp] = (dictTwo[temp] ?? 0) + 1
        }
        return dictOne == dictTwo
    }
    
}
