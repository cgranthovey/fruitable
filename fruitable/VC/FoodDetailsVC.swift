//
//  FoodDetailsVC.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/4/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit

class FoodDetailsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodSpecific: [FoodSpecific] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

}

//MARK: - UICollectionView DataSource
extension FoodDetailsVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodSpecific.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

//MARK: - UICollectionView Delegate

extension FoodDetailsVC: UICollectionViewDelegate{
    
}
