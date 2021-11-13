//
//  PlanetResponse.swift
//  StarWarsPlanets
//
//  Created by Sachintha on 2021-11-14.
//

import Foundation
import Combine

struct PlanetResponse: Codable {
    var next: String
    var results : [Planet]
}
