//
//  BinarySearchTree.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/4/25.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation



// MARK: - 验证二叉搜索树
extension TreeNode {
    class func isValidBST(root: TreeNode?) -> Bool {
        guard let root = root else { return true }
    
        func help(node: TreeNode?) -> Bool {
            guard let root = node else { return true }
            
            func traverseLeft(node: TreeNode?, currentVal: Int) -> Bool {
                guard let node = node else { return true }
                if node.val >= currentVal {
                    return false
                }
                var leftResult = true
                var rightResult = true
                if let left = node.left {
                    leftResult = traverseLeft(node: left, currentVal: currentVal)
                }
                if let right = node.right {
                    rightResult = traverseLeft(node: right, currentVal: currentVal)
                }
                return leftResult && rightResult
            }
            
            func traverseRight(node: TreeNode?, currentVal: Int) -> Bool {
                guard let node = node else { return true }
                if node.val <= currentVal {
                    return false
                }
                var leftResult = true
                var rightResult = true
                if let left = node.left {
                    leftResult = traverseRight(node: left, currentVal: currentVal)
                }
                if let right = node.right {
                    rightResult = traverseRight(node: right, currentVal: currentVal)
                }
                return leftResult && rightResult
            }
            
            let leftResult = traverseLeft(node: root.left, currentVal: root.val)
            let rightResult = traverseRight(node: root.right, currentVal: root.val)
            
            return leftResult && rightResult
        }
        
        let conditionOne = help(node: root)
        
        let conditionTwo = isValidBST(root: root.left) && isValidBST(root:root.right)
        
        return conditionOne && conditionTwo
        
    }
    
}
