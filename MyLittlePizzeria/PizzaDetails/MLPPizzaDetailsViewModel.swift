//
//  MLPPizzaDetailsViewModel.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 21/07/24.
//

import Foundation

class MLPPizzaDetailsViewModel {
    private var pizza: Pizza
    let cellIdentifier = "pizzasCellIdentifier"
    var title: String { pizza.name }
    var ingredientsCount: Int { pizza.ingredients.count }
    
    init(pizza: Pizza){
        self.pizza = pizza
    }
    
    func getIngredient(at indexPath: IndexPath) -> String {
        pizza.ingredients[indexPath.row]
    }
}
