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
    @IBOutlet weak var btnAdd: UIButton!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dropKB))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardRaise(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFall(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardRaise(_ notification: Notification){
        print("keyboardRaise1")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardHeight = keyboardFrame.cgRectValue.height
            print("keyboardRaise2")
            self.btnAdd.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
//                self.btnAdd.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
//            }, completion: nil)
        }
    }
    @objc func keyboardFall(_ notification: Notification){
        self.btnAdd.transform = .identity

//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
//        }, completion: nil)
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

    @IBAction func addBtnPress(_ sender: AnyObject){
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{
            return
        }
        
        
        guard let name = tfName.text else{
            return
        }
        let food = Food(context: context)
        food.name = name

        
        if let img = imgView.image, let data = img.jpegData(compressionQuality: 0.7){
            let seconds = String(Date().timeIntervalSince1970)
            let url = url.appendingPathComponent(seconds)
            do{
                try data.write(to: url)
            } catch{
                print("error saving image", error.localizedDescription)
            }
            
            print("the seconds", seconds)
            food.imageFilePath = seconds
        }
        
        saveContext()
        self.navigationController?.popViewController(animated: true)
        
    }

    //MARK: - Functions
    
    func getImage(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func saveContext(){
        do{
            try context.save()
        } catch{
            print("error saving context -", error.localizedDescription)
        }
    }
    
    @objc func dropKB(){
        self.view.endEditing(true)
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
