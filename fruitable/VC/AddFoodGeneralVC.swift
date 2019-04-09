//
//  AddFoodGeneralVC.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/6/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import UIKit
import Photos

class AddFoodGeneralVC: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var imgView: UIImageView!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func addImageBtnPress(_ sender: AnyObject){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.getImage(sourceType: .camera)
        }
        let actionPhotoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.getImage(sourceType: .photoLibrary)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(actionCamera)
        alertController.addAction(actionPhotoLibrary)
        alertController.addAction(actionCancel)
        present(alertController, animated: true, completion: nil)
    }
    
    func getImage(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction func addBtnPress(_ sender: AnyObject){
        
        guard let name = tfName.text else{
            return
        }
        
        let food = Food(context: context)
        food.name = name
    }
    
    func saveContext(){
        do{
            try context.save()
        } catch{
            print("error saving context -", error.localizedDescription)
        }
    }
    
}

//MARK: - ImagePicker Delegate
extension AddFoodGeneralVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imgView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
