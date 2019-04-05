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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("check location ", fileManager.first)
    }
    
    @IBAction func addItemPress(_ sender: AnyObject){
        print("addItemPress1")
        if let cost = tfCost.text, let weight = tfWeight.text, let name = tfName.text{
            print("addItemPress2")
         //   let food = Food.init(name: name, cost: cost, date: Date(), weight: weight)
            let food = Food.init(context: context)
            print("addItemPress3")
            food.cost = cost
            print("addItemPress3.1")

            food.date = Date()
            print("addItemPress3.2")

            food.weight = weight
            print("addItemPress3.3")

            food.name = name
            print("addItemPress4")
            saveContext()
        }
    }
    
    func saveContext(){
        print("save context")
        do{
        print("save context1")
            try context.save()
            print("save context2")
        } catch{
            print("error saving context", error.localizedDescription)
        }
    }


}
