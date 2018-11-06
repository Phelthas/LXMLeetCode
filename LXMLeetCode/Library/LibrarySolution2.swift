//
//  LibrarySolution2.swift
//  LXMLeetCode
//
//  Created by kook on 2018/10/20.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

extension LibrarySolution {
    
    /// 107. 二叉树的层次遍历 II
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard let root = root else { return result }
        var arrayOne = [TreeNode]()
        arrayOne.append(root)
        var arrayTwo = [TreeNode]()
        while arrayOne.count > 0 {
            var temp = [Int]()
            for node in arrayOne {
                temp.append(node.val)
                if let left = node.left {
                    arrayTwo.append(left)
                }
                if let right = node.right {
                    arrayTwo.append(right)
                }
            }
            result.append(temp)
            arrayOne = arrayTwo
            arrayTwo.removeAll()
        }
        return result.reversed()
    }
    
    /// 110. 平衡二叉树的递归写法
    func isBalanced(_ root: TreeNode?) -> Bool {
        
        func heightOf(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            return max(1 + heightOf(root.left), 1 + heightOf(root.right))
        }
        
        guard let root = root else { return true }
        if root.left == nil && root.right == nil {
            return true
        } else {
            let leftHeight = heightOf(root.left)
            let rightHeight = heightOf(root.right)
            if abs(leftHeight - rightHeight) > 1 {
                return false
            }
            return isBalanced(root.left) && isBalanced(root.right)
        }
    }
    
    /// 111. 二叉树的最小深度
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        func depthOf(node: TreeNode?, currentDepth: Int) -> Int {
            guard let node = node else { return currentDepth }
            let result = currentDepth + 1
            if node.left == nil && node.right == nil {
                return result
            } else if node.left == nil {
                return depthOf(node: node.right, currentDepth: result)
            } else if node.right == nil {
                return depthOf(node: node.left, currentDepth: result)
            } else {
                return min(depthOf(node: node.left, currentDepth: result), depthOf(node: node.right, currentDepth: result))
            }
            
        }
        
        return depthOf(node: root, currentDepth: 0)
        
    }
    
    /// 113.路径总和 II 
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        var result = [[Int]]()
        guard let root = root else { return result }
        
        func traverse(node: TreeNode, total: Int, array:[Int]) {
            let temp = total + node.val
            var array = array
            array.append(node.val)
            
            if node.left == nil && node.right == nil && temp == sum {
                result.append(array)
            } else {
                if let left = node.left {
                    traverse(node: left, total: temp, array: array)
                }
                if let right = node.right {
                    traverse(node: right, total: temp, array: array)
                }
            }
        }
        
        traverse(node: root, total: 0, array: [Int]())
        return result
    }
    
    /// 114. 二叉树展开为链表
    func flatten(_ root: TreeNode?) {
        
        func helper(_ node: TreeNode?) -> TreeNode? {
            guard let node = node else { return nil }
            if node.left == nil && node.right == nil {
                return node
            } else if node.left == nil {
                node.right = helper(node.right)
            } else if node.right == nil {
                node.right = helper(node.left)
                node.left = nil
            } else {
                let tempRight = helper(node.right)
                let tempLeft = helper(node.left)
                var last = tempLeft
                while last?.right != nil {
                    last = last?.right
                }
                node.left = nil
                node.right = tempLeft
                last?.right = tempRight
            }
            return node
        }
        
        helper(root)
    }
    
    /// 120.三角形最小路径和, 超时的算法
