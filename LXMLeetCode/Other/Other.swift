//
//  Other.swift
//  LXMLeetCode
//
//  Created by kook on 2018/6/18.
//  Copyright © 2018年 duowan. All rights reserved.
//

import Foundation


class OtherSolution {
    
    //191. 位1的个数
    func hammingWeight(_ n: UInt) -> Int {
        var result: Int = 0
        var current = n
        while (current != 0) {
            if (current % 2 != 0) {
                result += 1;
            }
            current = current >> 1;
        }
        return result;
    }
}
