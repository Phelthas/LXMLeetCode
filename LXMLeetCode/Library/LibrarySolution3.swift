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
}
