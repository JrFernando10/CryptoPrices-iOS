//
//  MockAPIClient.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation
@testable import CryptoPrices

struct MockAPIClient: APIClientType {
    var responseData: Any?
    var error: Error?

    func fetch<T>(url: URL, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        if let error = error {
            completion(.failure(error))
            return
        }
        if let data = responseData as? T {
            completion(.success(data))
        } else {
            completion(.failure(NSError(domain: "MockAPIClient", code: -1, userInfo: nil)))
        }
    }
}
