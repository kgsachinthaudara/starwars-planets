//
//  StarWarsPlanetsTests.swift
//  StarWarsPlanetsTests
//
//  Created by Sachintha on 2021-11-15.
//

import Foundation
import Combine
import XCTest

class StarWarsPlanetsTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>();
    
    func testGetPlanets() throws {
        let apiService = APIService()
        
        apiService.loadPlanets()
            .sink(receiveCompletion: { value in
                switch value {
                case .finished:
                    print("API Fetch Done.");
                case .failure(let error):
                    print(error);
                    XCTAssertFalse(true);
                }
                
            }, receiveValue: {data in
                XCTAssertTrue(true);
            })
            .store(in: &subscriptions);
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformance() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
