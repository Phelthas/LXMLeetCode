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
    
    class func symmetricTestNode() -> TreeNode {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(2)
        let node4 = TreeNode(3)
        let node5 = TreeNode(3)
        let node6 = TreeNode(4)
        let node7 = TreeNode(4)
        node1.left = node2
        node1.right = node3
        node2.left = node4
        node2.right = node6
        node3.left = node7
        node3.right = node5
        return node1
    }
    
    class func binarySearchTreeNode() -> TreeNode {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(5)
        let node6 = TreeNode(6)
        let node7 = TreeNode(7)
        node4.left = node2
        node4.right = node6
        node2.left = node1
        node2.right = node3
        node6.left = node5
        node6.right = node7
        return node4
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
    
    func isSymmetricSolution() {
        print("是否是对称二叉树")
        print(TreeNode.isSymmetric(root: TestData.symmetricTestNode()))
        print(TreeNode.isSymmetricRecursion(root: TestData.symmetricTestNode()))
        print(TreeNode.isSymmetricIteration(root: TestData.symmetricTestNode()))
        
        print(TreeNode.isSymmetric(root: TestData().node1))
        print(TreeNode.isSymmetricRecursion(root: TestData().node1))
        print(TreeNode.isSymmetricIteration(root: TestData().node1))
    }
    
    func hasPathSumSolution() {
        print("路径总和")
        print(TreeNode.hasPathSumRecursion(root: TestData().node1, sum: 7))
        print(TreeNode.hasPathSumRecursion(root: TestData().node1, sum: 16))
        print(TreeNode.hasPathSumRecursion(root: TestData().node1, sum: 19))
        print(TreeNode.hasPathSumRecursion(root: TestData().node1, sum: 11))
    }
    
    func buildTreeWithInorderAndPostorderSolution() {
        print("根据中序和后序序列求二叉树")
        let inorder = [4, 2, 8, 5, 1, 6, 9, 3, 7]
        let postorder = [4, 8, 5, 2, 9, 6, 7, 3, 1]
        let rootNode = TreeNode.buildTree(inorder: inorder, postorder: postorder)
        print(TreeNode.inorderTraverseIteration(root: rootNode))
        print(TreeNode.postorderTraverseIteration(root: rootNode))
    }
    
    func buildTreeWithInorderAndPreorderSolution() {
        print("根据中序和前序序列求二叉树")
        let inorder = [4, 2, 8, 5, 1, 6, 9, 3, 7]
        let pretorder = [1, 2, 4, 5, 8, 3, 6, 9, 7]
        let rootNode = TreeNode.buildTree(inorder: inorder, preorder: pretorder)
        print(TreeNode.inorderTraverseIteration(root: rootNode))
        print(TreeNode.preorderTraverseIteration(root: rootNode))
    }
    
    func lowestCommonAncestorSolution() {
        print("最近公共祖先")
        let root = TestData().node1
        print(TreeNode.lowestCommonAncestor(root: root, nodeOne: TestData().node2, nodeTwo: TestData().node3)?.val)
        print(TreeNode.lowestCommonAncestor(root: root, nodeOne: TestData().node2, nodeTwo: TestData().node4)?.val)
        print(TreeNode.lowestCommonAncestor(root: root, nodeOne: TestData().node2, nodeTwo: TestData().node5)?.val)
        print(TreeNode.lowestCommonAncestor(root: root, nodeOne: TestData().node2, nodeTwo: TestData().node6)?.val)
        print(TreeNode.lowestCommonAncestor(root: root, nodeOne: TestData().node2, nodeTwo: TestData().node7)?.val)
        print(TreeNode.lowestCommonAncestor(root: root, nodeOne: TestData().node2, nodeTwo: TestData().node8)?.val)
        print(TreeNode.lowestCommonAncestor(root: root, nodeOne: TestData().node2, nodeTwo: TestData().node9)?.val)
    }
    
    func isValidBSTSolution() {
        print("验证二叉搜索树")
        print(TreeNode.isValidBST(root: TestData.binarySearchTreeNode()))
    }
    
    func searchBSTSolution() {
        print("搜索二叉搜索树")
        print(TreeNode.searchBST(root: TestData.binarySearchTreeNode(), val: 2)?.val)
        print(TreeNode.searchBST(root: TestData.binarySearchTreeNode(), val: 6)?.val)
        print(TreeNode.searchBST(root: TestData.binarySearchTreeNode(), val: 3)?.val)
        print(TreeNode.searchBST(root: TestData.binarySearchTreeNode(), val: 5)?.val)
    }
}
