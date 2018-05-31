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
}
