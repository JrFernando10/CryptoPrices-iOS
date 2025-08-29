//
//  CoinServiceTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class CoinServiceTests: XCTestCase {

    func test_fetchMarkets_success_returnsCoins() {
        let coin = Coin.mock()
        let mockClient = MockAPIClient(responseData: [coin])
        let service = CoinService(apiClient: mockClient)
        let expectation = self.expectation(description: "fetchMarkets success")

        service.fetchMarkets { result in
            switch result {
            case .success(let coins):
                XCTAssertEqual(coins.count, 1)
                XCTAssertEqual(coins.first?.id, coin.id)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchMarkets_failure_returnsError() {
        let testError = NSError(domain: "Test", code: -1)
        let mockClient = MockAPIClient(error: testError)
        let service = CoinService(apiClient: mockClient)
        let expectation = self.expectation(description: "fetchMarkets failure")

        service.fetchMarkets { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error as NSError):
                XCTAssertEqual(error.domain, testError.domain)
                XCTAssertEqual(error.code, testError.code)
            default:
                XCTFail("Unexpected result")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
