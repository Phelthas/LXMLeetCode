//
//  DoublyLinkedListSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/8/24.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

public class DoublyListNode {
    var val: Int
    var next: DoublyListNode?
    var prev: DoublyListNode?
    
    var child: DoublyListNode?
    
    
    init(x: Int) {
        self.val = x
    }
}

class DoublyLinkedListSolution {
    
    class func testData() -> DoublyListNode? {
        let node1 = DoublyListNode(x: 1)
        let node2 = DoublyListNode(x: 2)
        let node3 = DoublyListNode(x: 3)
        let node4 = DoublyListNode(x: 4)
        let node5 = DoublyListNode(x: 5)
        let node6 = DoublyListNode(x: 6)
        let node7 = DoublyListNode(x: 7)
        let node8 = DoublyListNode(x: 8)
        let node9 = DoublyListNode(x: 9)
        let node10 = DoublyListNode(x: 10)
        let node11 = DoublyListNode(x: 11)
        let node12 = DoublyListNode(x: 12)
        node1.next = node2
        node2.prev = node1
        node2.next = node3
        node3.prev = node2
        node3.next = node4
        node4.prev = node3
        node4.next = node5
        node5.prev = node4
        node5.next = node6
        node6.prev = node5
        node3.child = node7
        node7.next = node8
        node8.prev = node7
        node8.next = node9
        node9.prev = node8
        node9.next = node10
        node10.prev = node9
        node8.child = node11
        node11.next = node12
        node12.prev = node11
        return node1
    }
    
    ///  扁平化多级双向链表
    func flatten(head: DoublyListNode?) -> DoublyListNode? {
        let result = head
        if head == nil {
            return result
        }
        var current: DoublyListNode? = nil
        var stack = [DoublyListNode]()
        stack.append(head!)
        while stack.count > 0 {
            let last = stack.removeLast()
            last.prev = current
            current?.next = last
            current = last
            
            while current != nil {
                if let child = current?.child {
                    if let next = current?.next {
                        stack.append(next)
                    }
                    child.prev = current
                    current?.next = child
                }
                if current?.next == nil {
                    break
                } else {
                    current = current?.next
                }
                
            }
        }
        return result
        
    }
}
