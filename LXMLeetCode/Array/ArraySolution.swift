//
//  ArraySolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/5/3.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class ArraySolution {
    
    
    /// 从排序数组中删除重复项
    func removeDuplicates(nums: inout [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count
        }
        var index = 1
        var last = nums[0]
        for i in 1 ..< nums.count {
            let current = nums[i]
            if current != last {
                nums[index] = current
                last = current
                index += 1
            }
        }
        return index
    }
    
    class func removeDuplicatesSolution() {
        print("从排序数组中删除重复项")
        let arraySolution = ArraySolution()
        var testArray = [1, 1, 1, 1]
        let count = arraySolution.removeDuplicates(nums: &testArray)
        print(testArray[0 ..< count])
    }
    
}

extension ArraySolution {
    
    
    /// 向右旋转数组k位, 网上看到reverse3次的算法，不懂原理是什么。。。有空研究下
    func rotate(nums: inout [Int], _ k: Int) {
        let realK = k % nums.count
        if nums.count <= 1 || realK <= 0 {
            return
        }
        let subarray = nums[nums.count - realK ... nums.count - 1]
        for i in (realK ... nums.count - 1).reversed() {
            nums[i] = nums[i - realK]
        }
        nums[0...realK-1] = subarray
    }
    
    class func rotateRightSolution() {
        print("向右旋转数组k位")
        let arraySolution = ArraySolution()
        var testArray = [1, 2, 3, 4, 5, 6, 7]
        arraySolution.rotate(nums: &testArray, 3)
        print(testArray)
    }
    
}

extension ArraySolution {
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        if nums.count <= 1 {
            return false
        }
        
        // 如果包含重复就返回-1，否则返回基准位置
        func containsDuplicatePartition(array: inout [Int], start: Int, end: Int) -> Int {
            var left = start
            var right = end
            let key = array[start]
            while left < right {
                while right > left && array[right] > key {
                    right = right - 1
                }
                if left != right && array[right] == key {
                    return -1
                }
                while left < right && array[left] < key {
                    left = left + 1
                }
                if left != right && array[left] == key {
                    return -1
                }
                if left < right {
                    array.swapAt(left, right)
                }
                
            }
            array.swapAt(start, left)
            return left
        }
        
        
        func recursionHelper(array: inout [Int], start: Int, end: Int) -> Bool {
            if start < end {
                let pivot = containsDuplicatePartition(array: &array, start: start, end: end)
                if pivot == -1 {
                    return true
                } else {
                    let leftResult = recursionHelper(array: &array, start: start, end: pivot - 1)
                    let rightResult = recursionHelper(array: &array, start: pivot + 1, end: end)
                    return leftResult || rightResult
                }
                
            }
            return false
        }
        var array = nums
        return recursionHelper(array: &array, start: 0, end: array.count - 1)
    
        /* 通过的答案，用了系统自带的排序函数，貌似用Set更简单
        if nums.count <= 1 {
            return false
        }
        
        let array = nums.sorted()
        var last = array[0]
        for i in 1 ..< array.count {
            let current = array[i]
            if current == last {
                return true
            } else {
                last = current
            }
        }
        return false
        */
    }
    
    
    class func containsDuplicateSolution() {
        print("包含重复")
        let arraySolution = ArraySolution()
        let testArray = [1, 2, 3, 2]
        print(arraySolution.containsDuplicate(testArray))
    }
}

extension ArraySolution {
    
    /// 只出现一次的数字
    /// 利用的是异或的性质，想个相同的数异或等于0，任何数和0异或等于本身，即“两个输入相同时为0，不同则为1”
    func singleNumber(_ nums: [Int]) -> Int {
        var result = 0
        for temp in nums {
            result = result ^ temp
        }
        return result
    }
}


extension ArraySolution {
    
    /// 两个数组的交集
    /// 输出结果中每个元素出现的次数，应与元素在两个数组中出现的次数一致。
    /// 我们可以不考虑输出结果的顺序。
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var resultArray = [Int]()
        var array1 = nums1
        var array2 = nums2
        
