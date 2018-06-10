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
    func maxProfit(_ prices: [Int]) -> Int {
        var n = prices.count
        guard n > 1 else { return 0 }
        var maxArray = [Int]()
        var lastMax = 0
        for i in (1 ... n - 1).reversed() {
            if prices[i] > lastMax {
                lastMax = prices[i]
            }
            maxArray.append(lastMax)
        }
        var result = 0
        for i in (0 ... n - 2) {
            let price = prices[i]
            let lastMax = maxArray[n - 1 - 1 - i]
            if price < lastMax {
                let temp = lastMax - price
                if temp > result {
                    result = temp
                }
            }
        }
        return result
    }
    
}
