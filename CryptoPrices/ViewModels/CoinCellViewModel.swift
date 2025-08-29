//
//  CoinCellViewModel.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation
import UIKit

struct CoinCellViewModel {
    private let coin: Coin

    var title: String { coin.name }
    var subtitle: String { coin.symbol.uppercased() }
    
    var priceText: String {
        let price = coin.currentPrice ?? 0
        guard price != 0 else { return "-" }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "EUR"
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: price)) ?? "-"
    }

    var changePercentageText: String {
        guard let change = coin.priceChangePercentage24h else { return "-" }
        return String(format: "%.2f%%", change)
    }
    
    var changeIsPositive: Bool {
        (coin.priceChangePercentage24h ?? 0) >= 0
    }
    
    var imageURL: URL { coin.image }

    init(coin: Coin) { self.coin = coin }
}
