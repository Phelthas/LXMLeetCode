//
//  StringSolution.swift
//  LXMLeetCode
//
//  Created by luxiaoming on 2018/5/19.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation


class StringSolution {
    
    // func reverseString(_ s: String) -> String {
    //     return String(s.reversed())
    // }
    
    // func reverseString(_ s: String) -> String {
    //     var resultString = ""
    //     for char in s {
    //         resultString.insert(char, at: String.Index.init(encodedOffset: 0))
    //     }
    //     return resultString
    // }
    
    func reverseString(_ s: String) -> String {
        guard s.count > 0 else { return s }
        var array = Array(s)
        var resultString = ""
        for i in (0 ..< array.count).reversed() {
            resultString.append(array[i])
        }
        return resultString
    }
    
}
