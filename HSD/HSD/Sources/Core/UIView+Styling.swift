//
//  UILabel.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

extension UILabel {
    convenience init(content: TextContent?) {
        self.init()
        guard let content = content else { return }
        
        switch content {
        case .text(let text):
            self.text = text
        case .attributed(let attributed):
            self.attributedText = attributed
        case .markdown:
            break
        }
    }
}

extension UIButton {
    func configure(with content: TextContent?, style: HSDTheme.ButtonStyle) {
        guard let content = content else { return }
        
        switch content {
        case .text(let text):
            self.setTitle(text, for: .normal)
        case .attributed(let attributed):
            self.setAttributedTitle(attributed, for: .normal)
        case .markdown:
            break
        }
        
        // [KL]: would do a better job of setting styles in prod
        switch style {
        case .primary:
            backgroundColor = HSDTheme.Color.primary
        case .secondary:
            backgroundColor = HSDTheme.Color.secondary
        case .tertiary:
            backgroundColor = .clear
        }
    }
}
