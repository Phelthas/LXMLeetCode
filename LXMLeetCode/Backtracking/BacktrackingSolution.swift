//
//  BacktrackingSolution.swift
//  LXMLeetCode
//
//  Created by kook on 2018/7/9.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class BacktrackingSolution {
    
    /// 17. 电话号码的字母组合
    func letterCombinations(_ digits: String) -> [String] {
        let dict: [Character : [String]] = [
            "2" : ["a", "b", "c"],
            "3" : ["d", "e", "f"],
            "4" : ["g", "h", "i"],
            "5" : ["j", "k", "l"],
            "6" : ["m", "n", "o"],
            "7" : ["p", "q", "r", "s"],
            "8" : ["t", "u", "v"],
            "9" : ["w", "x", "y", "z"]
        ]
        
        func test(_ one: [String], _ two: [String]) -> [String] {
            if one.count == 0 {
                return two
            }
            if two.count == 0 {
                return one
            }
            var result = [String]()
            for temp1 in one {
                for temp2 in two {
                    result.append(temp1 + temp2)
                }
            }
            return result
        }
        
        var result = [String]()
        for item in digits {
            let array = dict[item]!
            result = test(result, array)
        }
        return result
    }
    
    
    /// 22. 括号生成,这是看别人博客写的，这个思路还是需要好好理解一下，深度优先的回溯
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        
        func generateDFS(_ left: Int, _ right: Int, _ s: String) {
            if left == 0 && right == 0 {
                result.append(s)
            }
            if left > 0 {
                generateDFS(left - 1, right, s + "(")
            }
            if right > 0 && left < right {
                generateDFS(left, right - 1, s + ")")
            }
        }
        
        generateDFS(n, n, "")
        return result
        
    }
    
    /// 46，全排列,自己大致想到的思路，但是完全写不出来，这也是看比人博客写的
//    func permute(_ nums: [Int]) -> [[Int]] {
//        var result = [[Int]]()
//
//        // i 表示从第几个数开始全排列
//        func dfs(_ array: [Int], _ i: Int) {
//            var array = array
//            if i == array.count {
//                var temp = [Int]()
//                for c in array {
//                    temp.append(c)
//                }
//                result.append(temp)
//            }
//            for j in i ..< array.count {
//                array.swapAt(i, j)
//                dfs(array, i + 1)
//                array.swapAt(i, j)
//            }
//        }
//
//        dfs(nums, 0)
//        return result
//    }
    
    /// 46，全排列,递归算法，第一次往链表添加一个元素，有n中可能，然后将剩下的元素再添加一个元素到链表中，有n-1种可能，以此类推，直至链表中的元素大小等于数组大小。
//    func permute(_ nums: [Int]) -> [[Int]] {
//        var result = [[Int]]()
//        let n = nums.count
//
//        func test(_ array: [Int], _ sub: [Int]) {
//            if sub.count == n {
//                result.append(sub)
//                return
//            }
//            for i in 0 ..< n {
//                if sub.contains(array[i]) == false {
//                    var sub = sub
//                    sub.append(array[i])
//                    test(nums, sub)
//                }
//            }
//        }
//        test(nums, [Int]())
//        return result
//    }
    
    
    /// 46，全排列，自己的思路实现
    func permute(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        let n = nums.count
        
        func test(_ current: [Int], _ remain: [Int]) {
            if current.count == n {
                result.append(current)
                return
            }
            for i in 0 ..< remain.count {
                //注意:这里每次循环都要重新生成一份local遍历的拷贝，不然就相当于一边循环一边修改数组了，铁对会越界
                var localCurrent = current
                var localRemain = remain
                let one = localRemain.remove(at: i)
                localCurrent.append(one)
                test(localCurrent, localRemain)
            }
        }
        test([Int](), nums)
        return result
    }
    
    /// 78 子集，关键思路是：递归，数组只有一个元素时，子集就是自己和空集，多了一个元素时，就是原来的全部子集+全部子集配新元素生成的子集
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]()]
        guard nums.count > 0 else { return result }
        
        func test(_ array: [[Int]], _ current: Int) -> [[Int]] {
            var result = array
            for temp in array {
                var a = temp
                a.append(current)
                result.append(a)
            }
            return result
        }
        
        for num in nums {
            result = test(result, num)
        }
        return result
    }

}
