//
//  LibrarySolution3.swift
//  LXMLeetCode
//
//  Created by kook on 2018/11/9.
//  Copyright © 2018 duowan. All rights reserved.
//

import Foundation

extension LibrarySolution {
    
    /// 205. 同构字符串
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        let arrayS = [Character](s)
        let arrayT = [Character](t)
        var dict1 = [Character : Character]()
        var dict2 = [Character : Character]()
        for i in 0 ..< arrayS.count {
            let tempS = arrayS[i]
            let tempT = arrayT[i]
            if let value = dict1[tempS] {
                if value != tempT {
                    return false
                }
            } else if let value = dict2[tempT] {
                if value != tempS {
                    return false
                }
            } else {
                dict1[tempS] = tempT
                dict2[tempT] = tempS
            }
        }
        return true
    }
    
    /// 213. 打家劫舍 II
    func rob(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 0 { return 0 }
        if n == 1 { return nums[0] }
        if n == 2 { return max(nums[0], nums[1]) }
        
        var dp1 = [Int](repeating: 0, count: nums.count + 1) // 不考虑首尾相连，且偷第一个的情况
        var dp2 = [Int](repeating: 0, count: nums.count + 1) // 不考虑首尾相连，且不偷第一个的情况
        
        var result = [Int](repeating: 0, count: nums.count + 1)
        
        dp1[0] = nums[0]
        dp1[1] = nums[0]
        for i in 2 ..< nums.count {
            dp1[i] = max(dp1[i-1], dp1[i-2] + nums[i])
        }
        
        dp2[1] = nums[1]
        for i in 2 ..< nums.count {
            dp2[i] = max(dp2[i-1], dp2[i-2] + nums[i])
        }
        
        result[0] = nums[0]
        for i in 1 ..< nums.count {
            result[i] = max(dp1[i-1], dp2[i])
        }
        return result[nums.count - 1]
        
    }
    
    /// 216. 组合总和 III
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        var array = [Int]()
        for i in 1 ... 9 {
            array.append(i)
        }
        
        var result = [[Int]]()
        
        func helper(remain: [Int], current: [Int], sum: Int) {
            var newRemain = remain
            while newRemain.count > 0 {
                let temp = newRemain.removeFirst()
                var newCurrent = current
                newCurrent.append(temp)
                let newSum = sum + temp
                if newSum == n && newCurrent.count == k {
                    result.append(newCurrent)
                } else if newSum > n {
                    continue
                } else {
                    helper(remain: newRemain, current: newCurrent, sum: newSum)
                }
            }
        }
        
        helper(remain: array, current: [Int](), sum: 0)
        return result
    }
    
    /// 219. 存在重复元素 II
    /// 超时的算法
    // func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    //     if k == 0 { return false }
    //     for i in 0 ..< nums.count {
    //         for j in i + 1 ... i + k {
    //             if j < nums.count {
    //                 if nums[i] == nums[j] {
    //                     return true
    //                 }
    //             } else {
    //                 break
    //             }
    //         }
    //     }
    //     return false
    // }
    
    /// 自己想的算法
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        if k == 0 { return false }
        var dict = [Int : [Int]]()
        for i in 0 ..< nums.count {
            let num = nums[i]
            if var array = dict[num] {
                array.append(i)
                dict[num] = array
            } else {
                dict[num] = [i]
            }
        }
        for array in dict.values {
            for i in 0 ..< array.count - 1 {
                if array[i + 1] - array[i] <= k {
                    return true
                }
            }
        }
        return false
    }
    
    // 别人提交的最快的算法
    // func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    //     var set: Set<Int> = []
    //     for i in 0..<nums.count {
    //         if i > k {
    //             set.remove(nums[i-k-1])//移掉无效数据
    //         }
    //         if !set.insert(nums[i]).inserted {
    //             return true
    //         }
    //     }
    //     return false
    // }
    
    /// 220. 存在重复元素 III 时间复杂度O(kn)都超时，得再研究下了
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        if k == 0 { return false }
        var set = Set<Int>()
        for i in 0 ..< nums.count {
            let current = nums[i]
            if i > k {
                set.remove(nums[i - k - 1])
            }
            for temp in set {
                if abs(temp - current) <= t {
                    return true
                }
            }
            set.insert(current)
        }
        
        return false
    }
    
    /// 221. 最大正方形
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        let m = matrix.count
        if m == 0 { return 0 }
        let n = matrix[0].count
        if n == 0 { return 0 }
        var result = 0
        
        func isAll1(i: Int, j: Int, count: Int) -> Bool {
            for a in i ..< i + count {
                for b in j ..< j + count {
                    if matrix[a][b] == "0" {
                        return false
                    }
                }
            }
            return true
        }
        
        func helper(i: Int, j: Int) -> Int {
            if matrix[i][j] == "0" {
                return result
            }
            if result == 0 {
                result = 1
            }
            var temp = result
            let maxL = min(m - i, n - j)
            if result >= maxL {
                return result
            }
            for k in result + 1 ... maxL {
                if result >= maxL {
                    return result
                }
                if isAll1(i: i, j: j, count: k) {
                    temp += 1
                }
            }
            return temp
        }
        
        for i in 0 ..< m {
            for j in 0 ..< n {
                result = helper(i: i, j: j)
            }
        }
        return result * result
    }
}
