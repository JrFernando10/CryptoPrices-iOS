//
//  CoinDetailViewTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class CoinDetailViewTests: XCTestCase {

    var view: CoinDetailView!

    override func setUp() {
        super.setUp()
        view = CoinDetailView(frame: CGRect(x: 0, y: 0, width: 320, height: 640))
    }

    override func tearDown() {
        view = nil
        super.tearDown()
    }

    func test_subviews_areAdded() {
        XCTAssertTrue(view.subviews.contains(view.imageView))
        XCTAssertTrue(view.subviews.contains(view.nameLabel))
        XCTAssertTrue(view.subviews.contains(view.priceLabel))
        XCTAssertTrue(view.subviews.contains(view.changeLabel))
        XCTAssertTrue(view.subviews.contains(view.lastUpdatedLabel))
    }

    func test_labels_properties() {
        XCTAssertEqual(view.nameLabel.font, UIFont.systemFont(ofSize: 22, weight: .bold))
        XCTAssertEqual(view.nameLabel.textAlignment, .center)
        XCTAssertEqual(view.priceLabel.font, UIFont.systemFont(ofSize: 20, weight: .semibold))
        XCTAssertEqual(view.priceLabel.textAlignment, .center)
        XCTAssertEqual(view.changeLabel.font, UIFont.systemFont(ofSize: 16))
        XCTAssertEqual(view.changeLabel.textAlignment, .center)
        XCTAssertEqual(view.lastUpdatedLabel.font, UIFont.systemFont(ofSize: 12))
        XCTAssertEqual(view.lastUpdatedLabel.textAlignment, .center)
        XCTAssertEqual(view.lastUpdatedLabel.textColor, .secondaryLabel)
    }

    func test_imageView_properties() {
        XCTAssertEqual(view.imageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(view.imageView.layer.cornerRadius, 40)
        XCTAssertTrue(view.imageView.clipsToBounds)
    }

    func test_backgroundColor() {
        XCTAssertEqual(view.backgroundColor, .systemBackground)
    }
}
