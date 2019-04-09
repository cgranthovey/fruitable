//
//  FoodSpecificCell.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/6/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit

class FoodSpecificCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(foodSpecific: FoodSpecific){
        if let name = foodSpecific.name{
            nameLbl.text = name
        }
        
        var costStr = ""
        if let cost = foodSpecific.cost{
            costStr = cost
        }
        if let weight = foodSpecific.weight{
            costStr += " / \(weight)"
        }
        costLbl.text = costStr
        
        if let date = foodSpecific.date{
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            dateLbl.text = formatter.string(from: date)
        }
    }

}
