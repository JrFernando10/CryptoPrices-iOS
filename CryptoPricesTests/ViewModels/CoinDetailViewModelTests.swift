//
//  CoinDetailViewModelTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class CoinDetailViewModelTests: XCTestCase {
    
    func test_title_returnsCoinName() {
        let vm = CoinDetailViewModel(coin: .mock(name: "Ethereum"))
        XCTAssertEqual(vm.title, "Ethereum")
    }
    
    func test_priceText_formatsPriceAsCurrency() {
        let vm = CoinDetailViewModel(coin: .mock(currentPrice: 1234.56))
        let priceText = vm.priceText

        let normalized = priceText.replacingOccurrences(of: " ", with: "") // non-breaking space
                                 .replacingOccurrences(of: ".", with: "")
                                 .replacingOccurrences(of: ",", with: ".") // decimal fix
        
        XCTAssertTrue(normalized.contains("1234"), "Expected normalized price to contain 1234 but got \(priceText)")
        XCTAssertTrue(priceText.contains("€"), "Expected formatted price to contain € but got \(priceText)")
    }
    
    func test_priceText_returnsDashWhenPriceIsZero() {
        let vm = CoinDetailViewModel(coin: .mock(currentPrice: 0))
        XCTAssertEqual(vm.priceText, "-")
    }
    
    func test_priceText_returnsDashWhenPriceIsNil() {
        let vm = CoinDetailViewModel(coin: .mock(currentPrice: nil))
        XCTAssertEqual(vm.priceText, "-")
    }
    
    func test_changeText_formatsPercentage() {
        let vm = CoinDetailViewModel(coin: .mock(priceChangePercentage24h: -3.5))
        XCTAssertEqual(vm.changeText, "-3.50%")
    }
    
    func test_changeText_returnsDashWhenNil() {
        let vm = CoinDetailViewModel(coin: .mock(priceChangePercentage24h: nil))
        XCTAssertEqual(vm.changeText, "-")
    }
    
    func test_lastUpdatedText_formatsDate() {
        let date = Date(timeIntervalSince1970: 1_600_000_000)
        let vm = CoinDetailViewModel(coin: .mock(lastUpdated: date))
        
        XCTAssertNotEqual(vm.lastUpdatedText, "-")
        XCTAssertFalse(vm.lastUpdatedText.isEmpty)
    }
    
    func test_lastUpdatedText_returnsDashWhenNil() {
        let vm = CoinDetailViewModel(coin: .mock(lastUpdated: nil))
        XCTAssertEqual(vm.lastUpdatedText, "-")
    }
    
    func test_imageURL_returnsCorrectURL() {
        let url = URL(string: "https://example.com/eth.png")!
        let vm = CoinDetailViewModel(coin: .mock(image: url))
        XCTAssertEqual(vm.imageURL, url)
    }
}
