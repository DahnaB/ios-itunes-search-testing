//
//  MockDataLoader.swift
//  SearchResultControllerTests
//
//  Created by Dahna on 6/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
@testable import iTunes_Search

class MockDataLoader: NetworkDataLoader {
    
    let data: Data?
    let respone: URLResponse?
    let error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.respone = response
        self.error = error
    }
    
    func loadData(using request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // We don't need to use URLSession to get the data, instead we can get the data from the mockJSON file.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.data, self.respone, self.error)
        }
    }
}
