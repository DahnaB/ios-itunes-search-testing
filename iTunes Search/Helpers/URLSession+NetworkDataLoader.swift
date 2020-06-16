//
//  URLSession+NetworkDataLoader.swift
//  iTunes Search
//
//  Created by Dahna on 6/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

extension URLSession: NetworkDataLoader {
    func loadData(using request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // We don't care about the data, response, and error here. We sill forward these objects to whatever is calling 'loadData'.
        
        dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
}
