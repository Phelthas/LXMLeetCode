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
    
    
    /// 190. 颠倒二进制位
    func reverseBits(_ n: UInt32) -> UInt32 {
        var result: UInt32 = 0
        var x = n;
        for _ in 0 ..< 32 {
            result = (result << 1) | (x & 1)
            x = x >> 1
        }
        return result
    }
    
    /// 118. 杨辉三角
    func generate(_ numRows: Int) -> [[Int]] {
        var result = [[Int]]()
        guard numRows > 0 else { return result }
        for i in 1 ... numRows {
            let temp = [Int](repeating: 1, count: i)
            result.append(temp)
        }
        if numRows >= 3 {
            for i in 3 ... numRows {
                for j in 1 ... i - 2 {
                    result[i - 1][j] = result[i - 2][j - 1] + result[i - 2][j]
                }
            }
        }
        return result
    }
}
