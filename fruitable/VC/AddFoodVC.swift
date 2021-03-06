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
    
    @IBOutlet weak var tfCost: UITextField!
    @IBOutlet weak var tfWeight: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    var passedFoodSpecific: FoodSpecific?
    var passedFood: Food?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfCost.delegate = self
        tfWeight.delegate = self
        tfName.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(dropKB))
        self.view.addGestureRecognizer(tap)

        setUpUI()

        
        tfCost.addTarget(self, action: #selector(textFieldDidChangeCurrency(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardRise(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFall(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dropKB(){
        self.view.endEditing(true)
    }
    
    @objc func keyboardRise(_ notification: Notification){
        if let rect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardHeight = rect.cgRectValue.height
            btnAdd.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
        }
    }
    @objc func keyboardFall(_ notification: Notification){
        btnAdd.transform = .identity
    }
    
    //MARK: - Set Up Page
    func setUpUI(){
        if let passed = passedFoodSpecific {
            btnAdd.setTitle("Edit", for: .normal)
            if let name = passedFoodSpecific?.name{
                title = "Edit \(name)"
            }
            tfName.text = passed.name
            tfCost.text = passed.cost
            tfWeight.text = passed.weight
        } else if let name = passedFood?.name{
            title = "Add \(name)"
        }
        
    }
    
    //MARK: - IBActions
    
    @IBAction func addItemPress(_ sender: AnyObject){
        
        if tfName.text?.count == 0{
            tfName.shake()
            return
        }
        
        if let cost = tfCost.text, let weight = tfWeight.text, let name = tfName.text{
            if let passed = passedFoodSpecific{
                passed.cost = cost
                passed.weight = weight
                passed.name = name
                saveContext()
                self.navigationController?.popViewController(animated: true)
            } else if let passedFood = passedFood{
                let food = FoodSpecific.init(context: context)
                food.cost = cost
                food.date = Date()
                food.weight = weight
                food.name = name
                print("the passed food set", passedFood)
                food.food = passedFood
                saveContext()
                self.navigationController?.popViewController(animated: true)
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
    
    @objc func textFieldDidChangeCurrency(_ textField: UITextField){
        if let currencyFormat = textField.text?.currencyInputFormatting(){
            textField.text = currencyFormat
        }
    }


}

extension AddFoodVC: UITextFieldDelegate{
    
}
