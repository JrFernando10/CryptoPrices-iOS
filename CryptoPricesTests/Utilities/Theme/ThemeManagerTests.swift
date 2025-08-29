//
//  ThemeManagerTests.swift
//  CryptoPricesTests
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import CryptoPrices

final class ThemeManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "selected_theme")
    }

    func test_defaultTheme_isSystem() {
        let theme = ThemeManager.shared.current
        XCTAssertEqual(theme, .system)
    }

    func test_settingTheme_updatesUserDefaults() {
        ThemeManager.shared.current = .dark
        let storedValue = UserDefaults.standard.string(forKey: "selected_theme")
        XCTAssertEqual(storedValue, Theme.dark.rawValue)
    }

    func test_settingTheme_updatesCurrent() {
        ThemeManager.shared.current = .light
        XCTAssertEqual(ThemeManager.shared.current, .light)
    }

    func test_apply_changesWindowStyle() {
        let window = UIWindow()
        ThemeManager.shared.apply(.dark, to: window)
        
        XCTAssertEqual(ThemeManager.shared.current, .dark)
    }

    func test_applySavedTheme_setsWindowStyle() {
        let window = UIWindow()
        ThemeManager.shared.current = .light
        ThemeManager.shared.applySavedTheme(to: window)
        XCTAssertEqual(window.overrideUserInterfaceStyle, Theme.light.userInterfaceStyle)
    }

    func test_applySavedTheme_withNilWindow_doesNotCrash() {
        ThemeManager.shared.applySavedTheme(to: nil)
        XCTAssertTrue(true)
    }

    func test_apply_withNilWindow_doesNotCrash() {
        ThemeManager.shared.apply(.dark, to: nil)
        XCTAssertTrue(true)
    }
}
