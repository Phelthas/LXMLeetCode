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
    
    
//    /// 回文链表
//    func isPalindrome(_ head: ListNode?) -> Bool {
//
//        var reversedList: ListNode? = nil
//        var current: ListNode? = head
//        while current != nil {
//            let temp = ListNode(x: current!.val)
//            temp.next = reversedList
//            reversedList = temp
//            current = current?.next
//        }
//        var one = head
//        var two = reversedList
//        while one != nil {
//            if one?.val != two?.val {
//                return false
//            }
//            one = one?.next
//            two = two?.next
//        }
//        return true
//
//    }
    
    
    /// 看别人提交的代码，用快慢指针找中点，然后翻转后半部分链表比较
    func isPalindrome(_ head: ListNode?) -> Bool {
        
        func reverseList(_ head: ListNode?) -> ListNode? {
            var current: ListNode? = head
            var last: ListNode? = nil
            while current != nil {
                let temp = current?.next
                current?.next = last
                last = current
                current = temp
            }
            return last
        }
        
        var fast: ListNode? = head
        var slow: ListNode? = head
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        var reversed = reverseList(slow)
        var start = head
        while reversed != nil {
            if (reversed?.val)! != (start?.val)! {
                return false
            }
            reversed = reversed?.next
            start = start?.next
        }
        return true
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
    
    
    /// 链表中是否有环；用快慢两个指针，快指针每次都两步，慢指针每次走一步，如果快指针赶上了慢指针，说明有环，如果某个指针走到了nil，说明没有环
    func hasCycle(_ head: ListNode?) -> Bool {
        var fast = head
        var slow = head
        while fast != nil && fast?.next != nil && slow != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if fast === slow {
                return true
            }
        }
        return false
    }
    
    /// 2. 链表的两数相加
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1 else { return l2 }
        guard let l2 = l2 else { return l1 }
        var one: ListNode? = l1
        var two: ListNode? = l2
        var result: ListNode? = nil
        var current: ListNode? = nil
        var x = 0
        while one != nil || two != nil {
            var temp = x
            if let value = one?.val {
                temp += value
                one = one?.next
            }
            if let value = two?.val {
                temp += value
                two = two?.next
            }
            if temp >= 10 {
                temp = temp % 10
                x = 1
            } else {
                x = 0
            }
            let node = ListNode(x: temp)
            if result == nil {
                result = node
                current = node
            } else {
                current?.next = node
                current = node
            }
        }
        if x == 1 {
            let node = ListNode(x: 1)
            current?.next = node
        }
        return result
        
    }
    
    /// 328. 奇偶链表
    func oddEvenList(_ head: ListNode?) -> ListNode? {
        guard let head = head else { return nil }
        var odd: ListNode? = head
        var even: ListNode? = head.next
        let evenFirst = even
        var next: ListNode? = nil
        while odd?.next != nil || even?.next != nil {
            next = odd?.next?.next
            odd?.next = next
            if next != nil {
                odd = next
            }
            
            next = even?.next?.next
            even?.next = next
            if next != nil {
                even = next
            }
            
        }
        odd?.next = evenFirst
        return head
    }
    
    /// 160. 相交链表, 我想到的算法是翻转两个链表，然后开始遍历，找到第一个不相同的上一个即是相交的节点，然后再把链表翻转回去。。。算下来最多遍历6遍，理论上还是满足题目要求的，但提交的时候说我改变链表了，有点郁闷
//    func getIntersectionNode(headA: ListNode?, headB: ListNode?) -> ListNode? {
//        var result: ListNode? = nil
//        let reversedA = reverseList(headA)
//        let reversedB = reverseList(headB)
//        var currentA = reversedA
//        var currentB = reversedB
//        while currentA != nil && currentB != nil {
//            if currentA === currentB {
//                result = currentA
//                currentA = currentA?.next
//                currentB = currentB?.next
//            } else {
//                break
//            }
//        }
//        _ = reverseList(reversedA)
//        _ = reverseList(reversedB)
//        return result
//    }
    
    ///160. 相交链表，别人的算法，遍历的时候记下长度差n，然后长的链表先走n步，再一起遍历，找到相同的节点即可，确实比我想到的算法要好很多。。。还可以把两个链表相连，判断有没有环，环的第一个节点就是相交节点
    func getIntersectionNode(headA: ListNode?, headB: ListNode?) -> ListNode? {
        var result: ListNode? = nil
        var a: ListNode? = headA
        var b: ListNode? = headB
        var countA = 0
        var countB = 0
        while a != nil {
            countA += 1
            a = a?.next
        }
        while b != nil {
            countB += 1
            b = b?.next
        }
        if countA > countB {
            var n = countA - countB
            a = headA
            b = headB
            while n != 0 {
                a = a?.next
                n -= 1
            }
        } else {
            var n = countB - countA
            a = headA
            b = headB
            while n != 0 {
                b = b?.next
                n -= 1
            }
        }
        while a != nil && b != nil {
            if a === b {
                return a
            } else {
                a = a?.next
                b = b?.next
            }
        }
        return nil
    }
    
    
    /// 142. 环形链表 II
    func detectCycle(head: ListNode?) -> ListNode? {
        guard let head = head else { return nil }
        var array = [ListNode]()
        var current: ListNode? = head
        while current?.next != nil {
            for node in array {
                if node === current?.next! {
                    return node
                }
            }
            array.append((current?.next)!)
            current = current?.next
        }
        return nil
    }
    
}
