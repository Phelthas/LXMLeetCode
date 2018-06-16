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
    
}
