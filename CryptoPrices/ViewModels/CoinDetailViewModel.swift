//
//  CoinDetailViewModel.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation

struct CoinDetailViewModel {
    private let coin: Coin

    var title: String { coin.name }
    
    var priceText: String {
        let price = coin.currentPrice ?? 0
        guard price != 0 else { return "-" }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "EUR"
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: price)) ?? "-"
    }
    
    var changeText: String {
        guard let change = coin.priceChangePercentage24h else { return "-" }
        return String(format: "%.2f%%", change)
    }
    
    var lastUpdatedText: String {
        guard let date = coin.lastUpdated else { return "-" }
        let dataFormatter = DateFormatter(); dataFormatter.dateStyle = .medium; dataFormatter.timeStyle = .short
        return dataFormatter.string(from: date)
    }
    
    var imageURL: URL { coin.image }

    init(coin: Coin) { self.coin = coin }
}
