//
//  TripHeaderView.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

final class TripHeaderView: UIStackView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = HSDTheme.Font.highlight
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = HSDTheme.Font.secondary
        return label
    }()
    
    private lazy var estimatedEarningsLabel = {
        let label = UILabel(frame: .zero)
        label.font = HSDTheme.Font.primary
        label.textColor = HSDTheme.Color.primary
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        spacing = 12
        [titleLabel, subtitleLabel, SpacerView(), estimatedEarningsLabel].forEach {
            addArrangedSubview($0)
        }
        backgroundColor = HSDTheme.Color.header
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ trip: Trip) {
        let date = DateFormatter.date(
            from: trip.plannedRoute.startsAt,
            style: .short
        )
        titleLabel.text = date
        subtitleLabel.text = trip.timeFrame
        estimatedEarningsLabel.text = trip.estimatedEarnings.formatted(.currency(code: "USD"))
    }
}
