//
//  TripLegView.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

final class TripLegView: UIStackView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = HSDTheme.Font.highlight
        return label
    }()
    
    private lazy var estimatedEarningsLabel = {
        let label = UILabel(frame: .zero)
        label.font = HSDTheme.Font.primary
        label.textColor = HSDTheme.Color.primary
        return label
    }()

    private lazy var overviewStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, SpacerView(), estimatedEarningsLabel])
        stack.spacing = 12
        return stack
    }()
    
    private lazy var legStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.spacing = 4
        stack.axis = .vertical
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        [overviewStackView, legStackView].forEach {
            addArrangedSubview($0)
        }
        spacing = 12
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ trip: Trip) {
        titleLabel.text = trip.passengerData
        inflateContent(trip)
    }
    
    private func inflateContent(_ trip: Trip) {
        legStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        let wayPoints = trip.waypoints
        var index: Int = 0
        for wayPoint in wayPoints {
            let view = OrderedItemView(order: index + 1, text: wayPoint.location.address)
            addArrangedSubview(view)
            index += 1
        }
    }
}
