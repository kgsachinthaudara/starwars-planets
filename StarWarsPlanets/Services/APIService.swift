//
//  APIService.swift
//  StarWarsPlanets
//
//  Created by Sachintha on 2021-11-14.
//

import Foundation
import Combine

// Error enum
enum APIError: Error {
    case networkError(description: String)
    case responseError(description: String)
    case unknownError(description: String)
}

// APIService
/**
 This handle all the async data fetch functionalities with reactive manner by using Combine
 */
class APIService: ObservableObject {
    @Published var response = [Planet]()
    @Published var errorMessage: String?
    
    private var publisherRequest: Cancellable? {
        didSet {oldValue?.cancel() }
    }
    
    // Deallocate with cancel the subscription and release the memory
    deinit {
        publisherRequest?.cancel()
    }
    
    // Load the star wars planets form the swapi
    func loadPlanets() -> AnyPublisher<[Planet], Error> {
        let url = URL(string: "https://swapi.dev/api/planets");
        let request = try! URLRequest(url: url!);
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .retry(3)
            .mapError { error -> Error in
                // Handle Network errors
                switch error {
                case URLError.cannotFindHost:
                    return APIError.networkError(description: error.localizedDescription)
                default:
                    return APIError.unknownError(description: error.localizedDescription)
                }
            }
            .map{ $0.data }
            .decode(type: PlanetResponse.self, decoder: JSONDecoder())
            .map{ $0.results } // Map PlanetResponse results
            .mapError { error -> Error in
                // Handle JSONDecode errors
                switch error {
                case DecodingError.keyNotFound, DecodingError.typeMismatch:
                    return APIError.responseError(description: error.localizedDescription)
                default:
                    return APIError.unknownError(description: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
        
        self.publisherRequest = publisher.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                    switch value {
                    case .finished:
                        print("API Fetch Done.");
                    case .failure(let error):
                        print(error);
                        self.errorMessage = error.localizedDescription;
                    }
            }, receiveValue: {data in
                self.response = data; // Set the array of planets to the response
            })
        
        return publisher;
    }
}
