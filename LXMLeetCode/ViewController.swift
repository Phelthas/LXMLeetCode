//
//  ViewController.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/4/14.
//  Copyright © 2018年 duowan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func printSolution(_ sender: UIButton) {
        let solution = Solution()
        solution.preorderTraverseSolution()
        solution.inorderTraverseSolution()
        solution.postorderTraverseSolution()
        solution.levelOrderTraverseSolution()
        solution.maxDepthSolution()
        solution.isSymmetricSolution()
        solution.hasPathSumSolution()
        solution.buildTreeWithInorderAndPostorderSolution()
        solution.buildTreeWithInorderAndPreorderSolution()
        solution.lowestCommonAncestorSolution()
        solution.isValidBSTSolution()
        solution.searchBSTSolution()
        solution.insertBSTSolution()
        solution.deleteBSTSolution()
        solution.kthLargestSolution()
        
//        solution.test()
        
        ArraySolution.removeDuplicatesSolution()
        ArraySolution.rotateRightSolution()
        ArraySolution.containsDuplicateSolution()
        ArraySolution().lengthOfLongestSubstring("abcabcbb")
        
        
        SortSolution.quickSortSolution()
        SortSolution.heapSortSolution()
        SortSolution.insertSortSolution()
        
        
        StringSolution().reverse(-123)
        StringSolution().isPalindrome("A man, a plan, a canal: Panama")
        StringSolution().myAtoi("20000000000000000000")
        StringSolution().strStr("a", "a")
        StringSolution().countAndSay(1)
        StringSolution().longestCommonPrefix(["a"])
        ArraySolution().fillClockwiseMatrix(m: 2, n: 6)
        
        
        let one = ListNode(x: 1)
        let two = ListNode(x: 9)
        two.next = ListNode(x: 9)
        LinkedListSolution().addTwoNumbers(one, two)
    }
    
}

