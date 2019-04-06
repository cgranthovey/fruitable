//
//  FoodDetailVC.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/6/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit
import CoreData

class FoodDetailVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var foodSpecifics = [FoodSpecific]()
    var passedFood: Food? = nil
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("my files ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        if let passedFood = passedFood, let name = passedFood.name{
            title = name
        }
        
        
        getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddFoodVC"{
            if let vc = segue.destination as? AddFoodVC, let passedFood = passedFood{
                vc.passedFood = passedFood
            }
        }
    }
    
    func getData(){
        guard let passedFood = passedFood else{
            return
        }
        let fetchRequest = NSFetchRequest<FoodSpecific>(entityName: "FoodSpecific")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        print("what is the passed food", passedFood)
        fetchRequest.predicate = NSPredicate(format: "food = %@", passedFood)
        
        do{
            foodSpecifics = try context.fetch(fetchRequest)
            
            if foodSpecifics.count == 0{
                print("enter here")
                let bgView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
                let addBtn = UIButton(type: .system)
                addBtn.frame = CGRect(x: 0, y: bgView.frame.height / 4, width: bgView.frame.width, height: 120)
                addBtn.setTitle("Add First Item", for: .normal)
                addBtn.setTitleColor(CommonUI.instance.tomatoRed, for: .normal)
                addBtn.titleLabel?.font = UIFont(name: "Menlo", size: 24)
                addBtn.addTarget(self, action: #selector(addItemPress), for: .touchUpInside)
                bgView.addSubview(addBtn)
                tableView.backgroundView = bgView
            }
            
            tableView.reloadData()
        } catch{
            print("error getting food", error.localizedDescription)
        }
    }
    
    @objc func addItemPress(){
        performSegue(withIdentifier: "AddFoodVC", sender: nil)
    }

}

//MARK: - TableView Data Source
extension FoodDetailVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FoodSpecificCell{
            cell.configure(foodSpecific: foodSpecifics[indexPath.row])
            return cell
        }
        return FoodSpecificCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodSpecifics.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

//MARK: - TableView Delegate
extension FoodDetailVC: UITableViewDelegate{
    
}


