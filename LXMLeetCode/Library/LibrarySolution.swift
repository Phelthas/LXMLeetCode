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
}
