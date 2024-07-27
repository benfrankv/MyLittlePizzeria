//
//  MLPPizzasViewModel.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 20/07/24.
//

import Foundation

class MLPPizzasViewModel: Globals {
    private var pizzaList = [Pizza]()
    
    let cellIdentifier = "pizzasCellIdentifier"
    let title = "Pizzas"
    var pizzaCount: Int { pizzaList.count }
    
    override init() {
        super.init()
        pizzaList = loadPizzasData()
    }
    
    private func loadPizzasData() -> [Pizza] {
        guard let pizzas = globalPizzaObject?.pizzas
        else {
            assertionFailure("Cannot read Pizza-info file")
            return []
        }
        
        return pizzas
    }
    
    func pizza(at indexPath: IndexPath) -> Pizza {
        pizzaList[indexPath.row]
    }
}

