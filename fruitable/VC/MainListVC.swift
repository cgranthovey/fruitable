//
//  MainListVC.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/1/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit
import CoreData

class MainListVC: UIViewController {
    
    var foods: [Food] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getContext()
    }
    
    func getContext(){
        let fetchRequest =  NSFetchRequest<Food>(entityName: "Food")
        print("getContext1")
        do{
            print("getContext2")
            foods = try context.fetch(fetchRequest)
            if foods.count > 0{
                tableView.reloadData()
                print("reload data")
            } else{
                print("no items")
                let btn = UIButton(type: .system)
                btn.setTitle("Add First Item", for: .normal)
                btn.titleLabel?.font = UIFont(name: "Menlo", size: 22)
                let color = 
                btn.tintColor = UIColor().getColor(red: 255, green: 91, blue: 71, alpha: 1).cgColor
                tableView.backgroundView = btn
                tableView.separatorStyle = .none
            }
            
            print("getContext3", foods.count)
        } catch{
            print("error fetching context", error.localizedDescription)
        }
    }
    
    func saveContext(){
        do{
            try context.save()
        } catch{
            print("error saving context -", error.localizedDescription)
        }
        
    }
    
    
}

//MARK: - TableView DataSource

extension MainListVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MainListCell{
            cell.configure(food: foods[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

//MARK: - TableView Delegate
extension MainListVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            context.delete(foods[indexPath.row])
            saveContext()
            foods.remove(at: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .bottom)
        }
    }
}

//MARK: - Search Bar Delegate
extension MainListVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let txt = searchBar.text, txt.count > 0{
            let fetchRequest = NSFetchRequest<Food>(entityName: "Food")
            print("txt - ", txt)
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", txt)
            print("txt - ", fetchRequest.predicate)
            do{
                foods = try context.fetch(fetchRequest)
                tableView.reloadData()
            } catch{
                print("error fetch request search", error.localizedDescription)
            }
        } else{
            getContext()
        }
    }
}
