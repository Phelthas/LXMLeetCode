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
    
//    public override var description: String {
//            return "\(self.val)"
//    }
}


// MARK: - 先序遍历
extension TreeNode {
    
    /* 递归的算法比较简单，迭代的算法关键是要弄清楚它是怎么迭代的，
     我是那了这篇博客（https://blog.csdn.net/u014787113/article/details/49717831）才明白的
     看里面的图会比较容易理解，核心思路摘抄如下
     “1.首先得到的是根节点，而后关注根节点的左子树，而后再关注左子树根节点的左子树......直到最终的某一个节点左子树不存在，在图中第一个左子树不存在的节点为H，不难发现，我们是一直沿着左子树下行的。
     2.而后我们将进行回溯，找到最后一个遍历的，且右子树存在的节点。在图中，第一个这样的节点是D。
     3.接下来对步骤2中所找到的节点进行步骤1的操作。”
     
     所以在遍历当前节点的左子树之前，要把当前节点的右子树入栈；
     然后以栈顶元素为根节点，依次遍历即可；
    */
    
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
        
        var stackArray = [TreeNode]()
        
        func traverseToBottomLeft(node: TreeNode?) {
            var currentNode = node
            while currentNode != nil {
                if let right = currentNode?.right {
                    stackArray.append(right)
                }
                resultArray.append((currentNode?.val)!)
                currentNode = currentNode?.left
            }
        }
        
        stackArray.append(root)
        while stackArray.count != 0 {
            let currentNode = stackArray.removeLast()
            traverseToBottomLeft(node: currentNode)
        }
        
//        stackArray.append(root)
//        var currentNode: TreeNode? = nil
//        while stackArray.count != 0 {
//            currentNode = stackArray.removeLast()
//            while currentNode != nil {
//                if let right = currentNode?.right {
//                    stackArray.append(right)
//                }
//                resultArray.append(currentNode!.val)
//                currentNode = currentNode?.left
//            }
//        }
        
        return resultArray
    }
    
}


// MARK: - 中序遍历
extension TreeNode {
    
    class func inorderTraverseRecursion(root: TreeNode?) -> [Int] {
        var resultArray = [Int]()
        
        func inorderTraverse(node: TreeNode?) {
            if let left = node?.left {
                inorderTraverse(node: left)
            }
            if let node = node {
                resultArray.append(node.val)
            }
            if let right = node?.right {
                inorderTraverse(node: right)
            }
        }
        
        inorderTraverse(node: root)
        return resultArray
    }
    
    class func inorderTraverseIteration(root: TreeNode?) -> [Int] {
        var resultArray = [Int]()
        guard let root = root else { return resultArray }
        
        
        /*
         迭代的核心其实就是这个栈，后进先出！！！
         */
        var stackArray = [TreeNode]()
        
        func traverseToBottomLeft(node: TreeNode?) {
            var currentNode = node
            while currentNode != nil {
                stackArray.append(currentNode!)
                currentNode = currentNode?.left
            }
        }
        
        /* 这个是即将被打印的节点 */
        var currentNode: TreeNode? = root
        while true {
            traverseToBottomLeft(node: currentNode)
            if stackArray.count == 0 {
                break
            }
            currentNode = stackArray.removeLast()
            //这里很关键，当前节点没有左子树，所以访问根节点，然后下一个需要被访问的是currentNode.right
            //currentNode.right也是需要遍历的，即也要找到它的最左下的没有节点，
            //如果currentNode.right是nil，说明当前节点也没有右子树，所以下一个需要被访问的就是栈里面的栈顶元素，
            //这个栈顶元素就不用再往左下去遍历了，因为它是出栈的时候找到的，即是在往回找的时候找到的，这时候它的左子树已经被访问过了
            if let temp = currentNode {
                resultArray.append(temp.val)
            }
            currentNode = currentNode?.right
        }
        
        
//        var currentNode: TreeNode? = root
//        while true {
//            while currentNode != nil {
//                stackArray.append(currentNode!)
//                currentNode = currentNode?.left
//            }
//            if stackArray.count == 0 {
//                break
//            }
//            currentNode = stackArray.removeLast()
//            if let temp = currentNode {
//                resultArray.append(temp.val)
//            }
//            currentNode = currentNode?.right
//        }
        
