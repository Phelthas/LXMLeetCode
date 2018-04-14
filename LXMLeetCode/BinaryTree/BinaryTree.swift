//
//  BinaryTree.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/4/14.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

extension TreeNode {
    
    class func preorderTraverseRecursion(root: TreeNode?) -> [Int] {
        var resultArray = [Int]()
        
        func preorderTraverse(node: TreeNode?) {
            if let node = node {
                resultArray.append(node.val)
            }
            if let left = node?.left {
                preorderTraverse(node: left)
            }
            if let right = node?.right {
                preorderTraverse(node: right)
            }
        }
        
        preorderTraverse(node: root)
        return resultArray
    }
    
    class func preorderTraverseIteration(root: TreeNode?) -> [Int] {
        var resultArray = [Int]()
        guard let root = root else { return resultArray }
        
        var stackArray = [root]
        var currentNode: TreeNode? = nil
        
        while stackArray.count != 0 {
            currentNode = stackArray.removeLast()
            while currentNode != nil {
                if let right = currentNode?.right {
                    stackArray.append(right)
                }
                resultArray.append(currentNode!.val)
                currentNode = currentNode?.left
            }
        }
        return resultArray
    }
    
}




