//
//  LibrarySolution.swift
//  LXMLeetCode
//
//  Created by kook on 2018/8/8.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class LibrarySolution {
    
    /// 9 回文数
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        var one = [Int]()
        var two = [Int]()
        var x = x
        while x != 0 {
            let a = x % 10
            one.append(a)
            two.insert(a, at: 0)
            x = x / 10
        }
        return one == two
    }
    
    /// 6. Z字形变换
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows == 1 { return s }
        var array = [Character](s)
        let n = array.count
        var matrix = [[Character]]()
        for i in 0 ..< numRows {
            let a = [Character](repeating: "0", count: n)
            matrix.append(a)
        }
        
        var index = 0
        var i = 0
        var j = 0
        var isVertical = true
        while index < array.count {
            let current = array[index]
            index += 1
            matrix[i][j] = current
            if isVertical {
                i += 1
                if i == numRows {
                    i -= 2
                    j += 1
                    isVertical = false
                }
            } else {
                i -= 1
                j += 1
                if i < 0 {
                    i += 2
                    j -= 1
                    isVertical = true
                }
            }
        }
        array.removeAll()
        for i in 0 ..< numRows {
            for j in 0 ..< n {
                let a = matrix[i][j]
                if a != "0" {
                    array.append(a)
                }
            }
        }
        return String(array)
    }
    
    //27. 移除元素
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        guard nums.count > 0 else { return 0 }
        var i = 0
        var last = nums.count - 1
        while i <= last {
            if nums[i] == val {
                nums[i] = nums[last]
                nums[last] = 0
                last -= 1
            } else {
                i += 1
            }
        }
        return i
    }
    
    /// 367. 有效的完全平方数
    func isPerfectSquare(_ num: Int) -> Bool {
        if num == 1 { return true }
        var left = 0
        var right = num
        while left <= right {
            let mid = (left + right) / 2
            if num / mid == mid && num % mid == 0 {
                return true
            } else if num / mid < mid {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return false
    }
    
    /// 11. 盛最多水的容器
    func maxArea(_ height: [Int]) -> Int {
        var result = 0
        var left = 0
        var right = height.count - 1
        while left < right {
            let m = (right - left) * min(height[left], height[right])
            result = max(result, m)
            if height[left] <= height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        return result
    }
    
    /// 16. 最接近的三数之和 直接遍历肯定超时，我本来想到了思路，但是绝对值跟大于小于的关系没绕过来
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        var array = nums.sorted()
        var diff = Int.max
        var result = 0
        for i in 0 ..< array.count - 2 {
            let a = array[i]
            
            var j = i + 1
            var k = array.count - 1
            while j < k {
                let b = array[j]
                let c = array[k]
                let tempSum = a + b + c
                if abs(tempSum - target) < diff {
                    diff = abs(tempSum - target)
                    result = tempSum
                }
                if tempSum > target {
                    k -= 1
                } else if tempSum < target {
                    j += 1
                } else {
                    return result
                }
            }
        }
        return result
    }
    
    
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        
        var array = nums.sorted()
        var result = [[Int]]()
        guard nums.count >= 4 else { return result }
        
        for i in 0 ..< nums.count - 3 {
            for j in i + 1 ..< nums.count - 2 {
                var left = j + 1
                var right = nums.count - 1
                while left < right {
                    let sum = array[i] + array[j] + array[left] + array[right]
                    if sum == target {
                        let temp = [array[i], array[j], array[left], array[right]]
                        if !result.contains(temp) {
                            result.append(temp)
                        }
                        left += 1
                        right -= 1
                    } else if sum > target {
                        right -= 1
                    } else {
                        left += 1
                    }
                }
            }
        }
        
        return result
    }
    
    
    /// 35. 搜索插入位置
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else { return 0 }
        if target < nums[0] { return 0 }
        
        for i in 0 ..< nums.count {
            let current = nums[i]
            if current == target {
                return i
            } else if current > target {
                return i
            }
        }
        return nums.count
    }
    
    /// 39. 组合总和 ，这题还是有点晕，基本是蒙出来的
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        
        var result = [[Int]]()
        var array = candidates.sorted()
        
        func helper(array:[Int], start: Int, temp: [Int], sum: Int) {
            if sum == target {
                result.append(temp)
                return
            } else if sum > target {
                return
            } else {
                for i in start ..< array.count {
                    var temp = temp
                    temp.append(array[i])
                    helper(array: array, start: i, temp: temp, sum: sum + array[i])
                }
            }
            
        }
        helper(array: array, start: 0, temp: [Int](), sum: 0)
        return result
    }
    
    /// 40. 组合总和 II 完全抄的，没看懂
