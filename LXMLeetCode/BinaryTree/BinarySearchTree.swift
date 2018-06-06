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
//    class func isValidBST(root: TreeNode?) -> Bool {
//        guard let root = root else { return true }
//
//        func help(node: TreeNode?) -> Bool {
//            guard let root = node else { return true }
//
//            func traverseLeft(node: TreeNode?, currentVal: Int) -> Bool {
//                guard let node = node else { return true }
//                if node.val >= currentVal {
//                    return false
//                }
//                var leftResult = true
//                var rightResult = true
//                if let left = node.left {
//                    leftResult = traverseLeft(node: left, currentVal: currentVal)
//                }
//                if let right = node.right {
//                    rightResult = traverseLeft(node: right, currentVal: currentVal)
//                }
//                return leftResult && rightResult
//            }
//
//            func traverseRight(node: TreeNode?, currentVal: Int) -> Bool {
//                guard let node = node else { return true }
//                if node.val <= currentVal {
//                    return false
//                }
//                var leftResult = true
//                var rightResult = true
//                if let left = node.left {
//                    leftResult = traverseRight(node: left, currentVal: currentVal)
//                }
//                if let right = node.right {
//                    rightResult = traverseRight(node: right, currentVal: currentVal)
//                }
//                return leftResult && rightResult
//            }
//
//            let leftResult = traverseLeft(node: root.left, currentVal: root.val)
//            let rightResult = traverseRight(node: root.right, currentVal: root.val)
//
//            return leftResult && rightResult
//        }
//
//        let conditionOne = help(node: root)
//
//        let conditionTwo = isValidBST(root: root.left) && isValidBST(root:root.right)
//
//        return conditionOne && conditionTwo
//
//    }
    
    
    /// 验证BST的递归算法，这个算法思路还是很值得学习的，递归的核心是：父节点左边所有的值都要比它下，父节点的右边左右的值都要比它大，所以 左节点的右节点（或者右节点的左节点）就同时要满足小于某个数且大于某个数，这里递归巧妙的把最大最小值传递了下去，需要单步运行好好理解下
    class func isValidBST(root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        
        func traverseHelper(node: TreeNode?, min: Int, max: Int) -> Bool {
            guard let node = node else { return true }
            if node.val <= min || node.val >= max {
                return false
            }
            return traverseHelper(node: node.left, min: min, max: node.val) && traverseHelper(node: node.right, min: node.val, max: max)
        }
        return traverseHelper(node: root, min: Int.min, max: Int.max)
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
    
    
    
}


// MARK: - BST插入
extension TreeNode {
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

// MARK: - BST删除
extension TreeNode {
    
    class func deleteFromBST(root: TreeNode?, val: Int) -> TreeNode? {
        guard let root = root else { return nil }
        
        var father: TreeNode? = nil
        var isLeft = true
        
        func searchBST(root: TreeNode?, forTarget targetVal: Int) -> TreeNode? {
            guard let root = root else { return nil }
            if root.val == targetVal {
                return root
            } else if root.val > targetVal {
                if let left = root.left {
                    father = root
                    isLeft = true
                    return searchBST(root: left, forTarget: targetVal)
                } else {
                    father = nil
                    return nil
                }
            } else {
                if let right = root.right {
                    father = root
                    isLeft = false
                    return searchBST(root: right, forTarget: targetVal)
                } else {
                    father = nil
                    return nil
                }
            }
        }
        
        guard let targetNode = searchBST(root: root, forTarget: val) else { return root }
        
