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

/// 307. 区域和检索 - 数组可修改
class NumArray307 {
    
    var nums: [Int]
    var sumArray = [Int]()
    
    init(_ nums: [Int]) {
        self.nums = nums
        sumArray = nums
        if nums.count > 1 {
            for i in 1 ..< nums.count {
                sumArray[i] = sumArray[i - 1] + nums[i]
            }
        }
    }
    
    func update(_ i: Int, _ val: Int) {
        let diff = val - nums[i]
        self.nums[i] = val
        for j in i ..< nums.count {
            sumArray[j] += diff
        }
    }
    
    func sumRange(_ i: Int, _ j: Int) -> Int {
        if i == 0 {
            return sumArray[j]
        } else {
            return sumArray[j] - sumArray[i - 1]
        }
        
    }
}

extension LibrarySolution {
    
    /// 306. 累加数,特殊情况1023，1203，101
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
        
        //设第一个数是以i结尾的，第二个数是以j结尾的
        for i in 0 ... (n - 1)/2 - 1 { //i只能取到一半以下的值
            let one = String(array[0...i])
            if one != "0" && one.hasPrefix("0") { continue }
            for j in i + 1 ... n - 2 - i { //j至少取一位，且 n - j >= i
                let two = String(array[i+1 ... j])
                if two != "0" && two.hasPrefix("0") { continue }
                let remain = String(array[j+1 ... n-1])
                if remain != "0" && remain.hasPrefix("0") { continue }
                if helper(s1: one, s2: two, remain: remain) {
                    return true
                }
            }
        }
        return false
    }
    
    
    /// 309. 最佳买卖股票时机含冷冻期
    /*
     参考https://blog.csdn.net/zjuPeco/article/details/76468185
     s0[i] = max(s0[i - 1], s2[i - 1])
     s1[i] = max(s0[i - 1] - prices[i], s1[i - 1])
     s2[i] = s1[i - 1] + prices[i]
     
     其中s0，s1，s2分别表示三种状态下的最大利润值。
     值得注意的是这里的s0，s1和s2不是单纯的buy，sell， rest，而应该是
     
     s0 —— sell后rest或者rest后rest
     s1 —— rest后的buy或者buy后的rest
     s2 —— rest后的sell
     */
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count <= 1 { return 0 }
        var s0: Int = 0
        var s1: Int = -prices[0]
        var s2: Int = Int.min
        for i in 1 ..< prices.count {
            let pre0 = s0
            let pre1 = s1
            let pre2 = s2
            s0 = max(pre0, pre2)
            s1 = max(pre0 - prices[i], pre1)
            s2 = pre1 + prices[i]
        }
        //最大利润不可能出现在buy而未sell的时候，所以不考虑s1
        return max(s0, s2)
    }
    
    
    /// 318. 最大单词长度乘积 双循环遍历超时
//    func maxProduct(_ words: [String]) -> Int {
//        if words.count <= 1 { return 0 }
//        var resultArray = [[Character]]()
//        var result = 0
//        for word in words {
//            let array = [Character](word)
//            resultArray.append(array)
//        }
//        for i in 0 ..< resultArray.count - 1 {
//            let one = Set<Character>(resultArray[i])
//            for j in i + 1 ..< resultArray.count {
//                let two = Set<Character>(resultArray[j])
//                if one.intersection(two).count == 0 {
//                    result = max(result, resultArray[i].count * resultArray[j].count)
//                }
//            }
//        }
//        return result
//    }
    
    /// 318. 最大单词长度乘积 用26位二进制数表示，用位操作计算
    func maxProduct(_ words: [String]) -> Int {
        let aValue = "a".unicodeScalars.first!.value
        if words.count <= 1 { return 0 }
        var array = [Int]()
        for word in words {
            var a = 0
            for c in word.unicodeScalars {
                a = a | (1 << (c.value - aValue))
            }
            array.append(a)
        }
        
        var result = 0
        for i in 0 ..< array.count - 1 {
            for j in 1 ..< array.count {
                if array[i] & array[j] > 0 {
                    continue
                }
                result = max(result, words[i].count * words[j].count)
            }
        }
        return result
    }
    
    /// 319. 灯泡开关, 遍历的方式超时
    func bulbSwitch(_ n: Int) -> Int {
        if n <= 1 { return n }
        if n == 2 { return 1 }
        var array = [Int](repeating: 1, count: n)
        for i in 0 ..< array.count {
            if i % 2 == 0 {
                array[i] = 1
            } else {
                array[i] = 0
            }
        }
//        for round in 3 ... n {
//            for i in (round - 1) ..< n {
//                if  (i+1) % round == 0 {
//                    array[i] = array[i] == 1 ? 0 : 1
//                }
//            }
//        }
        
        //比上面的循环稍微省时一点，但还是超时
        for round in 3 ... n {
            let count = n / round
            for j in 1 ... count {
                array[round * j - 1] = array[round * j - 1] == 1 ? 0 : 1
            }
        }
        
        var result = 0
        for num in array {
            result += num
        }
        return result
    }
}
