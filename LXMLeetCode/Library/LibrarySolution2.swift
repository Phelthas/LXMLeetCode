//
//  LibrarySolution2.swift
//  LXMLeetCode
//
//  Created by kook on 2018/10/20.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

extension LibrarySolution {
    
    /// 107. 二叉树的层次遍历 II
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard let root = root else { return result }
        var arrayOne = [TreeNode]()
        arrayOne.append(root)
        var arrayTwo = [TreeNode]()
        while arrayOne.count > 0 {
            var temp = [Int]()
            for node in arrayOne {
                temp.append(node.val)
                if let left = node.left {
                    arrayTwo.append(left)
                }
                if let right = node.right {
                    arrayTwo.append(right)
                }
            }
            result.append(temp)
            arrayOne = arrayTwo
            arrayTwo.removeAll()
        }
        return result.reversed()
    }
    
    /// 110. 平衡二叉树的递归写法
    func isBalanced(_ root: TreeNode?) -> Bool {
        
        func heightOf(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            return max(1 + heightOf(root.left), 1 + heightOf(root.right))
        }
        
        guard let root = root else { return true }
        if root.left == nil && root.right == nil {
            return true
        } else {
            let leftHeight = heightOf(root.left)
            let rightHeight = heightOf(root.right)
            if abs(leftHeight - rightHeight) > 1 {
                return false
            }
            return isBalanced(root.left) && isBalanced(root.right)
        }
    }
    
    /// 111. 二叉树的最小深度
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        func depthOf(node: TreeNode?, currentDepth: Int) -> Int {
            guard let node = node else { return currentDepth }
            let result = currentDepth + 1
            if node.left == nil && node.right == nil {
                return result
            } else if node.left == nil {
                return depthOf(node: node.right, currentDepth: result)
            } else if node.right == nil {
                return depthOf(node: node.left, currentDepth: result)
            } else {
                return min(depthOf(node: node.left, currentDepth: result), depthOf(node: node.right, currentDepth: result))
            }
            
        }
        
        return depthOf(node: root, currentDepth: 0)
        
    }
    
    /// 113.路径总和 II 
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        var result = [[Int]]()
        guard let root = root else { return result }
        
        func traverse(node: TreeNode, total: Int, array:[Int]) {
            let temp = total + node.val
            var array = array
            array.append(node.val)
            
            if node.left == nil && node.right == nil && temp == sum {
                result.append(array)
            } else {
                if let left = node.left {
                    traverse(node: left, total: temp, array: array)
                }
                if let right = node.right {
                    traverse(node: right, total: temp, array: array)
                }
            }
        }
        
        traverse(node: root, total: 0, array: [Int]())
        return result
    }
    
}