        return resultArray
    }
    
}


// MARK: - 后序遍历
extension TreeNode {
    
    class func postorderTraverseRecursion(root: TreeNode?) -> [Int] {
        var resultArray = [Int]()
        
        func postorderTraverse(node: TreeNode?) {
            if let left = node?.left {
                postorderTraverse(node: left)
            }
            
            if let right = node?.right {
                postorderTraverse(node: right)
            }
            if let node = node {
                resultArray.append(node.val)
            }
        }
        
        postorderTraverse(node: root)
        return resultArray
    }
    
    class func postorderTraverseIteration(root: TreeNode?) -> [Int] {
        var resultArray = [Int]()
        guard let root = root else { return resultArray }
        
        var stackArray = [TreeNode]()
        
        func postorderTraverse(node: TreeNode?) {
            var current = node
            while current != nil {
                stackArray.append(current!)
                current = current?.left
            }
        }
        
        var currentNode: TreeNode? = root
        var lastNode: TreeNode? = nil
        while true {
            postorderTraverse(node: currentNode)
            while stackArray.count != 0 {
                currentNode = stackArray.last
                // 最关键的是这里，判断输出的条件是：当前节点的右子树为空，或者右子树是刚刚访问过的，
                // 这样才符合后续遍历 左-右-中 的顺序，
                /*
                 总的流程是：
                 1，取栈顶节点，遍历找到最左下节点，并将途径节点依次入栈，如果该节点没有右子树，或者右子树==上次访问的子树，则执行2，否则执行3
                 2，输出该节点，将该节点出栈，将上次访问的节点设置为该节点，然后执行1；
                 3，这里说明该节点的右子树存在且不是上次访问过的节点，所以以该节点为栈顶元素，执行1
                 
                 */
                if currentNode?.right == nil || currentNode?.right === lastNode {
                    resultArray.append((currentNode?.val)!)
                    lastNode = currentNode
                    stackArray.removeLast()
                } else {
                    currentNode = currentNode?.right
                    break
                }
            }
            if stackArray.count == 0 {
                break
            }
        }
        
        return resultArray
    }
    
}

// MARK: - 层序遍历
extension TreeNode {
    
    class func levelOrder(root: TreeNode?) -> [[Int]] {
        var resultArray = [[Int]]()
        guard let root = root else { return resultArray }
        
        var currentLevel = [TreeNode]()
        var nextLevel = [TreeNode]()
        var subArray = [Int]()
        
        currentLevel.append(root)
        
        while currentLevel.count != 0 {
            let currentNode = currentLevel.removeFirst()
            subArray.append(currentNode.val)
            if let left = currentNode.left {
                nextLevel.append(left)
            }
            if let right = currentNode.right {
                nextLevel.append(right)
            }
            if currentLevel.count == 0 {
                resultArray.append(subArray)
                subArray = [Int]()
                if nextLevel.count == 0 {
                    break
                }
                currentLevel = nextLevel
                nextLevel = [TreeNode]()
            }
        }
        return resultArray
    }
    
    class func levelOrderTraverse(root: TreeNode?) -> [Int] {
        var resultArray = [Int]()
        guard let root = root else { return resultArray }
        
        var queueArray = [TreeNode]()
        queueArray.append(root)
        var currentNode: TreeNode? = root
        while queueArray.count != 0 {
            currentNode = queueArray.removeFirst()
            resultArray.append((currentNode?.val)!)
            if let left = currentNode?.left {
                queueArray.append(left)
            }
            if let right = currentNode?.right {
                queueArray.append(right)
            }
        }
        return resultArray
    }
    
}


extension TreeNode {
    
    class func maxDepthBottomToTop(ofNode root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        let leftResult = maxDepthBottomToTop(ofNode: root.left)
        let rirghtResult = maxDepthBottomToTop(ofNode: root.right)
        return max(leftResult, rirghtResult) + 1
    }
    
