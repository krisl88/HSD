//
//  Trip+Extension.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

extension Trip {
    
    enum TimeAnchorType: String {
        case pickup = "pick_up"
        case dropOff = "drop_off"
        case unknown
    }
    
    var timeFrame: String? {
        let startTime = DateFormatter.date(
            from: plannedRoute.startsAt,
            format: "HH:mm"
        )
        let endTime = DateFormatter.date(
            from: plannedRoute.endsAt,
            format: "HH:mm"
        )
        return [startTime, endTime]
            .compactMap { $0 }
            .joined(separator: "-")
    }
    
    var passengerData: String? {
        let riders: String? = {
            let count = passengers.count
            // [KL]: Plurals would be done in a localized stringDict in production
            return "\(count) \(count > 1 ? "riders" : "rider")"
        }()
        
        let boosterSeats: String? = {
            let needsBooster = passengers.filter { $0.boosterSeat}
            guard !needsBooster.isEmpty else { return nil }
            // [KL]: Plurals would be done in a localized stringDict in production
            return "\(needsBooster.count) \(needsBooster.count > 1 ? "boosters" : "booster")"
        }()
        let data = [riders, boosterSeats]
            .compactMap { $0 }
            .joined(separator: " * ")
        return "(\(data))"
    }
    
    var timeAnchorType: TimeAnchorType {
        TimeAnchorType(rawValue: timeAnchor) ?? .unknown
    }
}
