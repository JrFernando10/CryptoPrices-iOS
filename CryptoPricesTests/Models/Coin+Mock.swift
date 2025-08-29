//
//  Coin+Mock.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation
@testable import CryptoPrices

extension Coin {
    static func mock(
        id: String = "bitcoin",
        symbol: String = "btc",
        name: String = "Bitcoin",
        image: URL = URL(string: "https://example.com/bitcoin.png")!,
        currentPrice: Double? = 100.0,
        priceChangePercentage24h: Double? = 5.25,
        lastUpdated: Date? = Date(timeIntervalSince1970: 1_600_000_000)
    ) -> Coin {
        return Coin(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            priceChangePercentage24h: priceChangePercentage24h,
            lastUpdated: lastUpdated
        )
    }
}
