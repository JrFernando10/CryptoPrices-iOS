//
//  CoinDetailViewControllerTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class CoinDetailViewControllerTests: XCTestCase {

    var viewModel: CoinDetailViewModel!
    var vc: CoinDetailViewController!

    override func setUp() {
        super.setUp()
        viewModel = CoinDetailViewModel(coin: Coin.mock())
        vc = CoinDetailViewController(viewModel: viewModel)
    }

    override func tearDown() {
        vc = nil
        viewModel = nil
        super.tearDown()
    }

    func test_loadView_setsCorrectView() {
        vc.loadViewIfNeeded()
        XCTAssertTrue(vc.view is CoinDetailView)
    }

    func test_viewDidLoad_setsLabelsAndTitle() {
        vc.loadViewIfNeeded()
        XCTAssertEqual(vc.title, viewModel.title)

        let detailView = vc.view as! CoinDetailView
        XCTAssertEqual(detailView.nameLabel.text, viewModel.title)
        XCTAssertEqual(detailView.priceLabel.text, viewModel.priceText)
        XCTAssertEqual(detailView.changeLabel.text, viewModel.changeText)
        XCTAssertEqual(detailView.lastUpdatedLabel.text, "Updated: " + viewModel.lastUpdatedText)
    }
}
