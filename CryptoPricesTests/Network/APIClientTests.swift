//
//  APIClientTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class APIClientTests: XCTestCase {

    var client: APIClient!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        client = APIClient(session: session)
    }

    override func tearDown() {
        client = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }

    func test_fetch_success_returnsDecodedObject() throws {
        let coin = Coin.mock()
        let encoder = JSONEncoder()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            try container.encode(formatter.string(from: date))
        }

        let data = try encoder.encode([coin])

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        let expectation = self.expectation(description: "fetch success")

        client.fetch(url: URL(string: "https://example.com")!) { (result: Result<[Coin], Error>) in
            switch result {
            case .success(let coins):
                XCTAssertEqual(coins.count, 1)
                XCTAssertEqual(coins.first?.id, coin.id)
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetch_noData_returnsError() {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let client = APIClient(session: session)

        let expectation = self.expectation(description: "fetch no data")

        client.fetch(url: URL(string: "https://example.com")!) { (result: Result<[Coin], Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure due to no data")
            case .failure:
                XCTAssertTrue(true)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetch_invalidJSON_returnsDecodingError() {
        let invalidJSON = "invalid".data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, invalidJSON)
        }

        let expectation = self.expectation(description: "fetch invalid JSON")

        client.fetch(url: URL(string: "https://example.com")!) { (result: Result<[Coin], Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure due to invalid JSON")
            case .failure:
                XCTAssertTrue(true)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetch_networkError_returnsFailure() {
        let testError = NSError(domain: "TestNetwork", code: -1009)

        MockURLProtocol.requestHandler = { request in
            throw testError
        }

        let expectation = self.expectation(description: "fetch network error")

        client.fetch(url: URL(string: "https://example.com")!) { (result: Result<[Coin], Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure due to network error")
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
