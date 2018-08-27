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
        var set = Set<String>(deadends)
        if set.contains("0000") { return -1 }
        
        func plusCharacter(_ c: Character) -> Character {
            switch c {
            case "0": return "1"
            case "1": return "2"
            case "2": return "3"
            case "3": return "4"
            case "4": return "5"
            case "5": return "6"
            case "6": return "7"
            case "7": return "8"
            case "8": return "9"
            default: return "0"
            }
        }
        func minusCharacter(_ c: Character) -> Character {
            switch c {
            case "1": return "0"
            case "2": return "1"
            case "3": return "2"
            case "4": return "3"
            case "5": return "4"
            case "6": return "5"
            case "7": return "6"
            case "8": return "7"
            case "9": return "8"
            default: return "9"
            }
        }
        
        func helper(_ s: String) {
            set.insert(s)
            let array = [Character](s)
            for i in 0 ..< 4 {
                var temp = array
                let c = temp[i]
                let c1 = plusCharacter(c)
                temp[i] = c1
                let s1 = String(temp)
                if !set.contains(s1) {
                    set.insert(s1)
                    queue.append(s1)
                }
                
                let c2 = minusCharacter(c)
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