//    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
//        var sortNums = candidates.sorted()
//        var tmp = [Int]()  // current set for testing
//        var rlt = [[Int]]() // the result set
//
//        // subtrack a num from candidates to find the combination:
//        func backtrack(_ nums: inout [Int], _ tmp: inout [Int], _ start:Int, _ tg:Int, _ rlt:inout[[Int]]) {
//            if tg==0 { // find one and put into result;
//                rlt.append(tmp)
//                return
//            }
//            if start >= nums.count || nums[start] > tg { return } // go on condictions
//            for i in start...nums.count-1 {
//                if tg < nums[i] { return }
//                if i != start && nums[i]==nums[i-1] { continue } // skip the same num been used
//                tmp.append(nums[i])
//                backtrack(&nums, &tmp, i+1, tg-nums[i], &rlt)
//                tmp.removeLast()
//            }
//        }
//
//        backtrack(&sortNums, &tmp, 0, target, &rlt)
//        return rlt
//    }
    
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var array = candidates.sorted()
        var result = [[Int]]()
        
        func helper(start: Int, temp: [Int], sum: Int) {
            if sum == target {
                result.append(temp)
                return
            }
            if start >= array.count || sum > target {
                return
            }
            for i in start ..< array.count {
                if sum + array[i] > target { return }
                if i != start && array[i] == array[i - 1] { continue }//这一句是关键,一次递归取一个数放到temp里面，而一次for循环里的操作是平级的，也就是都是当第start个数来用，如果这时候有跟前一个数相等的，就直接跳过就行了。比如array是[1,1,1,2,3],那只需要分别取1，2，3为第一个数递归就行了，不能讲1取三次！
                var temp = temp
                temp.append(array[i])
                helper(start: i + 1, temp: temp, sum: sum + array[i])
            }
        }
        helper(start: 0, temp: [Int](), sum: 0)
        return result
    }
    
    /// 47 全排列 II  跟40有点像
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var array = nums.sorted()
        var n = nums.count
        var result = [[Int]]()
        func helper(remain: [Int], temp: [Int]) {
            if temp.count == n {
                result.append(temp)
            } else {
                for i in 0 ..< remain.count {
                    if 0 == i || remain[i] != remain[i - 1] {
                        var newRemain = remain
                        let current = newRemain.remove(at: i)
                        var newTemp = temp
                        newTemp.append(current)
                        helper(remain: newRemain, temp: newTemp)
                    }
                }
            }
        }
        helper(remain: array, temp: [Int]())
        return result
    }
    
    /// 58. 最后一个单词的长度 这么简单的题居然边界条件调了半天。。。
    func lengthOfLastWord(_ s: String) -> Int {
        guard s.count > 0 else { return 0 }
        let array = [Character](s)
        var i = array.count - 1
        while i >= 0 {
            if array[i] == " " {
                i -= 1
                if i < 0 {
                    return 0
                }
            } else {
                var j = i - 1
                while j >= 0 {
                    if array[j] == " " {
                        return i - j
                    } else {
                        j -= 1
                    }
                }
                return i - j
            }
        }
        return array.count
    }
    
    /// 59. 螺旋矩阵 II
    func generateMatrix(_ n: Int) -> [[Int]] {
        var result = [[Int]]()
        for _ in 0 ..< n {
            let temp = [Int](repeating: 0, count: n)
            result.append(temp)
        }
        
        var k = 0
        var i = 0
        var j = 0
        var current = 1
        
        while k <= (n - 1) / 2 {
            i = k
            for temp in k ..< n - k {
                result[i][temp] = current
                current += 1
            }
            if current > n * n {
                break
            }
            
            j = n - 1 - k
            for temp in k + 1 ..< n - k {
                result[temp][j] = current
                current += 1
            }
            if current > n * n {
                break
            }
            
            i = n - 1 - k
            for temp in (k ..< n - 1 - k).reversed() {
                result[i][temp] = current
                current += 1
            }
            if current > n * n {
                break
            }
            
            j = k
            for temp in (k + 1 ..< n - 1 - k).reversed() {
                result[temp][j] = current
                current += 1
            }
            if current > n * n {
                break
            }
            k += 1
        }
        return result
        
    }
    
    /// 60. 第k个排列 用全排列的方式做，超时了。。。
