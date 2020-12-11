//
//  CovidGoAwayTests.swift
//  CovidGoAwayTests
//
//  Created by Kelby Mittan on 12/11/20.
//

import XCTest
@testable import CovidGoAway

class CovidGoAwayTests: XCTestCase {

    func testZimbabwe() {
        let exp = "Ziiimbabwe"
        
        let apiClient = APIClient()
        
        apiClient.fetchAllData { (result) in
            switch result {
            case .failure(let error):
                XCTFail("error decoding data \(error.localizedDescription)")
            case .success(let countries):
                let firstCountry = countries.first?.country
                print(firstCountry ?? "AAAAAAHHHHH")
                XCTAssertEqual(exp, firstCountry, "Countries Aren't Equal")
            }
        }
    }

}
