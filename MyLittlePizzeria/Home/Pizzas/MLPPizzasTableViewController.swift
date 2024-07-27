//
//  MLPPizzasTableViewController.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 20/07/24.
//

import UIKit

class MLPPizzasTableViewController: UITableViewController {
    
    let viewModel = MLPPizzasViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.pizzaCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)

        let pizza = viewModel.pizza(at: indexPath)
        
        var cellConfigurator =  cell.defaultContentConfiguration()
        
        cellConfigurator.text = pizza.name
        
        cell.contentConfiguration = cellConfigurator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pizza = viewModel.pizza(at: indexPath)
        let detailViewController = MLPPizzaDetailsViewController(pizza: pizza)
        navigationController?.pushViewController(detailViewController, animated: true)
    }

}