        while array1.count != 0 && array2.count != 0 {
            let one = array1[0]
            if let index = array2.index(of: one) {
                resultArray.append(one)
                array1.removeFirst()
                array2.remove(at: index)
            } else {
                array1.removeFirst()
            }
        }
        return resultArray
    }
    
    /* 其他人提交的耗时最少的方法，利用字典记录出现次数
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var map = [Int: Int]()
        var result = Array<Int>()
        
        //记录nums1中每个数出现的次数
        for item in nums1 {
            let total = map[item]
            map[item] = (total ?? 0) + 1
        }
        
        //nums2中，如果item在map中有记录，且记录数大于0，就说明item在nums1中也出现过，就把它添加到交集数组中，并让map中的记录数减一
        for item in nums2 {
            if let number = map[item], number > 0 {
                result.append(item)
                map[item] = number - 1
            }
        }
        
        return result
    }
    */
}

extension ArraySolution {
    func plusOne(_ digits: [Int]) -> [Int] {
        
        //再某一位上加一，如果产生进位返回1，否则返回0；index0位个位，1位十位。。。
        func plusOne(array: inout [Int], atIndex index: Int) -> Int {
            if index == array.count {
                array.insert(1, at: 0)
                return 0
            } else {
                let location = array.count - 1 - index
                var temp = array[location]
                temp = temp + 1
                array[location] = temp % 10
                if temp > 9 {
                    return 1
                } else {
                    return 0
                }
            }
        }
        
        var resultArray = digits
        var index = 0
        while true {
            let advance = plusOne(array: &resultArray, atIndex: index)
            if advance == 0 {
                break
            } else {
                index += 1
            }
        }
        return resultArray
    }
}

extension ArraySolution {
    
    
    /// 又一个显示我超越了100%的提交者，但看了别人的实现之后，明显感觉别人的应该更快啊。。。
    /// while的判断用index < nums.count - count 的算法，比我这就优化了一个档次。。。
    func moveZeroes(_ nums: inout [Int]) {
        var index = 0
        var count = 0
        while index < nums.count && count < nums.count {
            let current = nums[index]
            if current == 0 {
                let temp = nums.remove(at: index)
                nums.append(temp)
            } else {
                index = index + 1
            }
            count = count + 1
        }
    }
}

extension ArraySolution {
    
    
    /// 两数之和，最笨的方法，双层循环
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for i in 0 ..< nums.count - 1 {
            for j in i + 1 ..< nums.count {
                if nums[i] + nums[j] == target {
                    return [i, j]
                }
            }
        }
        return [Int]()
    }
}

extension ArraySolution {
    
    /// 是否有效数独
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        
        func isArraySudoku(array: [Character]) -> Bool {
            var dict = [Character : Int]()
            for temp in array {
                if temp != "." {
                    if let count = dict[temp] {
                        dict[temp] = count + 1
                    } else {
                        dict[temp] = 1
                    }
                }
            }
            for count in dict.values {
                if count > 1 {
                    return false
                }
            }
            return true
        }
        
        for rowArray in board {
            if isArraySudoku(array: rowArray) == false {
                return false
            }
        }
        
        for i in 0 ..< 9 {
            var columArray = [Character]()
            for j in 0 ..< 9 {
                columArray.append(board[j][i])
            }
            if isArraySudoku(array: columArray) == false {
                return false
            }
        }
        
        for m in 0 ..< 3 {
            for n in 0 ..< 3 {
                var subArray = [Character]()
                for i in  3 * m ..< 3 + 3 * m {
                    for j in 3 * n ..< 3 + 3 * n {
                        subArray.append(board[i][j])
                    }
                }
                if isArraySudoku(array: subArray) == false {
                    return false
                }
            }
        }
        return true
    }
}

extension ArraySolution {
    
