//
//  DesignSystem.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

// [KL]: in production, it would be a more robust system (with support with light + dark theme, etc)

enum TextContent {
    case text(String?)
    case attributed(NSAttributedString?)
    case markdown // [KL] not implemented
}

enum HSDTheme {
    enum Font {
        static var primary: UIFont { .systemFont(ofSize: 14) }
        static var secondary: UIFont { .systemFont(ofSize: 12) }
        static var highlight: UIFont { .boldSystemFont(ofSize: 14) }
    }
    
    enum Color {
        static var primary: UIColor { .systemBlue }
        static var secondary: UIColor { .systemGray }
        static var header: UIColor { .systemFill }
    }
    
    enum ButtonStyle {
        case primary
        case secondary
        case tertiary
    }
}


