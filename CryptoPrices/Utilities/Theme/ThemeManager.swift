//
//  ThemeManager.swift
//  CryptoPrices
//
//  Created by Fernando on 29/08/25.
//  Copyright © 2025 Example. All rights reserved.
//

import UIKit

final class ThemeManager {
    static let shared = ThemeManager()
    private init() {}

    private let key = "selected_theme"

    var current: Theme {
        get { Theme(rawValue: UserDefaults.standard.string(forKey: key) ?? "") ?? .system }
        set { UserDefaults.standard.set(newValue.rawValue, forKey: key) }
    }

    func apply(_ theme: Theme, to window: UIWindow? = UIApplication.shared.windows.first) {
        guard let window = window else { return }
        current = theme

        UIView.animate(withDuration: 0.3) {
            window.overrideUserInterfaceStyle = theme.userInterfaceStyle
            window.subviews.forEach { $0.removeFromSuperview(); window.addSubview($0) }
        }
    }

    func applySavedTheme(to window: UIWindow? = UIApplication.shared.windows.first) {
        guard let window = window else { return }
        window.overrideUserInterfaceStyle = current.userInterfaceStyle
    }

}
