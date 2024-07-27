//
//  MLPPizzaShopsViewModel.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 20/07/24.
//

import Foundation

class MLPPizzaShopsViewModel: Globals {
    private var pizzaShops = [Pizzeria]()
    
    let cellIdentifier = "pizzasCellIdentifier"
    let title = "Pizza Shops"
    var pizzaShopsCount: Int { pizzaShops.count }
    
    override init() {
        super.init()
        pizzaShops = loadPizzaShops()
    }
    
    private func loadPizzaShops() -> [Pizzeria] {
        guard let pizzaShops = globalPizzaObject?.pizzerias
        else {
            assertionFailure("Cannot read Pizza-info file")
            return []
        }
        
        return pizzaShops
    }
    
    func pizzaShop(at indexPath: IndexPath) -> Pizzeria {
        pizzaShops[indexPath.row]
    }
}