    /// 将图像顺时针旋转 90 度
    func rotateMatrix(_ matrix: inout [[Int]]) {
        let n = matrix.count
        for i in 0 ..< n / 2 {
            for j in i ..< n - 1 - i {
                let temp = matrix[i][j]
                matrix[i][j] = matrix[n - 1 - j][i]
                matrix[n - 1 - j][i] = matrix[n - 1 - i][n - 1 - j]
                matrix[n - 1 - i][n - 1 - j] = matrix[j][n - 1 - i]
                matrix[j][n - 1 - i] = temp
            }
        }
    }
    
    
    func fillClockwiseMatrix(m: Int, n: Int) -> [[Int]] {
        var result = [[Int]]()
        let total = m * n
        for _ in 0 ..< m {
            let temp = Array(repeating: 0, count: n)
            result.append(temp)
        }
        var k = 1
    
        var i = 0
        var j = 0
        while (i <= (m - 1) / 2) && (j <= (n - 1) / 2) {
            
            var indexY = n - 1 - j
            for temp in i ... m - 1 - i {
                result[temp][indexY] = k
                k += 1
            }
            if k >= total {
                break
            }
            
            var indexX = m - 1 - i
            if indexY >= j {
                for temp in (j ... indexY - 1).reversed() {
                    result[indexX][temp] = k
                    k += 1
                }
            }
            if k >= total {
                break
            }
            
            indexY = j
            if indexX - 1 >= i {
                for temp in (i ... indexX - 1).reversed() {
                    result[temp][indexY] = k
                    k += 1
                }
            }
            if k >= total {
                break
            }
            
            indexX = i
            if n - 1 - j - 1 >= j + 1 {
                for temp in (j + 1 ... n - 1 - j - 1) {
                    result[indexX][temp] = k
                    k += 1
                }
            }
            if k >= total {
                break
            }
            
            i += 1
            j += 1
        }
        
        print("顺时针填满矩阵")
        for temp in 0 ..< m {
            print(result[temp])
        }
        
        return result
    }
    
    /// 122. 买卖股票的最佳时机 II
    /// 注意题目要求是你可以尽可能完成更多的交易，所以当天卖出再买进也是可以的，所以就简单了，原来一直理解的是当天卖了就不能再买了，所以感觉一直有问题
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 1 else { return 0 }
        var result = 0
        for i in 0 ..< prices.count - 1 {
            if prices[i] < prices[i + 1] {
                result += prices[i + 1] - prices[i]
            }
        }
        return result
    }
    
//    /// 15. 三数之和, 超时的算法
//    func threeSum(_ nums: [Int]) -> [[Int]] {
//        var dict = [String : [Int]]()
//        var array = nums.sorted()
//
//        guard array.count >= 3 else { return [[Int]]() }
//        for i in 0 ... array.count - 3 {
//            for j in i + 1 ... array.count - 2 {
//                for k in j + 1 ... array.count - 1 {
//                    if array[i] + array[j] + array[k] == 0 {
//                        let key = "\(array[i])_\(array[j])_\(array[k])"
//                        dict[key] = [array[i], array[j], array[k]]
//                    }
//                }
//            }
//        }
//        return [[Int]](dict.values)
//
//    }
    
    /// 15. 三数之和, 看别人博客的算法，两个指针分别指向头尾两个数，见https://www.cnblogs.com/grandyang/p/4481576.html
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        guard nums.count >= 3 else { return result }
        let array = nums.sorted()
        var last = Int.min
        for i in 0 ... array.count - 3 {
            let current = array[i]
            if current == last {
                continue
            }
            if current > 0 {
                return result
            }
            var start = i + 1
            var end = array.count - 1
            while start < end {
                if current + array[start] + array[end] == 0 {
                    result.append([current, array[start], array[end]])
                    while (start < end) && array[start] == array[start + 1] {
                        start += 1
                    }
                    while (start < end) && array[end] == array[end - 1] {
                        end -= 1
                    }
                    start += 1
                    end -= 1
                    last = current
                } else if current + array[start] + array[end] > 0 {
                    end -= 1
                } else {
                    start += 1
                }
            }
        }
        return result
    }
    
//    73. 矩阵置零,虽然没有超时，但耗时还是很多。。。看别人的算法，可以先遍历一遍将行列都至为Int.max，在遍历一遍至0
    func setZeroes(_ matrix: inout [[Int]]) {
        var array = [(Int, Int)]()
        
        for i in 0 ..< matrix.count {
            let row = matrix[i]
            for j in 0 ..< row.count {
                let b = row[j]
                if b == 0 {
                    array.append((i, j))
                }
            }
        }
        
        for (m, n) in array {
            for i in 0 ..< matrix.count {
                for j in 0 ..< matrix[i].count {
                    matrix[m][j] = 0
                }
                matrix[i][n] = 0
            }
        }
    }
    
//    49. 字母异位词分组
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var dict = [String : [String]]()
        
        for temp in strs {
            let key = String([Character](temp).sorted())
            if var array = dict[key] {
                array.append(temp)
                dict[key] = array
            } else {
                dict[key] = [temp]
            }
        }
        return [[String]](dict.values)
    }
    
    
    /// 3. 无重复字符的最长子串,超时的算法
