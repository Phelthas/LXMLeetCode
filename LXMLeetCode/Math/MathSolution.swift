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
    
}
