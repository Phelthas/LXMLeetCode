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


// MARK: - 二叉搜索树的迭代器，没太明白题目的意思
extension TreeNode {
    
}


// MARK: - BST搜索
extension TreeNode {
    
    class func searchBST(root: TreeNode?, val: Int) -> TreeNode? {
        guard let root = root else { return nil }
        if root.val == val {
            return root
        } else if root.val > val {
            if let left = root.left {
                return searchBST(root: left, val: val)
            } else {
                return nil
            }
        } else {
            if let right = root.right {
                return searchBST(root: right, val: val)
            } else {
                return nil
            }
        }
    }
    
    class func insertIntoBST(root: TreeNode?, val: Int) -> TreeNode? {
        if let root = root {
            if root.val < val {
                root.right = insertIntoBST(root: root.right, val: val)
            } else if root.val > val {
                root.left = insertIntoBST(root: root.left, val: val)
            }
        } else {
            return TreeNode(val)
        }
        return root
    }
}
