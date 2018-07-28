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


///297 二叉树的序列化与反序列化, 我这里用了层次遍历的方法，貌似用递归会更简单
class Codec {
    // Encodes a tree to a single string.
    
    private let nullString = "null"
    
    func serialize(root: TreeNode?) -> String? {
        guard let root = root else { return "" }
        var stringArray = [String]()
        var nodeArray = [Any]()
        nodeArray.append(root)
        while nodeArray.count != 0 {
            if let first = nodeArray.removeFirst() as? TreeNode {
                stringArray.append("\(first.val)")
                if let left = first.left {
                    nodeArray.append(left)
                } else {
                    nodeArray.append(nullString)
                }
                if let right = first.right {
                    nodeArray.append(right)
                } else {
                    nodeArray.append(nullString)
                }
                
            } else {
                stringArray.append(nullString)
            }
        }
        let result = stringArray.joined(separator: ",")
        return result
    }
    
    // Decodes your encoded data to tree.
    func deserialize(data: String) -> TreeNode? {
        let array = data.components(separatedBy: ",")
        guard array.count > 0 else { return nil }
        guard let rootVal = Int(array[0]) else { return nil }
        let root = TreeNode(rootVal)
        var nodeArray = [root]
        var i = 0
        while nodeArray.count != 0 {
            let first = nodeArray.removeFirst()
            
            if 2 * i + 1 >= array.count { break }
            let left = array[2 * i + 1]
            if left == nullString {
                first.left = nil
            } else {
                if let val = Int(left) {
                    let leftNode = TreeNode(val)
                    first.left = leftNode
                    nodeArray.append(leftNode)
                }
            }
            
            if 2 * i + 2 >= array.count { break }
            let right = array[2 * i + 2]
            if right == nullString {
                first.right = nil
            } else {
                if let val = Int(right) {
                    let rightNode = TreeNode(val)
                    first.right = rightNode
                    nodeArray.append(rightNode)
                }
            }
            i += 1
        }
        return root
    }
}

