//
//  LinkedListSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/5/30.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation


public class ListNode {
    var val: Int
    var next: ListNode?
    
    init(x: Int) {
        self.val = x
    }
}



class LinkedListSolution {
    
//     删除链表的结点
    func deleteNode(node: ListNode) {
        if let next = node.next {
            node.val = next.val
            node.next = next.next
        }
    }
    
    /* 别人提交的代码，用了个空节点，其next指向head，极大的简化了判断
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard head != nil else { return head }
        let result = ListNode(0)
        result.next = head
        var iNode = result
        var jNode = result

        for _ in 0..<n {
            jNode = jNode.next!
        }

        while jNode.next != nil {
            iNode = iNode.next!
            jNode = jNode.next!
        }

        iNode.next = iNode.next?.next
        return result.next
    }
    */
    
    /// 删除链表的倒数第N个节点
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if head?.next == nil {
            return nil
        }
        guard n > 1 else {
            var temp = head
            while temp?.next?.next != nil {
                temp = temp?.next
            }
            temp?.next = nil
            return head
        }
        var start = head
        var end = head
        for _ in 0 ..< n - 1 {
            end = end?.next
        }
        while end?.next != nil {
            start = start?.next
            end = end?.next
        }
        if let next = start?.next {
            start?.val = next.val
            start?.next = next.next
        } else {
            start = nil
        }
        return head
    }

    /// 自己写的翻转链表
//    func reverseList(_ head: ListNode?) -> ListNode? {
//
//        /// 删除链表的最后一个元素，返回该元素，如果只有一个元素,就只是返回该元素
//        func deleteLastNode(head: ListNode) -> ListNode {
//            var current = head
//            if current.next == nil {
//                return current
//            }
//            while current.next?.next != nil {
//                current = current.next!
//            }
//            let result = current.next
//            current.next = nil
//            return result!
//        }
//        guard let head = head else { return nil }
//        guard head.next != nil else { return head }
//        let result = deleteLastNode(head: head)
//        var current = result
//        while head.next != nil {
//            let temp = deleteLastNode(head: head)
//            current.next = temp
//            current = temp
//        }
//        current.next = head
//        return result
//    }
    
    
    /// 看别人提交后写的
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard head != nil, head?.next != nil else { return head }
        var last: ListNode? = nil
        var current: ListNode? = head
        
        
        while current?.next != nil {
            let orignalNext = current?.next
            current?.next = last
            last = current
            current = orignalNext
        }
        return last
        
    }
    
    
//    /// 合并两个有序链表
//    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
//        guard let l1 = l1 else { return l2 }
//        guard let l2 = l2 else { return l1 }
//        var currentOne: ListNode? = l1
//        var currentTwo: ListNode? = l2
//        var result: ListNode? = nil
//        if (currentOne?.val)! <= (currentTwo?.val)! {
//            result = currentOne
//            currentOne = currentOne?.next
//        } else {
//            result = currentTwo
//            currentTwo = currentTwo?.next
//        }
//        var current: ListNode? = result
//        while currentOne != nil || currentTwo != nil {
//            if let one = currentOne?.val, let two = currentTwo?.val {
//                if one <= two {
//                    current?.next = currentOne
//                    current = current?.next
//                    currentOne = currentOne?.next
//                } else {
//                    current?.next = currentTwo
//                    current = current?.next
//                    currentTwo = currentTwo?.next
//                }
//            } else if let one = currentOne {
//                current?.next = one
//                current = current?.next
//                currentOne = currentOne?.next
//            } else if let two = currentTwo {
//                current?.next = two
//                current = current?.next
//                currentTwo = currentTwo?.next
//            }
//        }
//        return result
//    }
    
    /// 合并两个有序链表 递归算法
    /// 迭代跟递归的思路完全不一样，注意！递归的思路是：
    /// 首先比较两个链表的头结点，头结点比较小的即为根结点，然后头结点的next就是 除去头结点剩下的链表与另外一个链表的merge，这个思路还是很巧妙的，因为是链表，所以某个结点的next就还是个链表，递归的思想刚好试用。
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1 else { return l2 }
        guard let l2 = l2 else { return l1 }
        var result: ListNode? = nil
        if l1.val <= l2.val {
            result = l1
            result?.next = mergeTwoLists(result?.next, l2)
        } else {
            result = l2
            result?.next = mergeTwoLists(result?.next, l1)
        }
        return result
    }
}