//    func getPermutation(_ n: Int, _ k: Int) -> String {
//        var array = [Int]()
//        for i in 1 ... n {
//            array.append(i)
//        }
//        var matrix = [[Int]]()
//        func helper(remain: [Int], temp: [Int]) {
//            if matrix.count >= k { return }
//            if temp.count == n {
//                matrix.append(temp)
//            }
//            for i in 0 ..< remain.count {
//                var newRemain = remain
//                var newTemp  = temp
//                let one = newRemain.remove(at: i)
//                newTemp.append(one)
//                helper(remain: newRemain, temp: newTemp)
//            }
//        }
//
//        helper(remain: array, temp: [Int]())
//        let temp = matrix.last!
//        var result = ""
//        for i in 0 ..< temp.count {
//            result += "\(temp[i])"
//        }
//        return result
//    }
    
    // 牛逼了，自己想出来的算法：首先，n！个全排列中，有分别以1-n为第一个数的 （n-1）！个全排列；
    // 所以要判断k大于几倍的 （n-1）！，如果是0倍，那说明就是以数组第一个数为开头的；如果大于i倍（n-1）！又小于i+1倍（n-1）！，则说明是以第i个数为开头的全排列；这时候把这个数放到结果中，对剩下的数组进行同样的判断
    
    func getPermutation(_ n: Int, _ k: Int) -> String {
        if n == 1 { return "1" }
        var array = [Int]()
        var dp = [Int](repeating: 1, count: n + 1)
        for i in 1 ... n {
            array.append(i)
            dp[i] = dp[i - 1] * i
        }
        
        var result = [Int]()
        var k = k
        while result.count < n {
            var i = 0 //i表示用数组的第几个数为开头
            while k > (i + 1) * dp[array.count - 1] {
                i += 1
            }
            k = k - i * dp[array.count - 1]
            let temp = array.remove(at: i)
            result.append(temp)
        }
        var s = ""
        for i in 0 ..< result.count {
            s += "\(result[i])"
        }
        return s
    }
    
    /// 63.不同路径 II, 别人提交的直接给障碍物那儿赋值0的方法应该是更好的，因为结果是0+x还是x嘛
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        let m = obstacleGrid.count
        if m == 0 { return 0 }
        let n = obstacleGrid[0].count
        if n == 0 { return 0 }
        var matrix = [[Int]]()
        for _ in 0 ..< m {
            let temp = [Int](repeating: 0, count: n)
            matrix.append(temp)
        }
        if obstacleGrid[0][0] == 1 { return 0 }
        
        for i in 0 ..< m {
            for j in 0 ..< n {
                if i == 0 && j == 0 {
                    matrix[0][0] = 1
                } else if i == 0 && j > 0 {
                    if obstacleGrid[i][j] == 1 {
                        matrix[i][j] = -1
                    } else {
                        matrix[i][j] = matrix[i][j - 1]
                    }
                } else if i > 0 && j == 0 {
                    if obstacleGrid[i][j] == 1 {
                        matrix[i][j] = -1
                    } else {
                        matrix[i][j] = matrix[i - 1][j]
                    }
                } else {
                    if obstacleGrid[i][j] == 1 {
                        matrix[i][j] = -1
                    } else if matrix[i][j - 1] == -1 && matrix[i - 1][j] == -1 {
                        matrix[i][j] = 0
                    } else if matrix[i][j - 1] == -1 {
                        matrix[i][j] = matrix[i - 1][j]
                    } else if matrix[i - 1][j] == -1 {
                        matrix[i][j] = matrix[i][j - 1]
                    } else {
                        matrix[i][j] = matrix[i][j - 1] + matrix[i - 1][j]
                    }
                }
            }
        }
        return matrix[m-1][n-1] == -1 ? 0 : matrix[m-1][n-1]
    }

    /// 64. 最小路径和
    func minPathSum(_ grid: [[Int]]) -> Int {
        let m = grid.count
        if m == 0 { return 0 }
        let n = grid[0].count
        if n == 0 { return 0 }
        var matrix = grid
        for i in 1 ..< m {
            matrix[i][0] = matrix[i - 1][0] + matrix[i][0]
        }
        for j in 1 ..< n {
            matrix[0][j] = matrix[0][j - 1] + matrix[0][j]
        }
        
        for i in 1 ..< m {
            for j in 1 ..< n {
                matrix[i][j] = min(matrix[i - 1][j], matrix[i][j - 1]) + matrix[i][j]
            }
        }
        return matrix[m - 1][n - 1]
    }
    
    /// 71. 简化路径
    func simplifyPath(_ path: String) -> String {
        guard path.count > 0 else { return path }
        let array = [Character](path)
        var result = [[Character]]()
        var temp: [Character] = ["/"]
        
        var i = 1
        while i < array.count {
            let c = array[i]
            if c != "/" {
                temp.append(c)
            } else {
                result.append(temp)
                temp = ["/"]
            }
            i += 1
        }
        result.append(temp)
        
        var j = 0
        var x = [String]()
        while j < result.count {
            let sub = String(result[j])
            if sub == "/." || sub == "/" {
                
            } else if sub == "/.." {
                _ = x.popLast()
            } else {
                x.append(sub)
            }
            j += 1
        }
        if x.count == 0 { return "/" }
        var a = ""
        for sub in x {
            a += sub
        }
        return a
    }
    
    /// 74. 搜索二维矩阵 见过的最复杂的边界条件问题
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let m = matrix.count
        if m == 0 { return false }
        let n = matrix[0].count
        if n == 0 { return false }
        var colum = [Int]()
        for array in matrix {
            colum.append(array[0])
        }
        
        var left = 0
        var right = colum.count - 1
        var row = 0
        while left <= right {
            // Prevent (left + right) overflow
            let mid = left + (right - left) / 2
            if colum[mid] == target {
                return true
            } else if colum[mid] > target {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        row = min(left, right)
        if row < 0 { return false }
        
        
        let array = matrix[row]
        if array.count == 1 {
            return array[0] == target
        }
        left = 0
        right = array.count - 1
        while left <= right {
            // Prevent (left + right) overflow
            let mid = left + (right - left) / 2
            if array[mid] == target {
                return true
            } else if array[mid] > target {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return false
        
    }
    
    /// 77.组合 超时了。。。
//    func combine(_ n: Int, _ k: Int) -> [[Int]] {
//        var array = [Int]()
//        for i in 1 ... n {
//            array.append(i)
//        }
//        var result = [[Int]]()
//
//        func helper(remain: [Int], temp: [Int]) {
//            if temp.count == k {
//                result.append(temp)
//            } else {
//                for i in 0 ..< remain.count {
//                    var newRemain = remain
//                    let a = newRemain.remove(at: i)
//                    if temp.count == 0 || a > temp.last! {
//                        var newTemp = temp
//                        newTemp.append(a)
//                        helper(remain: newRemain, temp: newTemp)
//                    }
//                }
//            }
//        }
//        helper(remain: array, temp: [Int]())
//        return result
//    }
    
    /// 77.组合 通过的答案
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var array = [Int]()
        for i in 1 ... n {
            array.append(i)
        }
        var result = [[Int]]()
        
        func helper(temp: [Int], start: Int) {
            if start > n {
                return
            }
            if temp.count == k {
                result.append(temp)
            } else {
                for i in start ..< array.count {
                    let current = array[i]
                    var newTemp = temp
                    newTemp.append(current)
                    helper(temp: newTemp, start: i + 1)
                }
            }
        }
        helper(temp: [Int](), start: 0)
        return result
    }
    
    /// 80.删除排序数组中的重复项 II
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 2 else { return nums.count }
        var index = 2
        var last1 = nums[0]
        var last2 = nums[1]
        
        for i in 2 ..< nums.count {
            let current = nums[i]
            if last1 == last2 && last2 == current {
                
            } else {
                nums[index] = current
                index += 1
                last1 = last2
                last2 = current
            }
        }
        return index
    }
    
    /// 83.删除排序链表中的重复元素
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard let head = head else { return nil }
        var last = head
        var current = head.next
        while current != nil {
            if current!.val == last.val {
                current = current?.next
            } else {
                last.next = current
                last = current!
                current = current?.next
            }
        }
        last.next = nil
        return head
    }
    
    /// 82.删除排序链表中的重复元素 II
    func deleteDuplicates2(_ head: ListNode?) -> ListNode? {
        if head?.next == nil {
            return head
        }
        
        let blank = ListNode(x: Int.min)
        blank.next = head
        
        var last = blank
        var start = head
        var current = start?.next
        
        while current != nil {
            if start!.val == current!.val {
                var temp = current?.next
                while temp != nil {
                    if temp!.val == start!.val {
                        temp = temp?.next
                    } else {
                        break
                    }
                }
                last.next = temp
                start = temp
                current = temp?.next
                
            } else {
                last = start!
                start = current
                current = current?.next
            }
        }
        return blank.next
        
    }
    
    /// 86. 分隔链表
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        var result: ListNode? = nil
        var big: ListNode? = nil
        var currentSmall: ListNode? = nil
        var currentBig: ListNode? = nil
        var current = head
        while current != nil {
            if current!.val < x {
                if result == nil {
                    result = current
                    currentSmall = current
                } else {
                    currentSmall?.next = current
                    currentSmall = current
                }
            } else {
                if big == nil {
                    big = current
                    currentBig = current
                } else {
                    currentBig?.next = current
                    currentBig = current
                }
            }
            current = current?.next
        }
        currentBig?.next = nil
        currentSmall?.next = big
        return result == nil ? big : result
    }
    
    /// 89. 格雷编码 用最笨的方法做的，我感觉还是有点意义的
    func grayCode(_ n: Int) -> [Int] {
        var matrix = [[Int]]()
        var temp = [Int](repeating: 0, count: n)
        matrix.append(temp)
        
        func helper(array: [Int]) -> [Int] {
            
            for i in (0 ..< array.count).reversed() {
                let current = array[i]
                var result = array
                result[i] = current == 0 ? 1 : 0
                if !matrix.contains(result) {
                    matrix.append(result)
                    return result
                }
            }
            return [Int]()
        }
        
        while temp.count != 0 {
            temp = helper(array: temp)
        }
        var result = [Int]()
        for array in matrix {
            var temp = 0
            for i in 0 ..< array.count {
                temp += array[i] * 1 << i
            }
            result.append(temp)
        }
        return result
        
    }
    
    /// 92. 反转链表 II
    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        if head == nil { return nil }
        var count = 1
        var current = head
        var last: ListNode? = nil //last表示已经反转好的部分链表的头结点
        var start: ListNode? = nil  //start表示开始反转的节点前一个节点
        var end: ListNode? = head     //end表示反转部分的最后一个节点
        while current != nil {
            if count < m {
                start = current
                current = current?.next
                end = current
            } else if count < n + 1 {
                let next = current?.next
                current?.next = last
                last = current
                current = next
            } else {
                break
            }
            count += 1
        }
        end?.next = current
        start?.next = last
        if m == 1 {
            return last
        } else {
            return head
        }
    }
    
    
    /// 100. 相同的树
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        } else if p == nil || q == nil {
            return false
        } else {
            if p!.val == q!.val {
                return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
            } else {
                return false
            }
        }
    }
}
