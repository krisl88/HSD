//
//  SpacerView.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

final class SpacerView: UIView {

    required init() {
        super.init(frame: .zero)
        setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
