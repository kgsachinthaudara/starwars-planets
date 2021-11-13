//
//  Planet.swift
//  StarWarsPlanets
//
//  Created by Sachintha on 2021-11-14.
//

import Foundation
import Combine

class Planet: Codable, Identifiable {
    var id: UUID
    var name: String
    var climate: String
    var orbital_period: String
    var gravity: String
    var imageUrl: String // Random generated image url
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.climate = try container.decodeIfPresent(String.self, forKey: .climate) ?? ""
        self.orbital_period = try container.decodeIfPresent(String.self, forKey: .orbital_period) ?? ""
        self.gravity = try container.decodeIfPresent(String.self, forKey: .gravity) ?? ""
        self.imageUrl = "https://picsum.photos/seed/\(Int.random(in: 0...1000))"
    }
}