//    func lengthOfLongestSubstring(_ s: String) -> Int {
//        guard s.count > 0 else { return 0 }
//        let array = [Character](s)
//        let n = Set<Character>(array).count
//        guard n > 1 else { return 1 }
//        var result = 1
//        for i in 2 ... n {
//            for j in 0 ... array.count - i {
//                let sub = Array(array[j ... j + i - 1])
//                let count = Set<Character>(sub).count
//                if count == i {
//                    result = max(result, count)
//                }
//            }
//        }
//        return result
//    }
    
//    /// 3. 无重复字符的最长子串,通过的算法，但只超过了1%的提交。。。
//    func lengthOfLongestSubstring(_ s: String) -> Int {
//        guard s.count > 0 else { return 0 }
//        let array = [Character](s)
//        let n = Set<Character>(array).count
//        guard n > 1 else { return 1 }
//        for i in (2 ... n).reversed() {
//            for j in 0 ... array.count - i {
//                let sub = Array(array[j ... j + i - 1])
//                let count = Set<Character>(sub).count
//                if count == i {
//                    return count
//                }
//            }
//        }
//        return 1
//    }
    
    /// 3. 无重复字符的最长子串, 别人的思路，还可以再优化，用下标计算而不是用数组count计算
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.count > 0 else { return 0 }
        var result = 1
        var array = [Character](s)
        var window = [array[0]]
        for i in 1 ..< array.count {
            let current = array[i]
            var left = 0
            while left < window.count {
                if window[left] == current {
                    if left == window.count - 1 {
                        window = [current]
                    } else {
                        window = Array(window[left + 1 ..< window.count])
                        window.append(current)
                    }
                    break
                } else {
                    left += 1
                }
                if left == window.count {
                    window.append(current)
                    break
                }
            }
            result = max(result, window.count)
        }
        return result
    }
    
    /// 5. 最长回文子串，从中间向两边扩散的方法；网上有个Manacher算法，看不懂。。。。
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 1 else { return s }
        let array = [Character](s)
        var result = [Character]()
        var temp = [Character]()
        
        func findLongestPalindrome(left: Int, right: Int) {
            var left = left
            var right = right
            while left >= 0 && right <= array.count - 1 {
                if array[left] == array[right] {
                    if left == 0 || right == array.count - 1 {
                        temp = Array(array[left ... right])
                        if temp.count > result.count {
                            result = temp
                        }
                        break
                    }
                    left -= 1
                    right += 1
                } else {
                    temp = Array(array[left + 1 ... right - 1])
                    if temp.count > result.count {
                        result = temp
                    }
                    break
                }
            }
        }
        
        for i in 0 ..< array.count - 1 {
            if array[i] == array[i + 1] {
                findLongestPalindrome(left: i, right: i + 1)
            }
            findLongestPalindrome(left: i, right: i)
        }
        return String(result)
        
    }
    
    /// 334. 递增的三元子序列, 这个自己只想到了穷举法，这是看别人思路写的。。。
    func increasingTriplet(_ nums: [Int]) -> Bool {
        var first = Int.max
        var second = Int.max
        for current in nums {
            if current <= first {
                first = current
            } else if current > first && current < second {
                second = current
            } else if current > second {
                return true
            }
        }
        return false
    }
    
    /// 200. 岛屿的个数
    func numIslands(_ grid: [[Character]]) -> Int {
        var result = 0
        let m = grid.count
        if m == 0 {
            return 0
        }
        let n = grid[0].count
        var temp = grid
        
        func recurse(_ i: Int, _ j: Int) {
            temp[i][j] = "a"
            if i > 0 && temp[i - 1][j] == "1" {
                recurse(i - 1, j)
            }
            if i < m - 1 && temp[i + 1][j] == "1" {
                recurse(i + 1, j)
            }
            if j > 0 && temp[i][j - 1] == "1" {
                recurse(i, j - 1)
            }
            if j < n - 1 && temp[i][j + 1] == "1" {
                recurse(i, j + 1)
            }
        }
        for i in 0 ..< m {
            for j in 0 ..< n {
                if temp[i][j] == "1" {
                    result += 1
                    recurse(i, j)
                }
            }
        }
        return result
    }
    
    
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
    
}

