//
//  OrderedItemView.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

final class OrderedItemView: UIStackView {
    
    private let order: Int
    private let text: String
    
    private lazy var orderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = HSDTheme.Font.primary
        label.text = "\(String(order))."
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = HSDTheme.Font.primary
        label.text = text
        return label
    }()

    init(order: Int, text: String) {
        self.order = order
        self.text = text
        super.init(frame: .zero)
        spacing = 4
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [orderLabel, textLabel, SpacerView()].forEach {
            addArrangedSubview($0)
        }
    }
    
}
