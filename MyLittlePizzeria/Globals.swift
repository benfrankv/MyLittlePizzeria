//
//  Globals.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 21/07/24.
//

import Foundation

class Globals {
    internal let pizzaDataFileName = "pizza-info"
    internal let pizzaDataFileExtension = "json"
    
    var globalPizzaObject: PizzaData?
    
    init() {
        globalPizzaObject = loadPizzaData()
    }
    
    private func loadPizzaData() -> PizzaData? {
        guard let fileURL = Bundle.main.url(forResource: pizzaDataFileName,
                                            withExtension: pizzaDataFileExtension),
              let data = try? Data(contentsOf: fileURL),
              let allData = try? JSONDecoder().decode(PizzaData.self, from: data),
              let pizzas = allData.pizzas
        else {
            assertionFailure("Cannot read Pizza-info file")
            return nil
        }
        
        return allData
    }
}
