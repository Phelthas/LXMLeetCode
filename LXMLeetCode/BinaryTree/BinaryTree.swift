//
//  BinaryTree.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/4/14.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

public class TreeNode : NSObject {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    public override var description: String {
            return "\(self.val)"
    }
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
        
        return resultArray
    }
    
}

