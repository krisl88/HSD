//
//  AlertView.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

final class AlertView: UIView {
    
    private let state: AlertViewState
    
    private lazy var titleLabel: UILabel = .init(content: state.title)
    private lazy var subtitleLabel: UILabel = .init(content: state.subtitle)
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stack.spacing = 16
        return stack
    }()
    
    init(state: AlertViewState) {
        self.state = state
        super.init(frame: .zero)
        setupLayout()
        inflateContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func inflateContent() {
        subtitleLabel.numberOfLines = 0
        [
            titleLabel,
            state.subtitle != nil ? subtitleLabel : nil
        ]
        .compactMap { $0 }
        .forEach {
            contentStackView.addArrangedSubview($0)
        }
        makeCTAs()
    }
    
    private func makeCTAs() {
        state.ctaButtons?.forEach { config in
            let button = UIButton(type: .custom, primaryAction: UIAction(title: "", handler: { _ in
                config.action()
            }))
            button.configure(with: config.text, style: config.style)
            contentStackView.addArrangedSubview(button)
        }
    }
}
