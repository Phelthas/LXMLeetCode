//
//  DynamicProgrammingSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/6/9.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation


class DynamicProgrammingSolution {
    
    // 爬楼梯，递归算法，会超时，因为有很多重复计算
    // func climbStairs(_ n: Int) -> Int {
    //     if n == 1 {
    //         return 1
    //     }
    //     if n == 2 {
    //         return 2
    //     }
    //     return climbStairs(n - 1) + climbStairs(n - 2)
    // }
    
//    爬楼梯，用数组保存的方法
    func climbStairs(_ n: Int) -> Int {
        if n <= 2 {
            return n
        }
        var array: [Int] = [1, 2]
        for i in 2 ... n - 1 {
            let temp = array[i - 1] + array[i - 2]
            array.append(temp)
        }
        return array[n - 1]
    }
    
    
    /// 买卖股票的最佳时机，自己想出来的算法，比别人提交的算法耗时了一点
    /// 看了一下别人提交的算法，大致思路是：遍历一遍数组，找到当前的数之前的最小值，那当前的数-最小值就是目前的最大收益，把最大值保存起来跟下一次的遍历比较，那遍历一遍数据就行了
    /// 而我的想法是找到当前数之后的最大值，其实差不多，但这样就需要遍历两次，时间复杂度多了一倍
//    func maxProfit(_ prices: [Int]) -> Int {
//        let n = prices.count
//        guard n > 1 else { return 0 }
//        var maxArray = [Int]()
//        var lastMax = 0
//        for i in (1 ... n - 1).reversed() {
//            if prices[i] > lastMax {
//                lastMax = prices[i]
//            }
//            maxArray.append(lastMax)
//        }
//        var result = 0
//        for i in (0 ... n - 2) {
//            let price = prices[i]
//            let lastMax = maxArray[n - 1 - 1 - i]
//            if price < lastMax {
//                let temp = lastMax - price
//                if temp > result {
//                    result = temp
//                }
//            }
//        }
//        return result
//    }
    
    func maxProfit(_ prices: [Int]) -> Int {
        let n = prices.count
        guard n > 1 else { return 0 }
        var result = 0
        var minPrice = prices[0]
        for i in 1 ... n - 1 {
            let current = prices[i]
            result = max(current - minPrice, result)
            minPrice = min(current, minPrice)
        }
        return result
    }
    
    
    /// 最大子序和 按字面意思的解法,穷举法
//    func maxSubArray(_ nums: [Int]) -> Int {
//        let n = nums.count
//        guard n > 0 else { return 0 }
//        var result = Int.min
//        var maxSum = 0
//
//        for k in 0 ..< n {
//            maxSum = 0
//            for i in k ..< n {
//                let current = nums[i]
//                maxSum = maxSum + current
//                if maxSum > result {
//                    result = maxSum
//                }
//            }
//        }
//        return result
//    }
    
    
    /// 看网上思路的O(n)解法，最优起点发，这没有数学基础是想不出来的。。。
    func maxSubArray(_ nums: [Int]) -> Int {
        var result = Int.min
        var thisSum = 0
        for i in 0 ..< nums.count {
            thisSum += nums[i]
            if thisSum > result {
                result = thisSum
            }
            if thisSum < 0 {
                thisSum = 0
            }
        }
        return result
    }
    
}
