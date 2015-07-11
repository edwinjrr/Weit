//
//  Exercises.swift
//  Weit
//
//  Created by Edwin Rodriguez on 2/10/15.
//  Copyright (c) 2015 Edwin Rodriguez. All rights reserved.
//

import UIKit

class Exercises: NSObject, NSCoding {
    var name = ""
    var weight = [10,20,30]
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        weight = aDecoder.decodeObjectForKey("Weight") as! Array
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(weight, forKey: "Weight")
    }
}