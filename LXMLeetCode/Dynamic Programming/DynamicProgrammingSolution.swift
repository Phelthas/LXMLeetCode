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
    
    
    /// 打家劫舍，这个算法超时了。。。核心思想是：抢第一个还是第二个会导致后面选择不一样，所以要选第一个加其后续最大值，或者第二个加其后续最大值；不可能选第三个，因为选第三个肯定不如选第一个加第三个。
//    func rob(_ nums: [Int]) -> Int {
//        let n = nums.count
//        func rob(_ nums: [Int], start: Int) -> Int {
//            if n - start <= 0 {
//                return 0
//            }
//            if n - start == 1 {
//                return nums[start]
//            }
//            if n - start == 2 {
//                return max(nums[start], nums[start + 1])
//            }
//            let one = nums[start] + rob(nums, start: start + 2)
//            let two = nums[start + 1] + rob(nums, start: start + 3)
//            return max(one, two)
//        }
//
//        return rob(nums, start: 0)
//    }

    
    /// 看了看别人博客，其实上面的思路可以优化一下，我是最后才比较，其实每一步都可以比较一次，设f(i)是到第i家时的最大值，当前最大值只有两种情况，要么是算上当前值时取到最大值（f(i - 2) + nums(i)），要么不算当前值时取最大值（f(i - 1)），所以 f(i) = max(f(i - 2) + nums(i), f(i - 1))
    // 这个写法也是超时的，因为递归有很多重复运算
//    func rob(_ nums: [Int]) -> Int {
//        let n = nums.count
//        if n == 0 { return 0 }
//        if n == 1 { return nums[0] }
//
//        func total(nums: [Int], endIndex: Int) -> Int {
//            if endIndex <= 0 {
//              return 0
//            } else if endIndex == 0 {
//                return nums[0]
//            } else if endIndex == 1 {
//                return max(nums[0], nums[0])
//            } else {
//                return max(total(nums: nums, endIndex: endIndex - 1), nums[endIndex] + total(nums: nums, endIndex: endIndex - 2))
//            }
//        }
//        return total(nums: nums, endIndex: n - 1)
//    }
    
    func rob(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 0 { return 0 }
        if n == 1 { return nums[0] }
        
        var result = 0
        var last = 0
        for i in 0 ..< n {
            let temp = result
            result = max(last + nums[i], result)
            last = temp
        }
        return result
    }
    
    //别人提交的比较好理解的算法，用一个数组保存递归结果
//    func rob(_ nums: [Int]) -> Int {
//        if nums.count == 0 {
//            return 0
//        }
//
//        if nums.count == 1 {
//            return nums.first!
//        }
//
//        if nums.count == 2 {
//            return max(nums[0], nums[1])
//        }
//
//        var dp : [Int] = [Int](repeating: 0, count: nums.count)
//        dp[0] = nums[0]
//        dp[1] = max(nums[0], nums[1])
//
//        for i in 2..<nums.count {
//            dp[i] = max(nums[i] + dp[i - 2], dp[i - 1])
//        }
//
//        return dp[nums.count - 1]
//    }
    
    
}


extension DynamicProgrammingSolution {
    
//    /// 45，跳跃游戏， 自己想的算法，超时了。。。这是遍历所有可能。。。
//    func canJump(_ nums: [Int]) -> Bool {
//        guard nums.count > 0 else { return true }
//        let n = nums.count
//
//        func helper(start: Int) -> Bool {
//            if start == n - 1 {
//                return true
//            }
//            if start > n - 1{
//                return false
//            } else {
//                let target = nums[start]
//                if target <= 0 {
//                    return false
//                }
//                var result = false
//                for i in 1 ... target {
//                    result = result || helper(start: start + i)
//                }
//                return result
//            }
//        }
//        return helper(start: 0)
//
//    }
    
    /// 45，跳跃游戏， 看别人博客写的，贪心算法
    func canJump(_ nums: [Int]) -> Bool {
        guard nums.count > 0 else { return true }
        var reach = 0
        for i in 0 ..< nums.count {
            if reach >= i && reach < nums.count - 1 {
                reach = max(reach, i + nums[i])
            } else {
                break
            }
        }
        return reach >= nums.count - 1
    }
    
    /// 62. 不同路径   自己想的算法，又是超时。。。
//    func uniquePaths(_ m: Int, _ n: Int) -> Int {
//        guard m > 0 else { return 0 }
//        guard n > 0 else { return 0 }
//        var result = [(0, 0)]
//        var tempArray = [(Int, Int)]()
//        while true {
//            let one = result.first!
//            if one.0 == m - 1 && one.1 == n - 1 {
//                break
//            }
//            tempArray.removeAll()
//            for last in result {
//                if last.0 < m - 1 {
//                    tempArray.append((last.0 + 1, last.1))
//                }
//                if last.1 < n - 1 {
//                    tempArray.append((last.0, last.1 + 1))
//                }
//            }
//            result = tempArray
//        }
//        return result.count
//    }
    
    /// 62. 不同路径  终于有个自己想出来的跟答案一样的算法
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var matrix = [[Int]]()
        for i in 0 ..< m {
            for j in 0 ..< n {
                if i == 0 && j == 0 {
                    matrix[i][j] = 1
                } else if i == 0 && j > 0 {
                    matrix[i][j] = matrix[i][j - 1]
                } else if j == 0 && i > 0 {
                    matrix[i][j] = matrix[i - 1][j]
                } else {
                    matrix[i][j] = matrix[i - 1][j] + matrix[i][j - 1]
                }
            }
        }
        return matrix[m - 1][n - 1]
        
    }
    
    /// 322. 零钱兑换 这个有点难，核心思路是找到dp[i]的递推关系
    /// 这里 设dp[i]为兑换目标i最少的硬币数, 则 dp[i]应该是把所有coin都替换一次后最小的那个
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        var dp = [Int](repeating: Int(Int32.max), count: amount + 1)
        dp[0] = 0
        for i in 0 ..< amount {
            for j in 0 ..< coins.count {
                if i - coins[j] >= 0 {
                    dp[i] = min(dp[i], dp[i - coins[j]] + 1)
                }
            }
        }
        return dp[amount] == Int(Int32.max) ? -1 : dp[amount]
    }
    
    /// 300. 最长上升子序列, 这个题完全没看懂。。。抄了一下别人的答案
    /*
     设长度为N的数组为{a0，a1, a2, ...an-1)，则假定以aj结尾的数组序列的最长递增子序列长度为L(j)，则L(j)={ max(L(i))+1, i<j且a[i]<a[j] }。也就是说，我们需要遍历在j之前的所有位置i(从0到j-1)，找出满足条件a[i]<a[j]的L(i)，求出max(L(i))+1即为L(j)的值。最后，我们遍历所有的L(j)（从0到N-1），找出最大值即为最大递增子序列。时间复杂度为O(N^2)。
     */
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard nums.count > 1 else { return nums.count }
        let n = nums.count
        var longest = [Int](repeating: 1, count: n)
        for j in 1 ..< n {
            for i in 0 ..< j {
                if nums[j] > nums[i] && longest[j] < longest[i] + 1 {//注意longest[j]<longest[i]+1这个条件，不能省略。
                    longest[j] = longest[i] + 1 //计算以arr[j]结尾的序列的最长递增子序列长度
                }
            }
        }
        
        return longest.max() ?? 1
    }
}
