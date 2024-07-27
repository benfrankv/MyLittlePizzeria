//
//  MLPPizzaDetailsViewController.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 21/07/24.
//

import UIKit
import Lottie

class MLPPizzaDetailsViewController: UIViewController {
    
    private var viewModel: MLPPizzaDetailsViewModel
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var ingredients: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ingredients"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        
        label.accessibilityLabel = nil
        
        return label
    }()
    
    private lazy var tblIngredients: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var lycTableView: NSLayoutConstraint?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        tblIngredients.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        //view.backgroundColor = .systemPink
    }
    
    init(pizza: Pizza){
        self.viewModel = MLPPizzaDetailsViewModel(pizza: pizza)
        super.init(nibName: nil, bundle: nil)
        
        if var myLycTableView = self.lycTableView{
            myLycTableView = tblIngredients.heightAnchor.constraint(equalToConstant: 300)
            NSLayoutConstraint.activate([
                myLycTableView
            ])
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightAnchor.isActive = true
        contentViewHeightAnchor.priority = .required - 1
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
        ])
        
        let infoStack = UIStackView()
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.axis = .vertical
        infoStack.distribution = .fill
        
        let animationView = LottieAnimationView(name: "pizza")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        
        
        infoStack.addArrangedSubview(animationView)
        infoStack.addArrangedSubview(ingredients)
        infoStack.addArrangedSubview(tblIngredients)
        
        
        contentView.addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalToConstant: 200),
            animationView.widthAnchor.constraint(equalToConstant: 200),
            tblIngredients.heightAnchor.constraint(equalToConstant: 300),
            infoStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
        ])
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

extension MLPPizzaDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.ingredientsCount)
        return viewModel.ingredientsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)

        let ingredient = viewModel.getIngredient(at: indexPath)
        
        var cellConfigurator =  cell.defaultContentConfiguration()
        
        cellConfigurator.text = ingredient
        
        cell.contentConfiguration = cellConfigurator
        cell.selectionStyle = .none

        return cell
    }
    
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        lycTableView?.constant = tableView.contentSize.height
    }
    
    
}
