//
//  StringSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/5/19.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation


class StringSolution {
    
    // func reverseString(_ s: String) -> String {
    //     return String(s.reversed())
    // }
    
    // func reverseString(_ s: String) -> String {
    //     var resultString = ""
    //     for char in s {
    //         resultString.insert(char, at: String.Index.init(encodedOffset: 0))
    //     }
    //     return resultString
    // }
    
    /// 翻转字符串
    func reverseString(_ s: String) -> String {
        guard s.count > 0 else { return s }
        var array = Array(s)
        var resultString = ""
        for i in (0 ..< array.count).reversed() {
            resultString.append(array[i])
        }
        return resultString
    }
    
    
    /// 颠倒整数
    func reverse(_ x: Int) -> Int {
        var current = x
        var result = 0
        while current != 0 {
            let lastNumber = current % 10
            result = result * 10 + lastNumber
            current = current / 10
            if result > 2147483647 || result < -2147483648 {
                return 0
            }
        }
        return result
    }
    
    // 字符串中的第一个唯一字符
    func firstUniqChar(_ s: String) -> Int {
        var dict = [Character : Int]()
        for temp in s {
            if let current = dict[temp] {
                dict[temp] = current + 1
            } else {
                dict[temp] = 1
            }
        }
        for key in s {
            if dict[key] == 1 {
                let result = s.index(of: key)
                return s.distance(from: s.startIndex, to: result!)
            }
        }
        return -1
    }
    
    //有效的字母异位词
    func isAnagram(_ s: String, _ t: String) -> Bool {
//        let one = s.sorted()
//        let two = t.sorted()
//        return one == two
        var dictOne = [Character : Int]()
        for temp in s {
            dictOne[temp] = (dictOne[temp] ?? 0) + 1
        }
        var dictTwo = [Character : Int]()
        for temp in t {
            dictTwo[temp] = (dictTwo[temp] ?? 0) + 1
        }
        return dictOne == dictTwo
    }
    
    // 验证回文字符串 看别人代码用到了s.utf8CString()这个方法，貌似更简单，
    func isPalindrome(_ s: String) -> Bool {
        /* ASC11码对应值
         a-z：97-122
         
         A-Z：65-90
         
         0-9：48-57
         */
        let t = s.lowercased()
        var resultString = ""
        for temp in t.unicodeScalars {
            let value = temp.value
            if (value >= 97 && value <= 122) || (value >= 48 && value <= 57) {
                resultString += String(temp)
            }
        }
        let reversedString = String(resultString.reversed())
        return resultString == reversedString
    }
    
//    func myAtoi(_ str: String) -> Int {
//        guard str.count > 0 else {
//            return 0
//        }
//        var resultString = ""
//        var sign = 1
//        var hasStart = false
//        let scalarArray = str.unicodeScalars
//
//        for temp in scalarArray {
//            let value = temp.value
//
//            if hasStart == false {
//                if value == UnicodeScalar(" ")?.value {
//                    continue
//                } else if value == UnicodeScalar("+")?.value {
//                    hasStart = true
//                } else if value == UnicodeScalar("-")?.value {
//                    sign = -1
//                    hasStart = true
//                } else if value >= 48 && value <= 57 {
//                    hasStart = true
//                    resultString = resultString + String(temp)
//                } else {
//                    return 0
//                }
//            } else {
//                if value >= 48 && value <= 57 {
//                    resultString = resultString + String(temp)
//                } else {
//                    break
//                }
//            }
//
//        }
//
//        var result = 0
//        for temp in resultString {
//            let current = Int(String(temp))!
//            result = result * 10 + current
//            if result > Int32.max {
//                return sign == 1 ? Int(Int32.max) : Int(Int32.min)
//            }
//        }
//        return sign * result
//    }
    
    // 字符串转整数 (atoi) 上面那个是一开始写的，貌似更快一点？这个是优化过的，更好阅读
    func myAtoi(_ str: String) -> Int {
        
        var sign = 1
        var hasStart = false
        var result = 0
        for temp in str {
            if hasStart == false {
                if temp == " " {
                    continue
                } else if temp == "+" {
                    hasStart = true
                } else if temp == "-" {
                    sign = -1
                    hasStart = true
                } else if temp >= "0" && temp <= "9" {
                    hasStart = true
                    let current = Int(String(temp))!
                    result = result * 10 + current
                } else {
                    return 0
                }
            } else {
                if temp >= "0" && temp <= "9" {
                    let current = Int(String(temp))!
                    result = result * 10 + current
                    if result > Int32.max {
                        return sign == 1 ? Int(Int32.max) : Int(Int32.min)
                    }
                } else {
                    break
                }
            }
            
        }
        
        return sign * result
    }
    
