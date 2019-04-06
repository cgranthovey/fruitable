//
//  FoodGeneralCell.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/5/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit

class FoodGeneralCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var documentsURL: URL?{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    override func awakeFromNib() {
        backgroundColor = CommonUI.instance.lightGray
    }
    
    func configure(food: Food){
        if let name = food.name{
            lblName.text = name
        }
        if let assetName = food.assetName{
            imageView.image = UIImage(named: assetName)
        } else if let imageFilePath = food.imageFilePath, let docURL = documentsURL{
            let fileURL = docURL.appendingPathComponent(imageFilePath)
            do {
                let data = try Data(contentsOf: fileURL)
                imageView.image = UIImage(data: data)
            } catch{
                print("error getting image", error.localizedDescription)
            }
            
        }
    }
    
}
