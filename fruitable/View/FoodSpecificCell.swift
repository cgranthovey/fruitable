//
//  FoodSpecificCell.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/4/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit

class FoodSpecificCell: UICollectionViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    func configure(foodSpecific: FoodSpecific){
        if let name = foodSpecific.name{
            nameLbl.text = name
        }
        if let cost = foodSpecific.cost{
            costLbl.text = cost
        }
        print("Config1")
        if let date = foodSpecific.date{
            
            let dateFormatter = DateFormatter()
            print("Config2", dateFormatter.string(from: date))
            dateLbl.text = dateFormatter.string(from: date)
        }
    }
}
