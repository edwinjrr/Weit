//
//  WeitModel.swift
//  Weit
//
//  Created by Edwin Rodriguez on 2/13/15.
//  Copyright (c) 2015 Edwin Rodriguez. All rights reserved.
//

import Foundation

class WeitModel {
    
    func addOne(weight: Int) -> Int {
        return weight + 1
    }
    
    func removeOne(weight: Int) -> Int {
        return weight - 1
    }
    
    func resetCount(weight: Int) -> Int {
        return (weight * 0) + 10
    }
}
