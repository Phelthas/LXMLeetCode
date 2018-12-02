//
//  LibrarySolution4.swift
//  LXMLeetCode
//
//  Created by kook on 2018/11/30.
//  Copyright © 2018 duowan. All rights reserved.
//

import Foundation

/// 303. 区域和检索 - 数组不可变
class NumArray {
    
    var nums: [Int]
    
    init(_ nums: [Int]) {
        self.nums = nums
    }
    
    func sumRange(_ i: Int, _ j: Int) -> Int {
        var sum = 0
        for k in 0 ..< nums.count {
            if k >= i {
                sum += nums[k]
            }
            if k == j {
                break
            }
        }
        return sum
    }
}

/// 304. 二维区域和检索 - 矩阵不可变  这道题有点意思
/// 其实这是个处理二维数组的常见方法，用一个矩阵sumMatrix来保存从（0，0）到（i，j）的所有数字的和
class NumMatrix {
    
    var matrix: [[Int]]
    var sumMatrix = [[Int]]()
    
    init(_ matrix: [[Int]]) {
        self.matrix = matrix
        sumMatrix = matrix
        let m = matrix.count
        if m == 0 { return }
        let n = matrix[0].count
        for i in 0 ..< m {
            for j in 1 ..< n {
                sumMatrix[i][j] = sumMatrix[i][j - 1] + sumMatrix[i][j]
            }
        }
        for j in 0 ..< n {
            for i in 1 ..< m {
                sumMatrix[i][j] = sumMatrix[i - 1][j] + sumMatrix[i][j]
            }
            
        }
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        if row1 == 0 && col1 == 0 {
            return sumMatrix[row2][col2]
        } else if row1 == 0 {
            return sumMatrix[row2][col2] - sumMatrix[row2][col1 - 1]
        } else if col1 == 0 {
            return sumMatrix[row2][col2] - sumMatrix[row1 - 1][col2]
        } else {
            return sumMatrix[row2][col2] - sumMatrix[row1 - 1][col2] - sumMatrix[row2][col1 - 1] + sumMatrix[row1 - 1][col1 - 1]
        }
        
    }
}

extension LibrarySolution {
    
    /// 306. 累加数
    func isAdditiveNumber(_ num: String) -> Bool {
        let array = [Character](num)
        let n = array.count
        if n < 3 { return false }
        
        func helper(s1: String, s2: String, remain: String) -> Bool {
            let one = Int(s1)!
            let two = Int(s2)!
            let next = "\(one + two)"
            if next == remain { return true }
            var newRemain = remain
            if remain.hasPrefix(next) {
                let range = remain.range(of: next)!
                newRemain.replaceSubrange(range, with: "")
                return helper(s1: s2, s2: next, remain: newRemain)
            } else {
                return false
            }
        }
        
        //设第一个数是以i结尾的，那第二个数是以j结尾的
        for i in 0 ... (n - 1)/2 - 1 {
            let one = String(array[0...i])
            for j in i + 1 ... n - i {
                let two = String(array[i+1 ... j])
                let remain = String(array[j ... n-1])
                if helper(s1: one, s2: two, remain: remain) {
                    return true
                }
            }
        }
        return false
    }
    
    
}
