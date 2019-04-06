//
//  Food.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/1/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit
import CoreData

class Food: NSManagedObject {

    
    func configure(name: String, assetName: String? = nil){
        self.name = name
        self.assetName = assetName
    }

//    
//    init(_name: String, _cost: String, _date: Date, _weight: String){
//        super.init()
//        self.name = _name
//        self.cost = _cost
//        self.date = _date
//        self.weight = _weight
//    }
}
