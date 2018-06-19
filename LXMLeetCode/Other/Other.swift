//
//  Other.swift
//  LXMLeetCode
//
//  Created by kook on 2018/6/18.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation


class OtherSolution {
    
    //191. 位1的个数
    func hammingWeight(_ n: UInt) -> Int {
        var result: Int = 0
        var current = n
        while (current != 0) {
            if (current % 2 != 0) {
                result += 1;
            }
            current = current >> 1;
        }
        return result;
    }
    
    
    /// 题目461，汉明距离
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var m = x
        var n = y
        var result = 0
        while n != 0 || m != 0 {
            let a = m % 2
            let b = n % 2
            if a != b {
                result += 1
            }
            m = m >> 1
            n = n >> 1
        }
        return result
    }
}