        if targetNode.left == nil && targetNode.right == nil {
            
            if let fatherNode = father {
                //如果目标节点没有子节点，直接删除
                if isLeft {
                    fatherNode.left = nil
                } else {
                    fatherNode.right = nil
                }
            } else {
                return nil
            }
        }
        else if targetNode.left == nil || targetNode.right == nil {
            if let fatherNode = father {
                //目标节只有一个子节点，将目标节点的子节点 放到目标节点位置即可
                if isLeft {
                    if let left = targetNode.left {
                        fatherNode.left = left
                    }
                    if let right = targetNode.right {
                        fatherNode.left = right
                    }
                } else {
                    if let left = targetNode.left {
                        fatherNode.right = left
                    }
                    if let right = targetNode.right {
                        fatherNode.right = right
                    }
                }
            } else {
                if let left = targetNode.left {
                    return left
                } else {
                    return targetNode.right
                }
            }
            
        }
        else {
            //目标节点有两个子节点，得找到目标节点的中序后继节点或者前驱节点来替换
            var nextNode: TreeNode? = nil
            if let next = inorderNextNode(root: root, targetVal: val) {
                nextNode = next
            } else {
                nextNode = inorderPreNode(root: root, targetVal: val)
            }
            
            /// 有两个子节点，其中序后继节点或者前驱节点必定存在
            if let next = nextNode {
                let temp = next.val
                _ = deleteFromBST(root: root, val: temp)
                targetNode.val = temp
            }
            if father == nil {
                return targetNode
            }
        }
        return root
        
    }
 
    
    /// 目标节点的中序后继节点
    class func inorderNextNode(root: TreeNode, targetVal: Int) -> TreeNode? {
        var stackArray = [TreeNode]()
        var currentNode: TreeNode? = root
        var find = false
        
        while true {
            while currentNode != nil {
                stackArray.append(currentNode!)
                currentNode = currentNode?.left
            }
            if stackArray.count == 0 {
                break
            }
            currentNode = stackArray.removeLast()
            if find {
                return currentNode
            }
            if currentNode!.val == targetVal {
                find = true
            }
            currentNode = currentNode?.right
        }
        return nil
    }
    
    /// 目标节点的中序前驱节点
    class func inorderPreNode(root: TreeNode, targetVal: Int) -> TreeNode? {
        var stackArray = [TreeNode]()
        var currentNode: TreeNode? = root
        var lastNode: TreeNode? = nil
        
        while true {
            while currentNode != nil {
                stackArray.append(currentNode!)
                currentNode = currentNode?.left
            }
            if stackArray.count == 0 {
                break
            }
            currentNode = stackArray.removeLast()
            if currentNode!.val == targetVal {
                return lastNode
            }
            lastNode = currentNode
            currentNode = currentNode?.right
        }
        return nil
    }

}



// MARK: - BST求数组中的第k大元素，还没有用大量测试用例测过
extension TreeNode {
    
    class func kthLargestVal(array: [Int], targetK: Int) -> Int {
        
        guard let firstVal = array.first else { return -1 }
        
        func insertBST(root: TreeNode?, val: Int) -> TreeNode? {
            if let root = root {
                if root.val > val {
                    root.left = insertIntoBST(root: root.left, val: val)
                } else {
                    root.right = insertIntoBST(root: root.right, val: val)
                }
            } else {
                return TreeNode(val)
            }
            return root
        }
        
        func kthLargestVal(root: TreeNode, k: Int) -> Int {
            guard k >= 1 && k <= root.nodeCount else { return -1 }
            if root.right == nil && k == 1 {
                return root.val
            }
            if root.nodeCount == k && root.left == nil {
                return root.val
            }
            //其实左边右边的算法是一样的，都是判断右边节点的个数是否是k-1个，如果是，那么root就是第k大元素
            //写法不一样只是因为：总节点数 = 左节点数 + 右节点数 + 1；
            if let right = root.right {
                if right.nodeCount == k - 1 {
                    return root.val
                } else if right.nodeCount > k - 1 {
                    return kthLargestVal(root: right, k: k)
                } else {
                    return kthLargestVal(root: root.left!, k: k - 1 - right.nodeCount)
                }
            }
            if let left = root.left {
                if left.nodeCount == root.nodeCount - k {
                    return root.val
                } else if left.nodeCount > root.nodeCount - k {
                    return kthLargestVal(root: left, k: left.nodeCount - (root.nodeCount - k))
                } else {
                    return kthLargestVal(root: root.right!, k: k)
                }
            }
            return -1 
        }
        
        let root = TreeNode(firstVal)
        for i in 1 ..< array.count {
            _ = insertBST(root: root, val: array[i])
        }
        return kthLargestVal(root: root, k: targetK)
    }
    
    
}
