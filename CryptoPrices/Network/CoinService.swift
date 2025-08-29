//
//  CoinService.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation

protocol CoinServiceType {
    func fetchMarkets(completion: @escaping (Result<[Coin], Error>) -> Void)
}

final class CoinService: CoinServiceType {
    private let apiClient: APIClientType
    private let baseURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false"

    init(apiClient: APIClientType = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchMarkets(completion: @escaping (Result<[Coin], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "CoinService", code: -1, userInfo: nil)))
            return
        }
        
        apiClient.fetch(url: url, completion: completion)
    }
}
