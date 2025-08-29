//
//  MockCoinService.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation
@testable import CryptoPrices

final class MockCoinService: CoinServiceType {
    var result: Result<[Coin], Error>?
    
    func fetchMarkets(completion: @escaping (Result<[Coin], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
