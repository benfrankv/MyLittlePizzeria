//
//  MLPYourCreationViewModel.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 21/07/24.
//

import UIKit

class MLPYourCreationViewModel: Globals {
    private var ingredients = [String]()
    private var yourPizza = Pizza(name: "", ingredients: [])
    private var arrPizzas: [Pizza]
    let cellIdentifier = "pizzasCellIdentifier"
    let title = "Your Creation"
    var ingredientsCount: Int { ingredients.count }
    
    init(arrPizzas: [Pizza]) {
        self.arrPizzas = arrPizzas
        super.init()
        self.ingredients = self.loadYourCreations()
        
    }
    
    private func loadYourCreations() -> [String] {
        guard let ingredients = globalPizzaObject?.ingredients
        else {
            assertionFailure("Cannot read Pizza-info file")
            return []
        }
        return ingredients
    }
    
    @objc
    private func saveYourCreation() {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first
        else { return }
        
        let filename = "MyPizzas.json"
        let fileURL = documentsDirectory.appending(component: filename)
        
        do {
            if FileManager.default.fileExists(atPath: fileURL.path()) {
                try FileManager.default.removeItem(atPath: fileURL.path() )
            } else {
                print("FILE NOT AVAILABLE")
            }
            
            let yourCreationData = try JSONEncoder().encode(self.arrPizzas)
            let jsonYourCreationn = String(data: yourCreationData, encoding: .utf8)
            
            try jsonYourCreationn?.write(to: fileURL,
                                           atomically: true,
                                           encoding: .utf8)
        } catch {
            assertionFailure("Failed storing your pizza")
        }
    }
    
    func ingredient(at indexPath: IndexPath) -> String {
        ingredients[indexPath.row]
    }
    
    func addIngredients(at indexPath: IndexPath) {
        let ingredient = ingredient(at: indexPath)
        if yourPizza.ingredients.contains(ingredient) {
            self.yourPizza.ingredients = yourPizza.ingredients.filter({ $0 != ingredient })
        }else{
            self.yourPizza.ingredients.append(ingredient)
        }
    }
    
    func setName(_ name: String) {
        self.yourPizza.name = name
        self.arrPizzas.append(yourPizza)
        self.saveYourCreation()
    }
    
}
