//
//  BacktrackingSolution.swift
//  LXMLeetCode
//
//  Created by kook on 2018/7/9.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class BacktrackingSolution {
    
    /// 17. 电话号码的字母组合
    func letterCombinations(_ digits: String) -> [String] {
        let dict: [Character : [String]] = [
            "2" : ["a", "b", "c"],
            "3" : ["d", "e", "f"],
            "4" : ["g", "h", "i"],
            "5" : ["j", "k", "l"],
            "6" : ["m", "n", "o"],
            "7" : ["p", "q", "r", "s"],
            "8" : ["t", "u", "v"],
            "9" : ["w", "x", "y", "z"]
        ]
        
        func test(_ one: [String], _ two: [String]) -> [String] {
            if one.count == 0 {
                return two
            }
            if two.count == 0 {
                return one
            }
            var result = [String]()
            for temp1 in one {
                for temp2 in two {
                    result.append(temp1 + temp2)
                }
            }
            return result
        }
        
        var result = [String]()
        for item in digits {
            let array = dict[item]!
            result = test(result, array)
        }
        return result
    }
    
    
    /// 22. 括号生成,这是看别人博客写的，这个思路还是需要好好理解一下，深度优先的回溯
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        
        func generateDFS(_ left: Int, _ right: Int, _ s: String) {
            if left == 0 && right == 0 {
                result.append(s)
            }
            if left > 0 {
                generateDFS(left - 1, right, s + "(")
            }
            if right > 0 && left < right {
                generateDFS(left, right - 1, s + ")")
            }
        }
        
        generateDFS(n, n, "")
        return result
        
    }
}
