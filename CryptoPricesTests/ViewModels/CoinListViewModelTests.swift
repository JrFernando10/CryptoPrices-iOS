//
//  CoinListViewModelTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class CoinListViewModelTests: XCTestCase {
    
    func test_fetch_success_updatesCoins() {
        let mockService = MockCoinService()
        let coin = Coin.mock()
        mockService.result = .success([coin])
        
        let vm = CoinListViewModel(service: mockService)
        let expectation = self.expectation(description: "onUpdate called")
        vm.onUpdate = { expectation.fulfill() }
        vm.fetch()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(vm.numberOfItems(), 1)
        XCTAssertEqual(vm.coins.first?.id, coin.id)
    }
    
    func test_fetch_failure_callsOnError() {
        let mockService = MockCoinService()
        let testError = NSError(domain: "Test", code: -1)
        mockService.result = .failure(testError)
        
        let vm = CoinListViewModel(service: mockService)
        let expectation = self.expectation(description: "onError called")
        vm.onError = { error in
            XCTAssertEqual((error as NSError).code, testError.code)
            expectation.fulfill()
        }
        
        vm.fetch()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_viewModelForCell_returnsCorrectCellVM() {
        let mockService = MockCoinService()
        let coin = Coin.mock()
        mockService.result = .success([coin])
        
        let vm = CoinListViewModel(service: mockService)
        let expectation = self.expectation(description: "onUpdate called")
        vm.onUpdate = { expectation.fulfill() }
        
        vm.fetch()
        
        wait(for: [expectation], timeout: 1.0)
        
        let cellVM = vm.viewModelForCell(at: 0)
        
        XCTAssertEqual(cellVM.title, coin.name)
    }
    
    func test_numberOfItems_returnsCoinsCount() {
        let mockService = MockCoinService()
        let coins = [Coin.mock(), Coin.mock()]
        mockService.result = .success(coins)
        
        let vm = CoinListViewModel(service: mockService)
        let expectation = self.expectation(description: "onUpdate called")
        vm.onUpdate = { expectation.fulfill() }
        
        vm.fetch()
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(vm.numberOfItems(), coins.count)
    }
}
