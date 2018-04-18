//
//  Solution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/4/14.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation

class TestData {
    
    let node1 = TreeNode(1)
    let node2 = TreeNode(2)
    let node3 = TreeNode(3)
    let node4 = TreeNode(4)
    let node5 = TreeNode(5)
    let node6 = TreeNode(6)
    let node7 = TreeNode(7)
    let node8 = TreeNode(8)
    let node9 = TreeNode(9)
    
    /*
                      1
               /             \
              2               3
          /       \       /        \
         4        5      6          7
                 /        \
                8          9
     *********************************
        4    2  8  5  1  6 9  3     7
     */
    init() {
        node1.left = node2
        node1.right = node3
        
        node2.left = node4
        node2.right = node5
        
        node3.left = node6
        node3.right = node7
        
        node5.left = node8
        node6.right = node9
    }
    
}

class Solution {
    
    func preorderTraverseSolution() {
        print("前序遍历")
        print(TreeNode.preorderTraverseRecursion(root: TestData().node1))
        print(TreeNode.preorderTraverseIteration(root: TestData().node1))
    }
    
    func inorderTraverseSolution() {
        print("中序遍历")
        print(TreeNode.inorderTraverseRecursion(root: TestData().node1))
        print(TreeNode.inorderTraverseIteration(root: TestData().node1))
    }
    
    func postorderTraverseSolution() {
        print("后序遍历")
        print(TreeNode.postorderTraverseRecursion(root: TestData().node1))
        print(TreeNode.postorderTraverseIteration(root: TestData().node1))
    }
    
    func levelOrderTraverseSolution() {
        print("层序遍历")
        print(TreeNode.levelOrderTraverse(root: TestData().node1))
        print(TreeNode.levelOrder(root: TestData().node1))
    }
    
    func maxDepthSolution() {
        print("最大深度")
        print(TreeNode.maxDepthBottomToTop(ofNode: TestData().node1))
        print(TreeNode.maxDepthTopToBottom(ofNode: TestData().node1))
        
    }
}
