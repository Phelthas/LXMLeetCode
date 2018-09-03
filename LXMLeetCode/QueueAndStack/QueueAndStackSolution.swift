//
//  QueueAndStackSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/8/27.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class QueueAndStackSolution {
    
    /// 752. 打开转盘锁 如果直接用字符串character强转就会超时
    func openLock(_ deadends: [String], _ target: String) -> Int {
        var result = 0
        var queue = ["0000"]
        var set = Set<String>(deadends)
        if set.contains("0000") { return -1 }
        
        func plusCharacter(_ c: Character) -> Character {
            switch c {
            case "0": return "1"
            case "1": return "2"
            case "2": return "3"
            case "3": return "4"
            case "4": return "5"
            case "5": return "6"
            case "6": return "7"
            case "7": return "8"
            case "8": return "9"
            default: return "0"
            }
        }
        func minusCharacter(_ c: Character) -> Character {
            switch c {
            case "1": return "0"
            case "2": return "1"
            case "3": return "2"
            case "4": return "3"
            case "5": return "4"
            case "6": return "5"
            case "7": return "6"
            case "8": return "7"
            case "9": return "8"
            default: return "9"
            }
        }
        
        func helper(_ s: String) {
            set.insert(s)
            let array = [Character](s)
            for i in 0 ..< 4 {
                var temp = array
                let c = temp[i]
                let c1 = plusCharacter(c)
                temp[i] = c1
                let s1 = String(temp)
                if !set.contains(s1) {
                    set.insert(s1)
                    queue.append(s1)
                }
                
                let c2 = minusCharacter(c)
                temp[i] = c2
                let s2 = String(temp)
                if !set.contains(s2) {
                    set.insert(s2)
                    queue.append(s2)
                }
                
            }
            
        }
        
        var setpQueue = [String]()
        while queue.count != 0 {
            setpQueue = queue
            queue.removeAll()
            for i in 0 ..< setpQueue.count {
                let current = setpQueue[i]
                if current == target {
                    return result
                }
                helper(current)
            }
            result += 1
            
        }
        return -1
    }
    
    
    
    /// 279 完全平方数, 贪心算法在这里是不合适的(比如12)，这里是看网上的动态规划算法
    /// 如果一个数能写成i + j * j 的形式，那 dp[i] + 1 就是完全平方数的一种情况之一，至于是不是个数最少的，还要看dp[i + j * j]是不是之前已经算出来了，可以更简单的得到，所以这两个去min即可
    func numSquares(_ n: Int) -> Int {
        var dp = [Int](repeating: Int.max, count: n + 1)
        dp[0] = 0
        for i in 0 ... n {
            var j = 1
            while i + j * j <= n {
                dp[i + j * j] = min(dp[i + j * j], dp[i] + 1)
                j += 1
            }
        }
        return dp[n]
    }
    
