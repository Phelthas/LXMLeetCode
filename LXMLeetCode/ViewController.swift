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
        
        
        SortSolution.quickSortSolution()
        SortSolution.heapSortSolution()
        SortSolution.insertSortSolution()
        
        
        StringSolution().reverse(-123)
        ArraySolution().fillClockwiseMatrix(m: 2, n: 6)
    }
    
}

