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
    
    
    
    /// 20. 有效的括号
    func isValid(_ s: String) -> Bool {
        guard s.count > 0 else { return true }
        if s.count == 1 { return false }
        let array = [Character](s)
        var lastArray = [Character]()
        lastArray.append(array[0])
        for i in 1 ..< array.count {
            let current = array[i]
            if let last = lastArray.last {
                if last == " " {
                    // 空格忽略
                } else if (last == "(" && current == ")") ||
                    (last == "[" && current == "]") ||
                    (last == "{" && current == "}") {
                    lastArray.removeLast()
                } else {
                    lastArray.append(current)
                }
            } else {
                lastArray.append(current)
            }
        }
        if lastArray.count == 0 {
            return true
        }
        return false
    }
    
    /// 268. 缺失数字, 最快的算法是用异或，其次是用总数求和-数组求和，这两个都是用常数额外空间，我这个算法用了n。。。
    func missingNumber(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0}
        var dict = [Int: Bool]()
        for i in nums {
            dict[i] = true
        }
        for i in 0 ... nums.count {
            if dict[i] == nil {
                return i
            }
        }
        return 0
    }
    
    /// 371. 两整数之和, 这个完全不知道，当成新的知识点学习吧
    func getSum(_ a: Int, _ b: Int) -> Int {
        if b == 0 { return a }
        let xorSum = a ^ b
        let carry = (a & b) << 1
        return getSum(xorSum, carry)
    }
}
