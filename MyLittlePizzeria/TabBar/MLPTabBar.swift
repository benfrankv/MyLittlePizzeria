//
//  MLPTabBar.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 20/07/24.
//

import UIKit

class MLPTabBar: UITabBarController {

    let PizzasVC = UINavigationController(rootViewController: MLPPizzasTableViewController())
    let YourCrationsVC = UINavigationController(rootViewController: MLPYourCreationsTableViewController())
    let PizzaShopsVC = UINavigationController(rootViewController: MLPPizzaShopsTableViewController())
    var arrViews: [UIViewController] =  []
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            arrViews = [PizzasVC, YourCrationsVC, PizzaShopsVC]
            self.setViewControllers(arrViews, animated: true)
            
            let pizzasIcon: UIImage? = UIImage(named: "PizzaFiveEighths")
            let yourCreationsIcon: UIImage? = UIImage(named: "Chef")
            let pizzaShopIcon: UIImage? = UIImage(named: "Shop")
            
            guard let items = self.tabBar.items else { return }
            
            items[0].title = "Pizzas"
            items[0].image = pizzasIcon
            items[1].title = "Your Creations"
            items[1].image = yourCreationsIcon
            items[2].title = "Pizza Shops"
            items[2].image = pizzaShopIcon
            
            self.tabBar.backgroundColor = .systemBackground
            self.tabBar.tintColor = .white
            self.tabBar.backgroundColor = .systemRed
            self.tabBar.unselectedItemTintColor = .darkGray
        }


}
