//
//  CoinTableViewCellTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class CoinTableViewCellTests: XCTestCase {

    var cell: CoinTableViewCell!

    override func setUp() {
        super.setUp()
        cell = CoinTableViewCell(style: .default, reuseIdentifier: CoinTableViewCell.reuseId)
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override func tearDown() {
        cell = nil
        MockURLProtocol.requestHandler = nil
        URLProtocol.unregisterClass(MockURLProtocol.self)
        super.tearDown()
    }

    func test_configure_updatesLabelsAndImage() {
        let coin = Coin.mock()
        let vm = CoinCellViewModel(coin: coin)

        let dummyImage = UIImage(systemName: "star")!
        let data = dummyImage.pngData()!

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: vm.imageURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        let expectation = self.expectation(description: "Image loaded")

        ImageLoader.shared.load(from: vm.imageURL) { [weak self] image in
            self?.cell.configure(with: vm)
            XCTAssertEqual(self?.cell.titleLabel.text, vm.title)
            XCTAssertEqual(self?.cell.subtitleLabel.text, vm.subtitle)
            XCTAssertEqual(self?.cell.priceLabel.text, vm.priceText)
            XCTAssertEqual(self?.cell.changeLabel.text, vm.changePercentageText)
            XCTAssertEqual(self?.cell.changeLabel.textColor, vm.changeIsPositive ? .systemGreen : .systemRed)
            XCTAssertNotNil(self?.cell.iconImageView.image)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