    class func maxDepthTopToBottom(ofNode root: TreeNode?) -> Int {
        
        var result: Int = 0
        func topToBottom(node: TreeNode?, depth: Int) {
            guard let node = node else { return }
            if node.left == nil && node.right == nil {
                result = max(result, depth + 1)
            }
            topToBottom(node: node.left, depth: depth + 1)
            topToBottom(node: node.right, depth: depth + 1)
        }
        
        topToBottom(node: root, depth: 0)
        return result
    }
    
}

extension TreeNode {
    
     func copy() -> TreeNode {
        let result = TreeNode(self.val)
        if let left = self.left {
            result.left = left.copy()
        }
        if let right = self.right {
            result.right = right.copy()
        }
        return result
    }
    
    class func invertTree(root: TreeNode?) -> TreeNode? {
        //这里实际上是指针赋值，所以下面的操作都是在原指针上执行的，并没有产生新的指针
        //如果想要一个跟原来数一模一样的新树，貌似只能遍历一般然后挨个新建了
        if let left = root?.left {
            _ = invertTree(root: left)
        }
        if let right = root?.right {
            _ = invertTree(root: right)
        }
        let temp = root?.left
        root?.left = root?.right
        root?.right = temp
        return root
    }
    
    class func isSame(nodeOne: TreeNode?, nodeTwo: TreeNode?) -> Bool {
        if nodeOne == nil && nodeTwo == nil {
            return true
        } else if nodeOne == nil || nodeTwo == nil {
            return false
        } else {
            if let one = nodeOne, let two = nodeTwo, one.val == two.val {
                let leftResult = isSame(nodeOne: one.left, nodeTwo: two.left)
                let rightResult = isSame(nodeOne: one.right, nodeTwo: two.right)
                if leftResult && rightResult {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
    }
    
    class func isSymmetric(root: TreeNode?) -> Bool {
        let inversedNode = TreeNode.invertTree(root: root?.copy())
//        print(TreeNode.preorderTraverseIteration(root: root))
//        print(TreeNode.preorderTraverseIteration(root: inversedNode))
        return TreeNode.isSame(nodeOne: root, nodeTwo: inversedNode)
    }
    
    
    class func isSymmetricRecursion(root: TreeNode?) -> Bool {
        guard let root = root else { return true }

        func isSymmetric(nodeOne: TreeNode?, nodeTwo: TreeNode?) -> Bool {
            if nodeOne == nil && nodeTwo == nil {
                return true
            } else if nodeOne == nil || nodeTwo == nil {
                return false
            } else {
                if nodeOne?.left?.val == nodeTwo?.right?.val && nodeOne?.right?.val == nodeTwo?.left?.val {
                    let sideResult = isSymmetric(nodeOne: nodeOne?.left, nodeTwo: nodeTwo?.right)
                    let midResult = isSymmetric(nodeOne: nodeOne?.right, nodeTwo: nodeTwo?.left)
                    return  sideResult && midResult
                }
                return false
            }
        }
        
        return isSymmetric(nodeOne: root.left, nodeTwo: root.right)
    }
    
    class func isSymmetricIteration(root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        
        if root.left == nil && root.right == nil {
            return true
        } else if root.left == nil || root.right == nil {
            return false
        } else {
            var leftStackArray = [root]
            var rightStackArray = [root]
            
            while leftStackArray.count != 0 && rightStackArray.count != 0 {
                if leftStackArray.count != rightStackArray.count {
                    return false
                }
                var currentLeft: TreeNode? = leftStackArray.removeLast()
                var currentRight: TreeNode? = rightStackArray.removeLast()
                
                while currentLeft != nil || currentRight != nil {
                    if currentLeft?.val != currentRight?.val {
                        return false
                    }
                    if let right = currentLeft?.right {
                        leftStackArray.append(right)
                    }
                    currentLeft = currentLeft?.left
                    
                    if let left = currentRight?.left {
                        rightStackArray.append(left)
                    }
                    currentRight = currentRight?.right
                }
            }
            return true
        }

    }
}



