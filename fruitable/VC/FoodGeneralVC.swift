//
//  FoodGeneralVC.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/5/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit
import CoreData

class FoodGeneralVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foods = [Food]()
    var spacingBetweenCells: CGFloat = 10
    var cellsPerRow: CGFloat = 2
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        firstTimeLoading()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.keyboardAppearance = .light
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.searchBarStyle = .minimal
        navigationItem.searchController = searchController
        navigationItem.searchController?.definesPresentationContext = true
//        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.delegate = self
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func firstTimeLoading(){
        if !UserDefaults.standard.bool(forKey: "loadedPreviously"){
            UserDefaults.standard.set(true, forKey: "loadedPreviously")
            DefaultFood.instance.saveDefaults()
        }
    }
    
    @objc func dropKB(){
        self.view.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func addFoodBtnPress(_ sender: AnyObject){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        print("addFoodBtnPress1")
        if let vc = storyboard.instantiateViewController(withIdentifier: "AddFoodGeneralVC") as? AddFoodGeneralVC{
            print("addFoodBtnPress2")
            self.navigationController?.pushViewController(vc, animated: true)
            vc.delegate = self
        }
    }
    
    //MARK: - Get Data
    func getData(predicate: NSPredicate? = nil){
        let fetchRequest: NSFetchRequest = NSFetchRequest<Food>(entityName: "Food")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        if let predicate = predicate{
            print("show the predicate - ", predicate)
            fetchRequest.predicate = predicate
        }
        
        do{
            foods = try context.fetch(fetchRequest)
            collectionView.reloadData()
        } catch{
            print("fetch request error: ", error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FoodDetailVC"{
            if let vc = segue.destination as? FoodDetailVC{
                if let indexesSelected = collectionView.indexPathsForSelectedItems, indexesSelected.count == 1{
                    vc.passedFood = foods[indexesSelected[0].row]
                }
            }
        }
    }

}

//MARK: - CollectionView DataSource

extension FoodGeneralVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FoodGeneralCell{
            cell.configure(food: foods[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

//MARK: - CollectionView Delegate
extension FoodGeneralVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FoodDetailVC", sender: nil)
    }
}


//MARK: - CollectionView FlowLayout
extension FoodGeneralVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edges = spacingBetweenCells * 2
        let betweenSpacing = spacingBetweenCells * (cellsPerRow - 1)
        let cellWidth = (collectionView.frame.width - betweenSpacing - edges) / cellsPerRow
        return CGSize(width: cellWidth, height: cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacingBetweenCells
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingBetweenCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: spacingBetweenCells, left: spacingBetweenCells, bottom: spacingBetweenCells, right: spacingBetweenCells)
    }
}

//MARK: - SearchController Delegate

extension FoodGeneralVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0{
            let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
            getData(predicate: predicate)
        } else{
            getData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension FoodGeneralVC: AddFoodGeneralVCDelegate{
    func getFoodAdded(food: Food){
        foods.insert(food, at: 0)
        foods.sort { (food1, food2) -> Bool in
            if let name1 = food1.name, let name2 = food2.name{
                print("names12")
                return name1 < name2
                
            }
            return false
        }
        collectionView.reloadData()
        
        for (index, item) in foods.enumerated(){
            if item.name == food.name{
                collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .top, animated: true)
            }
        }
        
        
    }
}
