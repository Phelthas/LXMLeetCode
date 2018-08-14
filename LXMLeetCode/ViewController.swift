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
        
        let aaa: [[Character]] = [["1","1","1","1","0"],["1","1","0","1","0"],["1","1","0","0","0"],["0","0","0","0","0"]]
        ArraySolution().numIslands(aaa)
        
        
        let one = ListNode(x: 1)
        let two = ListNode(x: 9)
        two.next = ListNode(x: 9)
        LinkedListSolution().addTwoNumbers(one, two)
        
        
        BacktrackingSolution().permute([1, 2, 3])
        
        let board: [[Character]] = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
        let word = "ABCB"
        BacktrackingSolution().exist(board, word)
        
        SortSolution().merge([Interval(1, 3), Interval(2, 6) ,Interval(8, 10) ,Interval(15, 18)])
        let matrix = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20],[21,22,23,24,25]]
        SortSolution().searchMatrix(matrix, 5)
        
        
        
        DynamicProgrammingSolution().coinChange([186,419,83,408], 6249)
        
        let codec = Codec()
        codec.serialize(root: codec.deserialize(data: "1,2,3,null,null,4,5"))
        
        MathSolution().mySqrt(4)
        MathSolution().fractionToDecimal(1, 11)
        
        var array = [3, 2, 2, 3]
        LibrarySolution().removeElement(&array, 3)
        
        ArraySolution().dominantIndex([0,0,0,1])
        let matrixOne = [[1,2,3],[4,5,6],[7,8,9]]
        ArraySolution().findDiagonalOrder(matrixOne)
        ArraySolution().spiralOrder(matrixOne)
        
        
    }
    
}