//    func minimumTotal(_ triangle: [[Int]]) -> Int {
//        let m = triangle.count
//        if m == 0 { return 0 }
//        var result = Int.max
//
//        func helper(row: Int, index: Int, sum: Int) {
//            let temp = sum + triangle[row][index]
//            if row == m - 1 {
//                result = min(result, temp)
//            } else {
//                helper(row: row + 1, index: index, sum: temp)
//                helper(row: row + 1, index: index + 1, sum: temp)
//            }
//        }
//        helper(row: 0, index: 0, sum: 0)
//        return result
//    }
    
    /// 120.三角形最小路径和, 动态规划的算法，O(n) 的方法
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let m = triangle.count
        if m == 0 { return 0 }
        if m == 1 { return triangle[0][0] }
        var result = triangle //设result[i][j]是到ij的最小路径和
        
        for i in 1 ..< m {
            for j in 0 ... i {
                if j == 0 {
                    result[i][j] = triangle[i][j] + result[i - 1][j]
                }
                else if j == i {
                    result[i][j] = triangle[i][j] + result[i - 1][j - 1]
                }
                else {
                    result[i][j] = triangle[i][j] + min(result[i - 1][j], result[i - 1][j - 1])
                }
            }
        }
        return result[m - 1].min() ?? 0
    }
    
    /// 120.三角形最小路径和，O(n) 的方法抄别人的代码，没完全弄懂
//    func minimumTotal(_ triangle: [[Int]]) -> Int {
//        var dps = Array(repeating: 0, count: triangle.count + 1)
//        for row in (0..<triangle.count).reversed() {
//            for column in 0..<triangle[row].count {
//                dps[column] = min(dps[column], dps[column + 1]) + triangle[row][column]
//            }
//        }
//
//        return dps[0]
//    }

    /// 129. 求根到叶子节点数字之和
    func sumNumbers(_ root: TreeNode?) -> Int {
        var array = [String]()
        guard let root = root else { return 0 }
        
        func helper(_ node: TreeNode, _ temp: String) {
            let temp = temp + "\(node.val)"
            if node.left == nil && node.right == nil {
                array.append(temp)
            } else {
                if let left = node.left {
                    helper(left, temp)
                }
                if let right = node.right {
                    helper(right, temp)
                }
            }
        }
        
        helper(root, "")
        return array.reduce(0, {
            return $0 + Int($1)!
        })
        
    }
    
    /// 130.被围绕的区域 提交显示 运行错误，playground调试没问题
    func solve(_ board: inout [[Character]]) {
        let m = board.count
        if m <= 2 { return }
        let n = board[0].count
        if n <= 2 { return }
        
        func helper(i: Int, j: Int) -> Bool {
            let a = board[i][j]
            if a == "X" { return true }
            if a == "O" {
                if (i == 0 || i == m - 1 || j == 0 || j == n - 1) {
                    return false
                }
                // let top = helper(i: i - 1, j: j)
                // let bottom = helper(i: i + 1, j: j)
                // let left = helper(i: i, j: j - 1)
                // let right = helper(i: i, j: j + 1)
                return helper(i: i - 1, j: j) && helper(i: i + 1, j: j) && helper(i: i, j: j - 1) && helper(i: i, j: j + 1)
            }
            return false
        }
        for i in 1 ..< m - 1 {
            for j in 1 ..< n - 1 {
                if helper(i: i, j: j) == false {
                    board[i][j] = "X"
                }
            }
        }
    }
    
    /// 137.只出现一次的数字 II
    // 网上其他两种算法，没完全弄懂
    // 利用位运算才有办法实现不用额外空间，就是遍历32次每次记录某位的出现的次数，如果不能被三整除，说明那个出现一次的就在该位有值，那么ans 或该位一下就可以了。
    // 对于除出现一次之外的所有的整数，其二进制表示中每一位1出现的次数是3的整数倍，将所有这些1清零，剩下的就是最终的数。用ones记录到当前计算的变量为止，二进制1出现“1次”（mod 3 之后的 1）的数位。用twos记录到当前计算的变量为止，二进制1出现“2次”（mod 3 之后的 2）的数位。当ones和twos中的某一位同时为1时表示二进制1出现3次，此时需要清零。即用二进制模拟三进制计算。最终ones记录的是最终结果。
    func singleNumber(_ nums: [Int]) -> Int {
        var dict = [Int : Int]()
        for num in nums {
            if let count = dict[num] {
                if count == 2 {
                    dict.removeValue(forKey: num)
                } else {
                    dict[num] = count + 1
                }
            } else {
                dict[num] = 1
            }
        }
        return dict.keys.first ?? 0
    }
    
    /// 139. 单词拆分, 超时的算法
