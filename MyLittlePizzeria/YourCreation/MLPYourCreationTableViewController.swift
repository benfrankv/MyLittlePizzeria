//
//  MLPYourCreationTableViewController.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 21/07/24.
//

import UIKit

protocol MLPYourCreationTableViewControllerDelegate {
    func updatePizzaList()
}

class MLPYourCreationTableViewController: UITableViewController {
    
    var viewModel: MLPYourCreationViewModel
    var delegate: MLPYourCreationTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addTapped))
    }
    
    init(arrPizzas: [Pizza]) {
        self.viewModel = MLPYourCreationViewModel(arrPizzas: arrPizzas)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.ingredientsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)

        let ingredient = viewModel.ingredient(at: indexPath)
        
        var cellConfigurator =  cell.defaultContentConfiguration()
        
        cellConfigurator.text = ingredient
        
        cell.contentConfiguration = cellConfigurator
        cell.selectionStyle = .none
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = .systemBackground

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cell: UITableViewCell = tableView.cellForRow(at: indexPath) ?? UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        if cell.isSelected && cell.selectedBackgroundView != nil && cell.selectedBackgroundView?.backgroundColor == .systemBackground{
            cell = selectApparence(cell)
        }else{
            cell = unSelectApparence(cell)
        }
        viewModel.addIngredients(at: indexPath)
    }
    
    func selectApparence(_ cell: UITableViewCell) -> UITableViewCell {
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = .systemRed
        return cell
    }
    
    func unSelectApparence(_ cell: UITableViewCell) -> UITableViewCell {
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = .systemBackground
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    @objc func addTapped(){
        // Create the alert controller
        let alertController = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
        
        // Add a text field to the alert controller
        alertController.addTextField { textField in
            textField.placeholder = "Enter your name here"
        }
        
        // Add an action to the alert controller
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            // Handle the action when the "Save" button is tapped
            if let textField = alertController.textFields?.first {
                let enteredText = textField.text ?? ""
                self.viewModel.setName(enteredText)
                self.delegate?.updatePizzaList()
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        // Add the "Save" action to the alert controller
        alertController.addAction(saveAction)
        
        // Add a cancel action to the alert controller (optional)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
