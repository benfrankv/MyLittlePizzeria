//
//  PizzaData.swift
//  MyLittlePizzeria
//
//  Created by Ben Frank V. on 20/07/24.
//

import Foundation

struct Pizzeria: Codable {
    let name: String
    let address: String
    let coordinates: Coordinates?
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct Pizza: Codable {
    var name: String
    var ingredients: [String]
}

struct PizzaData: Codable {
    let pizzerias: [Pizzeria]?
    let pizzas: [Pizza]?
    let ingredients: [String]?
}
