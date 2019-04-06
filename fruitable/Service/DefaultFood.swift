//
//  DefaultFood.swift
//  fruitable
//
//  Created by Christopher Hovey on 4/6/19.
//  Copyright © 2019 Chris Hovey. All rights reserved.
//

import Foundation
import UIKit

class DefaultFood{
    
    fileprivate static var _instance = DefaultFood()
    static var instance: DefaultFood{
        return _instance
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveDefaults(){
        
        let apple = Food(context: context)
        apple.configure(name: "Apple", assetName: "apple")
        
        let avocado = Food(context: context)
        avocado.configure(name: "Avocado", assetName: "avocado")
        let bellPepper = Food(context: context)
        bellPepper.configure(name: "Bell Pepper", assetName: "bell-pepper")
        
        let broccoli = Food(context: context)
        broccoli.configure(name: "Broccoli", assetName: "broccoli")
        let carrot = Food(context: context)
        carrot.configure(name: "Carrot", assetName: "carrot")
        let cherry = Food(context: context)
        cherry.configure(name: "Cherry", assetName: "cherry")
        let chili = Food(context: context)
        chili.configure(name: "Chili", assetName: "chili")
        let corn = Food(context: context)
        corn.configure(name: "Corn", assetName: "corn")
        let eggplant = Food(context: context)
        eggplant.configure(name: "Eggplant", assetName: "eggplant")
        let garlic = Food(context: context)
        garlic.configure(name: "Garlic", assetName: "garlic")
        let grapes = Food(context: context)
        grapes.configure(name: "Grapes", assetName: "grapes")
        let greenOnion = Food(context: context)
        greenOnion.configure(name: "Green Onion", assetName: "greenOnion")
        
        
        
        let lemon = Food(context: context)
        lemon.configure(name: "Lemon", assetName: "lemon")
        let mango = Food(context: context)
        mango.configure(name: "mango", assetName: "mango")
        let mushroom = Food(context: context)
        mushroom.configure(name: "Mushroom", assetName: "mushroom")
        
        let onion = Food(context: context)
        onion.configure(name: "Onion", assetName: "onion2")
        let orange = Food(context: context)
        orange.configure(name: "Orange", assetName: "orange")
        let papaya = Food(context: context)
        papaya.configure(name: "Papaya", assetName: "papaya")
        let pear = Food(context: context)
        pear.configure(name: "Pear", assetName: "pear")
        let pineapple = Food(context: context)
        pineapple.configure(name: "Pineapple", assetName: "pineapple")
        let radish = Food(context: context)
        radish.configure(name: "Radish", assetName: "radish")
        let rasberry = Food(context: context)
        rasberry.configure(name: "Rasberry", assetName: "raspberry")
        let tomato = Food(context: context)
        tomato.configure(name: "Tomato", assetName: "tomato")
        
        let peas = Food(context: context)
        peas.configure(name: "Peas", assetName: "peas")
        let berries = Food(context: context)
        berries.configure(name: "Berries", assetName: "berries")
        let grenade = Food(context: context)
        grenade.configure(name: "Grenade", assetName: "grenade")
        let artichoke = Food(context: context)
        artichoke.configure(name: "Artichoke", assetName: "artichoke")
        let cabbage = Food(context: context)
        cabbage.configure(name: "Cabbage", assetName: "cabbage")
        let coconut = Food(context: context)
        coconut.configure(name: "Coconut", assetName: "coconut")
        let lime = Food(context: context)
        lime.configure(name: "Lime", assetName: "lime")
        let potato = Food(context: context)
        potato.configure(name: "Potato", assetName: "potato")
        let kiwi = Food(context: context)
        kiwi.configure(name: "Kiwi", assetName: "kiwi")
        let pumpkin = Food(context: context)
        pumpkin.configure(name: "Pumpkin", assetName: "pumpkin")
        let durian = Food(context: context)
        durian.configure(name: "Durian", assetName: "durian")
        let banana = Food(context: context)
        banana.configure(name: "Banana", assetName: "banana")
        let lettuce = Food(context: context)
        lettuce.configure(name: "Lettuce", assetName: "lettuce")
        let plum = Food(context: context)
        plum.configure(name: "Plum", assetName: "plum")
        let beet = Food(context: context)
        beet.configure(name: "Beet", assetName: "beet")
        let watermelon = Food(context: context)
        watermelon.configure(name: "Watermelon", assetName: "watermelon")

        let cucumber = Food(context: context)
        cucumber.configure(name: "Cucumber", assetName: "cucumber")
        let strawberry = Food(context: context)
        strawberry.configure(name: "Strawberry", assetName: "strawberry")
//        let watermelon = Food(context: context)
//        watermelon.configure(name: "Watermelon", assetName: "watermelon")
        
        
        
//        let items = ["watermelon", "cucumber"]
//        for item in items{
//            let newItem = Food(context: context)
//            newItem.configure(name: item.capitalized, assetName: item)
//        }
//


        
        saveContext()
    }
    
    
    
    fileprivate func saveContext(){
        do{
            try context.save()
        } catch{
            print("error saving default context", error.localizedDescription)
        }
    }
    
    
}
