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

