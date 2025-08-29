//
//  ImageLoaderTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class ImageLoaderTests: XCTestCase {

    var loader: ImageLoader!

    override func setUp() {
        super.setUp()
        loader = ImageLoader.shared
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override func tearDown() {
        MockURLProtocol.requestHandler = nil
        loader = nil
        URLProtocol.unregisterClass(MockURLProtocol.self)
        super.tearDown()
    }

    func test_load_imageFromURL_returnsImage() {
        guard let image = UIImage(systemName: "star"),
              let data = image.pngData() else {
            XCTFail("Erro ao criar imagem de teste")
            return
        }

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://example.com/image.png")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, data)
        }

        let expectation = self.expectation(description: "Image loaded")
        loader.load(from: URL(string: "https://example.com/image.png")!) { loadedImage in
            XCTAssertNotNil(loadedImage)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_load_invalidData_returnsNil() {
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://example.com/invalid.png")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, Data([0,1,2]))
        }

        let expectation = self.expectation(description: "Invalid image returns nil")
        loader.load(from: URL(string: "https://example.com/invalid.png")!) { image in
            XCTAssertNil(image)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_load_sameURL_returnsCachedImageIndirectly() {
        guard let url = URL(string: "https://example.com/cache.png"),
              let image = UIImage(systemName: "star"),
              let data = image.pngData() else {
            XCTFail("Erro ao criar imagem de teste")
            return
        }

        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, data)
        }

        let expectation1 = expectation(description: "First load")
        loader.load(from: url) { loadedImage in
            XCTAssertNotNil(loadedImage)
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 1.0)

        MockURLProtocol.requestHandler = nil
        let expectation2 = expectation(description: "Second load from cache")
        loader.load(from: url) { loadedImage in
            XCTAssertNotNil(loadedImage)
            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 1.0)
    }
}
