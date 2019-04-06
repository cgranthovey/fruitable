//
//  CommonUI.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/4/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit

class CommonUI {

    fileprivate static var _instance = CommonUI()
    static var instance: CommonUI{
        return _instance
    }
    
    var bananaYellow: UIColor{
        return UIColor().getColor(red: 255, green: 225, blue: 53, alpha: 1)
    }
    var tomatoRed: UIColor{
         return UIColor().getColor(red: 255, green: 91, blue: 71, alpha: 1)
    }
    var lightGray: UIColor{
        return UIColor().getColor(red: 240, green: 240, blue: 240, alpha: 1)
    }
}
