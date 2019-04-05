//
//  AddFoodVC.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/1/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit
import CoreData

class AddFoodVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tfCost: UITextField!
    @IBOutlet weak var tfWeight: UITextField!
    @IBOutlet weak var tfName: UITextField!
    
    var passedFoodSpecific: FoodSpecific?
    var passedFood: Food?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("fileManager", fileManager.first)
    }
    
    @IBAction func addItemPress(_ sender: AnyObject){
        
        if let passedFood = passedFood{
            if let cost = tfCost.text, let weight = tfWeight.text, let name = tfName.text{
                let food = FoodSpecific.init(context: context)
                food.cost = cost
                food.date = Date()
                food.weight = weight
                food.name = name
                food.food = passedFood
                saveContext()
            }
        } else{
            if let cost = tfCost.text, let weight = tfWeight.text, let name = tfName.text{
                let food = Food.init(context: context)
                food.cost = cost
                food.date = Date()
                food.weight = weight
                food.name = name
                saveContext()
            }
        }

    }
    
    func saveContext(){
        do{
            try context.save()
        } catch{
            print("error saving context", error.localizedDescription)
        }
    }


}
