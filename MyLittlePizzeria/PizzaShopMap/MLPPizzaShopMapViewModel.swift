//
//  MLPPizzaShopMapViewModel.swift
//  MyLittlePizzeria
//
//  Created by Diplomado on 27/07/24.
//

import CoreLocation
import UIKit

protocol MLPPizzaShopMapViewModelDelegate where Self: UIViewController {
    func showPizzaShopLocation(coordinate: CLLocationCoordinate2D)
    func showRouteBetween(userLocation: CLLocationCoordinate2D, pizzaLocation: CLLocationCoordinate2D)
}

class MLPPizzaShopMapViewModel: NSObject {
    private let locationManager = CLLocationManager()
    
    private let pizzaShopLocation: CLLocationCoordinate2D?
    private var userLocation: CLLocationCoordinate2D?
    
    weak var delegate: MLPPizzaShopMapViewModelDelegate?
   
    init(pizzaShopLocation: CLLocationCoordinate2D?) {
        self.pizzaShopLocation = pizzaShopLocation
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func shouldShowPizzaShopLocation() {
        guard let location = pizzaShopLocation else { return }
        delegate?.showPizzaShopLocation(coordinate: location)
    }
    
    func shouldShowDirectionsToPizzaShop() {
        guard let userLocation, let pizzaShopLocation = pizzaShopLocation else { return }
        
        delegate?.showRouteBetween(userLocation: userLocation,
                                   pizzaLocation: pizzaShopLocation)
    }
}

extension MLPPizzaShopMapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        
        userLocation = coordinate
    }
}