//    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
//        for i in 0 ..< wordDict.count {
//            let word = wordDict[i]
//            if s == word || s.replacingOccurrences(of: "?", with: "") == "" {
//                return true
//            } else if s.contains(word) {
//                let remain = s.replacingOccurrences(of: word, with: "?")
//                let temp = wordBreak(remain, wordDict)
//                if temp {//注意这里是true才返回，false的话就继续
//                    return true
//                }
//            } else {
//                continue
//            }
//        }
//        return false
//    }
    
    /// 139. 单词拆分,动态规划的算法
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        var array = [Character](s)
        var dp = [Bool](repeating: false, count: s.count + 1)
        dp[0] = true
        for i in 0 ..< s.count {
            for j in 0 ... i {
                let sub = String(array[i...j])
                if dp[j] && wordDict.contains(sub) {
                    dp[i + 1] = true
                    break
                }
            }
        }
        return dp[s.count]
    }
    
    /// 143. 重排链表
    func reorderList(_ head: ListNode?) {
        var p1 = head
        var p2 = head?.next
        while p2?.next != nil {
            p1 = p1?.next
            p2 = p2?.next?.next
        }
        var two = p1?.next
        p1?.next = nil
        var one = head
        
        var last: ListNode? = nil
        while two != nil {
            let temp = two?.next
            two?.next = last
            last = two
            two = temp
        }
        two = last
        
        while one != nil && two != nil {
            let temp1 = one?.next
            let temp2 = two?.next
            one?.next = two
            two?.next = temp1
            one = temp1
            two = temp2
        }
    }
    
    /// 147. 对链表进行插入排序
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        if head == nil { return nil }
        var sorted = head
        var current = head?.next
        sorted?.next = nil
        while current != nil {
            var temp = current?.next
            current?.next = nil
            if current!.val < sorted!.val {
                current?.next = sorted
                sorted = current
            } else {
                var last = sorted
                var target = sorted?.next
                while target != nil {
                    if current!.val <= target!.val {
                        last?.next = current
                        current?.next = target
                        break
                    } else {
                        last = target
                        target = target?.next
                    }
                }
                last?.next = current
            }
            current = temp
        }
        return sorted
    }
    
    /// 148. 排序链表
    func sortList(_ head: ListNode?) -> ListNode? {
        
        func mergeHelper(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
            guard let l1 = l1 else { return l2 }
            guard let l2 = l2 else { return l1 }
            var result: ListNode? = nil
            if l1.val < l2.val {
                result = l1
                result?.next = mergeHelper(l1.next, l2)
            } else {
                result = l2
                result?.next = mergeHelper(l2.next, l1)
            }
            return result
        }
        
        if head == nil || head?.next == nil { return head }//这一句不能少，否则LeetCode会报错
        
        var slow = head
        var fast = head?.next
        while fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        let two = slow?.next
        slow?.next = nil
        let l1 = sortList(head)
        let l2 = sortList(two)
        let result = mergeHelper(l1, l2)
        return result
    }
    
    /// 165. 比较版本号
    func compareVersion(_ version1: String, _ version2: String) -> Int {
        let array1 = version1.components(separatedBy: ".")
        let array2 = version2.components(separatedBy: ".")
        
        let count1 = array1.count
        let count2 = array2.count
        let maxCount = count1 >= count2 ? count1 : count2
        
        for i in 0 ..< maxCount {
            var one: Int = 0
            var two: Int = 0
            if i < count1 {
                one = Int(array1[i]) ?? 0
            }
            if i < count2 {
                two = Int(array2[i]) ?? 0
            }
            if one > two {
                return 1
            } else if one < two {
                return -1
            }
        }
        return 0
        
    }
    
    
    /// 168. Excel表列名称
    func convertToTitle(_ n: Int) -> String {
        let A: Character = "A"
        let num = Int(A.unicodeScalars.first!.value)
        
        func helper(_ n: Int, _ temp: String) -> String {
            let n = n - 1
            if n >= 0 && n <= 25 {
                return String(Character(UnicodeScalar(num + n)!)) + temp
            } else {
                let a = n % 26
                let b = n / 26
                let c = helper(a + 1, temp)
                return helper(b, c)
            }
        }
        return helper(n, "")
    }
    
}
