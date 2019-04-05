//
//  FoodDetailsVC.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/4/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit
import CoreData

class FoodDetailsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var foodSpecifics: [FoodSpecific] = []
    var passedFood: Food?
    var spacing: CGFloat = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        getData()
        
        self.navigationItem.setRightBarButton(.init(barButtonSystemItem: .add, target: self, action: #selector(segueAddVC)), animated: true)
    }
    
    @objc func segueAddVC(){
        guard let passedFood = passedFood else{
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "AddFoodVC") as? AddFoodVC{
            vc.passedFood = passedFood
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - Core Data get/save
    func getData(){
        guard let passedFoodName = passedFood?.name else{
            return
        }
        let fetchRequest = NSFetchRequest<FoodSpecific>(entityName: "FoodSpecific")
        fetchRequest.predicate = NSPredicate(format: "food.name CONTAINS %@", passedFoodName)
        do{
            foodSpecifics = try context.fetch(fetchRequest)
        } catch{
            print("fetch request specific fail", error.localizedDescription)
        }
    }
    func saveData(){
        do{
            try context.save()
        } catch{
            print("error saving data", error.localizedDescription)
        }
        
    }

}

//MARK: - UICollectionView DataSource
extension FoodDetailsVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FoodSpecificCell{
            cell.configure(foodSpecific: foodSpecifics[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodSpecifics.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}

extension FoodDetailsVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Double((collectionView.frame.width - spacing) / 2)
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}

//MARK: - UICollectionView Delegate

extension FoodDetailsVC: UICollectionViewDelegate{
    
}
