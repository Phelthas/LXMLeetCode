//
//  LibrarySolution3.swift
//  LXMLeetCode
//
//  Created by kook on 2018/11/9.
//  Copyright © 2018 duowan. All rights reserved.
//

import Foundation

extension LibrarySolution {
    
    /// 205. 同构字符串
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        let arrayS = [Character](s)
        let arrayT = [Character](t)
        var dict1 = [Character : Character]()
        var dict2 = [Character : Character]()
        for i in 0 ..< arrayS.count {
            let tempS = arrayS[i]
            let tempT = arrayT[i]
            if let value = dict1[tempS] {
                if value != tempT {
                    return false
                }
            } else if let value = dict2[tempT] {
                if value != tempS {
                    return false
                }
            } else {
                dict1[tempS] = tempT
                dict2[tempT] = tempS
            }
        }
        return true
    }
}
