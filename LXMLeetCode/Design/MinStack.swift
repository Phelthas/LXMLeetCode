//
//  MinStack.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/6/13.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class MinStack {
    
    private var stackOne = [Int]()
    private var stackTwo = [Int]()
    
    func push(_ x: Int) {
        stackOne.append(x)
        if let last = stackTwo.last, last < x {
            
        } else {
            stackTwo.append(x)
        }
    }
    
    func pop() {
        guard let oneLast = stackOne.last, let twoLast = stackTwo.last else { return }
        if oneLast == twoLast {
            stackTwo.removeLast()
        }
        stackOne.removeLast()
    }
    
    func top() -> Int? {
        return stackOne.last
    }
    
    func getMin() -> Int? {
        return stackTwo.last
    }
}



/// 384. 打乱数组
class ShuffleAnArray {
    
    private var nums: [Int]
    
    init(nums: [Int]) {
        self.nums = nums
    }
    
    func reset() -> [Int] {
        return self.nums
    }
    
    func shuffle() -> [Int] {
        
        var temp = nums
        for i in (0 ..< nums.count).reversed() {
            //arc4random_uniform()产生0-n之间的随机数，包括0和n-1,不包括n
            let j = arc4random_uniform(UInt32(i + 1))
            temp.swapAt(i, Int(j))
        }
        return temp
    }
    
}