    /// 实现 strStr() 函数。思路是对的，原来可以直接将字符串转为Character数组。。。学到了
    func strStr(_ haystack: String, _ needle: String) -> Int {
        let oneCount = haystack.count
        let twoCount = needle.count
        
        let oneArray = [Character](haystack)
        let twoArray = Array<Character>(needle)
        
        
        guard twoCount > 0 else {
            return 0
        }
        guard oneCount >= twoCount else {
            return -1
        }
        for i in 0 ..< oneCount {
            if oneCount - i < twoCount {
                return -1
            }
            var result = true
            for (index, temp) in twoArray.enumerated() {
                if temp != oneArray[i + index] {
                    result = false
                    break
                }
            }
            if result {
                return i
            }
            
        }
        return -1
    }
    
    /// 数数并说
    func countAndSay(_ n: Int) -> String {
        guard n > 0 else { return "" }
        if n == 1 {
            return "1"
        }
        
        func helper(str: String) -> String {
            var resultString = ""
            let array = [Character](str)
            var start = array[0]
            var count = 0
            for i in 0 ..< array.count {
                if array[i] == start {
                    count += 1
                } else {
                    resultString = resultString + "\(count)" + "\(start)"
                    start = array[i]
                    count = 1
                }
            }
            resultString = resultString + "\(count)" + "\(start)"
            return resultString
        }
        
        var result = "1"
        for _ in 1 ..< n {
            result = helper(str: result)
        }
        return result
        
    }
    
    /// 最长公共前缀，看其他人提交的居然用了自带的prefix函数，这个应该是不行的吧。。。
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 0 else { return "" }
        
        var characterArray = [[Character]]()
        var minLength = Int.max
        for tempString in strs {
            guard tempString.count > 0 else { return "" }
            let tempArray = [Character](tempString)
            characterArray.append(tempArray)
            if tempString.count < minLength {
                minLength = tempString.count
            }
        }
        var index = 0
        var isSame = true
        while index < minLength && isSame {
            let first = characterArray[0][index]
            for i in 0 ..< characterArray.count {
                if characterArray[i][index] != first {
                    isSame = false
                    break
                }
            }
            if isSame {
                index += 1
            }
        }
        return String(characterArray[0][0 ..< index])
    }
    
}

extension StringSolution {
    
    /// 67. Add Binary
    func addBinary(_ a: String, _ b: String) -> String {

        let one = [Character](a)
        let two = [Character](b)
        let countA = one.count
        let countB = two.count
        let n = max(one.count, two.count)
        var result = ""
        var k = 0
        for i in 0 ..< n {
            let x = Int(String(i < one.count ? one[countA - 1 - i] : "0"))!
            let y = Int(String(i < two.count ? two[countB - 1 - i] : "0"))!
            var temp = x + y + k
            k = temp / 2
            temp = temp % 2
            result = "\(temp)" + result
        }
        if k == 1 {
            result = "1" + result
        }
        return result
    }
    
    /// 561. 数组拆分 I
    func arrayPairSum(_ nums: [Int]) -> Int {
        let array = nums.sorted()
        var i = 0
        var result = 0
        while i < array.count {
            result += array[i]
            i += 2
        }
        return result
    }
    
    /// 167. 两数之和 II - 输入有序数组
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var i = 0
        var j = numbers.count - 1
        while i < j {
            let sum = numbers[i] + numbers[j]
            if sum == target {
                return [i + 1, j + 1]
            } else if sum < target {
                i += 1
            } else {
                j -= 1
            }
        }
        return [-1, -1]
    }
    
    /// 27. 移除元素 双指针技巧
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var j = 0
        for i in 0 ..< nums.count {
            if nums[i] == val {
                
            } else {
                nums[j] = nums[i]
                j += 1
            }
        }
        return j
    }
    
    /// 485. 最大连续1的个数
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var result = 0
        var count = 0
        for i in 0 ..< nums.count {
            if nums[i] == 1 {
                count += 1
            } else {
                count = 0
            }
            result = max(result, count)
        }
        return result
    }
}
