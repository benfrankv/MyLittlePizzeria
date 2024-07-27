//
//  MLPPizzaShopMapViewController.swift
//  MyLittlePizzeria
//
//  Created by Diplomado on 27/07/24.
//

import UIKit
import MapKit
import CoreLocation

class MLPPizzaShopMapViewController: UIViewController, MKMapViewDelegate {
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.showsUserLocation = true
        
        return mapView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.backgroundColor = .red
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self,
                         action: #selector(closeButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var showPizzaButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Show pizza place"
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.addTarget(self,
                         action: #selector(showPizzaShopButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var showDirectionsButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Show directions"
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.addTarget(self,
                         action: #selector(showDirectionsToPokemon),
                         for: .touchUpInside)
        return button
    }()
    
    private var viewModel: MLPPizzaShopMapViewModel
    
    init(pizzaShopLocation: Coordinates?) {
        if let location = pizzaShopLocation {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude,
                                                    longitude: location.longitude)
            viewModel = MLPPizzaShopMapViewModel(pizzaShopLocation: coordinate)
        } else {
            viewModel = MLPPizzaShopMapViewModel(pizzaShopLocation: nil)
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        mapView.delegate = self
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        view.addSubview(closeButton)

        let pizzaShopInteractionStackView = UIStackView()
        pizzaShopInteractionStackView.translatesAutoresizingMaskIntoConstraints = false
        pizzaShopInteractionStackView.axis = .horizontal
        pizzaShopInteractionStackView.distribution = .fillProportionally
        
        pizzaShopInteractionStackView.addArrangedSubview(showPizzaButton)
        pizzaShopInteractionStackView.addArrangedSubview(showDirectionsButton)
        
        view.addSubview(pizzaShopInteractionStackView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            pizzaShopInteractionStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pizzaShopInteractionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc
    private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func showPizzaShopButtonTapped() {
        viewModel.shouldShowPizzaShopLocation()
    }

    @objc
    private func showDirectionsToPokemon() {
        viewModel.shouldShowDirectionsToPizzaShop()
    }
}

extension MLPPizzaShopsTableViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = .red
        renderer.lineWidth = 10.0
        return renderer
    }
}

extension MLPPizzaShopMapViewController: MLPPizzaShopMapViewModelDelegate {
    func showPizzaShopLocation(coordinate: CLLocationCoordinate2D) {
        let pokemonAnnotation = MKPointAnnotation()
        pokemonAnnotation.coordinate = coordinate
        
        mapView.addAnnotation(pokemonAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: coordinate,
                                           span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                  longitudeDelta: 0.01))
        
        mapView.region = mapRegion
    }
    
    func showRouteBetween(userLocation: CLLocationCoordinate2D, pizzaLocation: CLLocationCoordinate2D) {
        let directionsRequest = MKDirections.Request()
        
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: pizzaLocation))
        
        directionsRequest.transportType = .walking
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate {[weak self] response, error in
            guard  error == nil,
                   let response,
                   let route = response.routes.first
            else { return }
            
            self?.mapView.addOverlay(route.polyline)
        }
    }
}
