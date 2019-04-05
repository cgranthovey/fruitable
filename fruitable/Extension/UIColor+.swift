//
//  UIColor+.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/4/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    func getColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
