//
//  SearchResultControllerTests.swift
//  SearchResultControllerTests
//
//  Created by Dahna on 6/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
// module name is iTunes_Search
@testable import iTunes_Search

class SearchResultControllerTests: XCTestCase {

    func testForSomeResults() {
        let controller = SearchResultController()
        
        let e = expectation(description: "Wait for results")
        
        controller.performSearch(for: "GarageBand", resultType: .software) {
            e.fulfill()
        }
        
        wait(for: [e], timeout: 2)
        XCTAssertTrue(controller.searchResults.count > 0, "Expecting at least one result for GarageBand")
    }
    
    func testSearchResultsController() {
        let mock = MockDataLoader(data: garageBandJSON, response: nil, error: nil)
        let resultsExpectation = expectation(description: "Wait for search results")
        
        // We need to make sure we pass in the dataLoader from our init otherwise it will automatically think we want to use the real URLSession instead of our mock
        let controller = SearchResultController(dataLoader: mock)
        controller.performSearch(for: "GarageBand", resultType: .software) {
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 2)
        XCTAssertTrue(controller.searchResults.count == 2, "Expecting 2 results for GarageBand")
        XCTAssertEqual("GarageBand", controller.searchResults[0].title)
        XCTAssertEqual("Apple", controller.searchResults[0].artist)
    }
    
    func testNoDataWithError() {
        let e = expectation(description: "There should be no search results")
        let error = NSError(domain: "com.LambdaSchool.iTunesSearch", code: -1, userInfo: nil)
        
        let mockDataLoader = MockDataLoader(data: nil, response: nil, error: error)
        
        
        let searchResultsController = SearchResultController(dataLoader: mockDataLoader)
        
        searchResultsController.performSearch(for: "Twitter", resultType: .software) {
            XCTAssertTrue(searchResultsController.searchResults.isEmpty)
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}
