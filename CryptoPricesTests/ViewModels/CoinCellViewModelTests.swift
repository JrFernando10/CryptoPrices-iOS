//
//  CoinCellViewModelTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class CoinCellViewModelTests: XCTestCase {
    
    func test_title_returnsCoinName() {
        let coin = Coin.mock(name: "Bitcoin")
        let vm = CoinCellViewModel(coin: coin)
        XCTAssertEqual(vm.title, "Bitcoin")
    }
    
    func test_subtitle_returnsUppercasedSymbol() {
        let coin = Coin.mock(symbol: "btc")
        let vm = CoinCellViewModel(coin: coin)
        XCTAssertEqual(vm.subtitle, "BTC")
    }
    
    func test_priceText_formatsPriceCorrectly() {
        let coin = Coin.mock(currentPrice: 1234.56)
        let vm = CoinCellViewModel(coin: coin)
        let priceText = vm.priceText
        
        XCTAssertTrue(priceText.contains("€"), "Expected currency symbol, got \(priceText)")
        XCTAssertTrue(priceText.contains("1234") || priceText.contains("1,234") || priceText.contains("1.234"), "Expected formatted price to contain 1234, got \(priceText)")
    }
    
    func test_priceText_returnsDashWhenPriceIsZeroOrNil() {
        let coinZero = Coin.mock(currentPrice: 0)
        let coinNil = Coin.mock(currentPrice: nil)
        
        XCTAssertEqual(CoinCellViewModel(coin: coinZero).priceText, "-")
        XCTAssertEqual(CoinCellViewModel(coin: coinNil).priceText, "-")
    }
    
    func test_changePercentageText_formatsPercentageCorrectly() {
        let coin = Coin.mock(priceChangePercentage24h: 12.3456)
        let vm = CoinCellViewModel(coin: coin)
        XCTAssertEqual(vm.changePercentageText, "12.35%")
    }
    
    func test_changePercentageText_returnsDashWhenNil() {
        let coin = Coin.mock(priceChangePercentage24h: nil)
        let vm = CoinCellViewModel(coin: coin)
        XCTAssertEqual(vm.changePercentageText, "-")
    }
    
    func test_changeIsPositive_returnsTrueForPositiveOrZero() {
        XCTAssertTrue(CoinCellViewModel(coin: Coin.mock(priceChangePercentage24h: 5)).changeIsPositive)
        XCTAssertTrue(CoinCellViewModel(coin: Coin.mock(priceChangePercentage24h: 0)).changeIsPositive)
    }
    
    func test_changeIsPositive_returnsFalseForNegative() {
        XCTAssertFalse(CoinCellViewModel(coin: Coin.mock(priceChangePercentage24h: -3.2)).changeIsPositive)
    }
    
    func test_imageURL_returnsCorrectURL() {
        let url = URL(string: "https://example.com/coin.png")!
        let coin = Coin.mock(image: url)
        let vm = CoinCellViewModel(coin: coin)
        XCTAssertEqual(vm.imageURL, url)
    }
}
