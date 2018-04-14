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
               /   \
              2     3
             / \   / \
            4   5  6  7
               /    \
              8      9
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
}
