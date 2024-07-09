//
//  AlertViewController.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

struct AlertViewState {
    let title: TextContent
    let subtitle: TextContent?
    let ctaButtons: [CallToActionButton]?
}

struct CallToActionButton {
    let text: TextContent
    let action: Closure
    let style: HSDTheme.ButtonStyle
}

final class AlertViewController: UIViewController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    private let state: AlertViewState
    
    private lazy var alertView: AlertView = .init(state: state)
    
    init(state: AlertViewState) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .clear
        [backgroundView, alertView].forEach {
            view.addSubview($0)
        }
    
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
    }

}
