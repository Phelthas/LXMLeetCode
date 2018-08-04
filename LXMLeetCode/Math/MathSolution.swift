//
//  MathSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/5/16.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class MathSolution {
    
    func fizzBuzz(_ n: Int) -> [String] {
        var resultArray = [String]()
        for i in 1 ... n {
            if i % 3 == 0 && i % 5 == 0 {
                resultArray.append("FizzBuzz")
            } else if i % 5 == 0 {
                resultArray.append("Buzz")
            } else if i % 3 == 0 {
                resultArray.append("Fizz")
            } else {
                resultArray.append(String(i))
            }
        }
        return resultArray
    }
    
    
    /// 204. 计数质数
    func countPrimes(_ n: Int) -> Int {
        if n <= 2 { return 0}
        var array = [Bool](repeating: true, count: n)
        
        for i in 2 ..< n {
            if i * i >= n { break }
            if array[i] == false { continue }
            var j = i * i
            while j < n {
                array[j] = false
                j = j + i
            }
        }
        
        var result = 0
        for i in 2 ..< n {
            if array[i] == true {
                result += 1
            }
        }
        return result
    }
    
    
    /// 题目326，判断是否是3的幂次方，看网上有说可以用对数函数还判断，即直接判断x=log3(n)是不是整数即可，但是没发现swift的对数函数是什么。。。
    func isPowerOfThree(_ n: Int) -> Bool {
        if n <= 0 { return false }
        if n == 1 { return true }
        var current = n
        while current != 1 {
            if current % 3 == 0 {
                current = current / 3
            } else {
                return false
            }
        }
        return true
    }
    
    /// 题目13，罗马数字转整数
    func romanToInt(_ s: String) -> Int {
        func numberOfCharacter(_ c: String) -> Int {
            switch c {
            case "I": return 1
            case "V": return 5
            case "X": return 10
            case "L": return 50
            case "C": return 100
            case "D": return 500
            case "M": return 1000
            case "IV": return 4
            case "IX": return 9
            case "XL": return 40
            case "XC": return 90
            case "CD": return 400
            case "CM": return 900
            default: return 0
            }
        }
        var result = 0
        var array = [Character](s)
        let n = array.count
        var index = 0
        while index < n {
            if n - index >= 2 {
                let temp = String(array[index]) + String(array[index + 1])
                let number = numberOfCharacter(temp)
                if number != 0 {
                    result += number
                    index += 2
                    continue
                }
            }
            let temp = String(array[index])
            result += numberOfCharacter(temp)
            index += 1
        }
        return result
        
    }
    
    /// 202 快乐数
    func isHappy(_ n: Int) -> Bool {
        var array = [Int]()
        var current = n
        
        while current != 1 {
            if array.contains(current) {
                return false
            }
            array.append(current)
            var temp = current
            var count = 0
            while temp != 0 {
                let a = temp % 10
                count += a * a
                temp = temp / 10
            }
            current = count
        }
        return true
    }
    
    
    /// 172. 阶乘后的零 关键是找出0的规律，参考：https://blog.csdn.net/qikaihuting/article/details/65937878
    /// 
    func trailingZeroes(_ n: Int) -> Int {
        var count = n
        var result = 0
        while count / 5 != 0 {
            count = count / 5
            result += count
        }
        return result
    }
    
    /// 171. Excel表列序号
    func titleToNumber(_ s: String) -> Int {
        var result = 0
        let array = s.utf8CString
        let a = "A".utf8CString.first!
        for i in 0 ..< array.count - 1 {
            let c = array[i]
            result *= 26
            result += Int(c) - Int(a) + 1
        }
        return result
    }
    
    /// 50. Pow(x, n)
    func myPow(_ x: Double, _ n: Int) -> Double {
        var x = x
        var count = n
        if n < 0 {
            x = 1 / x
            count = -1 * count
        }
        if n == 0 {
            return 1
        }
        if n == 1 {
            return x
        }
        if n == 2 {
            return x * x
        }
        if n % 2 == 0 {
            return myPow(myPow(x, count / 2), 2)
        } else {
            return x * myPow(myPow(x, count / 2), 2)
        }
    }
    
    /// 69. x 的平方根
    func mySqrt(_ x: Int) -> Int {
        if x <= 1 { return x }
        var low = 0
        var high = x
        while low <= high {
            let mid = (low + high) / 2
            let temp = x / mid
            if temp == mid {
                return mid
            } else if temp > mid {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return high
    }
    
    ///29. 两数相除 边界条件注意，很恶心
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        if (divisor == 0 || (dividend == Int(Int32.min) && divisor == -1)) { return Int(Int32.max) }
        let sign = (dividend > 0 ? 1 : -1) ^ (divisor > 0 ? 1 : -1) == 0 ? 1 : -1
        var dividend = abs(dividend)
        var divisor = abs(divisor)
        
        if abs(divisor) == 1 { return sign == 1 ? dividend : -dividend }
        var result = 0
        while dividend >= divisor {
            var temp = divisor
            var count = 1
            while temp << 1 <= dividend {
                temp = temp << 1
                count = count << 1
            }
            dividend -= temp
            result += count
        }
        result = sign == 1 ? result : -result
        return result
    }
    
    /// 58 分数到小数
    func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        var result = ""
        var a = numerator
        let b = denominator
        result += "\(a/b)"
        a = a % b
        if a != 0 {
            result += "."
        } else {
            return result
        }
        var decimal = ""
        var array = [a]
        while true {
            a = a * 10
            decimal += "\(a/b)"
            a = a % b
            if a == 0 {
                result += decimal
                return result
            }
            if let index = array.index(of: a) {
                var temp = [Character](decimal)
                temp.insert("(", at: index)
                temp.append(")")
                result += String(temp)
                return result
            } else {
                array.append(a)
            }
        }
    }
}
