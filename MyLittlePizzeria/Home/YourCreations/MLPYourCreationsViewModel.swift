//
//  MLPYourCreationsViewModel.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 20/07/24.
//

import Foundation

class MLPYourCreationsViewModel: Globals {
    private var pizzaList = [Pizza]()
    
    let cellIdentifier = "pizzasCellIdentifier"
    let title = "Pizzas"
    var pizzaCount: Int { pizzaList.count }
    
    override init() {
        super.init()
        pizzaList = loadYourCreations()
    }
    
    private func loadYourCreations() -> [Pizza] {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory,
                                                     in: .userDomainMask).first
        else {
            assertionFailure("Cannot find the documents directory")
            return []
        }
        
        let myCreationsURL = documentsDirectoryURL.appendingPathComponent("MyPizzas.json")
        
        do {
            let myCreationsData = try Data(contentsOf: myCreationsURL)
            let myPizzasList = try JSONDecoder().decode([Pizza].self, from: myCreationsData)
            return myPizzasList
        } catch {
            return []
        }
    }
    
    func pizza(at indexPath: IndexPath) -> Pizza {
        pizzaList[indexPath.row]
    }
    
    func getPizzas() -> [Pizza] {
        pizzaList
    }
    
    func reloadPizzaList(){
        pizzaList = loadYourCreations()
    }
}
