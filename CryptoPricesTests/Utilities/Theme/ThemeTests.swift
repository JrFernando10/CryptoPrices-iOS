//
//  ThemeTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class ThemeTests: XCTestCase {

    func test_allCases_containsSystemLightDark() {
        let all = Theme.allCases
        XCTAssertTrue(all.contains(.system))
        XCTAssertTrue(all.contains(.light))
        XCTAssertTrue(all.contains(.dark))
        XCTAssertEqual(all.count, 3)
    }

    func test_userInterfaceStyle_forEachCase() {
        XCTAssertEqual(Theme.system.userInterfaceStyle, .unspecified)
        XCTAssertEqual(Theme.light.userInterfaceStyle, .light)
        XCTAssertEqual(Theme.dark.userInterfaceStyle, .dark)
    }

    func test_title_forEachCase() {
        XCTAssertEqual(Theme.system.title, "System")
        XCTAssertEqual(Theme.light.title, "Light")
        XCTAssertEqual(Theme.dark.title, "Dark")
    }

    func test_rawValue_forEachCase() {
        XCTAssertEqual(Theme.system.rawValue, "system")
        XCTAssertEqual(Theme.light.rawValue, "light")
        XCTAssertEqual(Theme.dark.rawValue, "dark")
    }

    func test_initFromRawValue_returnsCorrectCase() {
        XCTAssertEqual(Theme(rawValue: "system"), .system)
        XCTAssertEqual(Theme(rawValue: "light"), .light)
        XCTAssertEqual(Theme(rawValue: "dark"), .dark)
        XCTAssertNil(Theme(rawValue: "invalid"))
    }
}