//    /// 739 每日温度 首先想到的算法，超时了
//    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
//        var result = [Int]()
//        guard temperatures.count > 0 else { return result }
//        if temperatures.count == 1 { return [0] }
//        for i in 0 ..< temperatures.count {
//            let current = temperatures[i]
//            var isExist = false
//            for j in i + 1 ..< temperatures.count {
//                if temperatures[j] > current {
//                    result.append(j - i)
//                    isExist = true
//                    break
//                }
//            }
//            if isExist == false {
//                result.append(0)
//            }
//        }
//
//        return result
//    }
    
     /// 739 每日温度 网上看的递减栈的算法，是个思路，得好好理解下
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        var result = [Int](repeating: 0, count: temperatures.count)
        guard temperatures.count > 0 else { return result }
        if temperatures.count == 1 { return [0] }
        var stack = [(index: Int, value: Int)]()
        for i in 0 ..< temperatures.count {
            let current = temperatures[i]
            if stack.count == 0 {
                stack.append((i, current))
            } else {
                var last = stack.last!
                if current > last.value {
                    while stack.count > 0 {
                        last = stack.last!
                        if current > last.value {
                            last = stack.removeLast()
                            result[last.index] = i - last.index
                        } else {
                            break
                        }
                    }
                    stack.append((i, current))
                } else {
                    stack.append((i, current))
                }
            }
        }
        return result
    }
    
    ///494 目标和  直接dfs居然还超时。。。
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        var result = 0
        
        func dfs(_ nums: [Int], sum: Int, index: Int) {
            if index == nums.count {
                if sum == S {
                    result += 1
                }
            } else {
                let a = nums[index]
                dfs(nums, sum: sum + a, index: index + 1)
                dfs(nums, sum: sum - a, index: index + 1)
            }
        }
        dfs(nums, sum: 0, index: 0)
        return result
    }
    
    /// 394. Decode String
    func decodeString(_ s: String) -> String {
        guard s.count > 0 else { return "" }
        var array = [Character](s)
        var stack = [Character]()
        for i in 0 ..< array.count {
            let current = array[i]
            if current != "]" {
                stack.append(current)
            } else {
                var temp = [Character]()
                while stack.count > 0 && stack.last! != "[" {
                    temp.insert(stack.removeLast(), at: 0)
                }
                stack.removeLast()
                var num = ""
                while stack.count > 0 && (stack.last! >= "0" && stack.last! <= "9") {
                    num = String(stack.removeLast()) + num
                }
                for _ in 0 ..< Int(num)! {
                    stack.append(contentsOf: temp)
                }
            }
        }
        return String(stack)
    }
    
    /// 733. Flood Fill
    func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
        var matrix = image
        let m = image.count
        if m == 0 {
            return matrix
        }
        let n = image[0].count
        if n == 0 {
            return matrix
        }
        
        func helper(i: Int, j: Int, _ newColor: Int, _ oldColor: Int) {
            let current = matrix[i][j]
            if current == newColor {
                return
            }
            if current != oldColor {
                return
            }
            matrix[i][j] = newColor
            if i > 0 {
                helper(i: i - 1, j: j, newColor, oldColor)
            }
            if i < m - 1 {
                helper(i: i + 1, j: j, newColor, oldColor)
            }
            if j > 0 {
                helper(i: i, j: j - 1, newColor, oldColor)
            }
            if j < n - 1 {
                helper(i: i, j: j + 1, newColor, oldColor)
            }
        }
        let target = matrix[sr][sc]
        if target == newColor {
            return image
        } else {
            helper(i: sr, j: sc, newColor, target)
        }
        
        return matrix
    }
    
    /// 542. 01 矩阵 直接dfs居然又超时
    func updateMatrix(_ matrix: [[Int]]) -> [[Int]] {
        let m = matrix.count
        if m == 0 { return matrix }
        let n = matrix[0].count
        if n == 0 { return matrix }
        
        var result = matrix
        var visited = matrix
        
        func helper(i: Int, j: Int, length: Int, visited: [[Int]]) -> Int {
            let current = matrix[i][j]
            var visited = visited
            if current == 0 {
                return length
            }
            if visited[i][j] == 2 {
                return Int.max
            }
            visited[i][j] = 2
            var temp = Int.max
            if i > 0 {
                temp = min(temp, helper(i: i - 1, j: j, length: length + 1, visited: visited))
            }
            if i < m - 1 {
                temp = min(temp, helper(i: i + 1, j: j, length: length + 1, visited: visited))
            }
            if j > 0 {
                temp = min(temp, helper(i: i, j: j - 1, length: length + 1, visited: visited))
            }
            if j < n - 1 {
                temp = min(temp, helper(i: i, j: j + 1, length: length + 1, visited: visited))
            }
            return temp
        }
        for i in 0 ..< m {
            for j in 0 ..< n {
                result[i][j] = helper(i: i, j: j, length: 0, visited: visited)
            }
        }
        return result
    }
}
