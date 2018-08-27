//
//  QueueAndStackSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/8/27.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class QueueAndStackSolution {
    
    /// 752. 打开转盘锁 首先想到的暴力穷举法，超时了。。。
    func openLock(_ deadends: [String], _ target: String) -> Int {
        var result = 0
        var queue = ["0000"]
        var set = Set<String>()
        set.insert("0000")
        
        func helper(_ s: String) {
            if deadends.contains(s) {
                return
            }
            set.insert(s)
            var array = [Character](s)
            for i in 0 ..< 4 {
                var temp = array
                let value = Int(String(array[i]))!
                let one = (value + 1) % 10
                var two = value - 1
                if two == -1 {
                    two = 9
                }
                let c1 = Character("\(one)")
                temp[i] = c1
                let s1 = String(temp)
                if !set.contains(s1) {
                    set.insert(s1)
                    queue.append(s1)
                }
                
                let c2 = Character("\(two)")
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
    
}
