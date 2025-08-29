//
//  Coin.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation

struct Coin: Codable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let currentPrice: Double?
    let priceChangePercentage24h: Double?
    let lastUpdated: Date?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case lastUpdated = "last_updated"
    }
}
