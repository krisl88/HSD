//
//  DateFormatter.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import UIKit

// [KL]: making it static since date formatter are expensive to create
let isoFormatter = ISO8601DateFormatter()
let dateFormatterToString = DateFormatter()

extension DateFormatter {
    
    static func date(
        from date: String,
        style: DateFormatter.Style? = nil,
        format: String? = nil
    ) -> String? {
        guard let isoDate = isoFormatter.date(from: date) else {
            return nil
        }
        if let style {
            dateFormatterToString.dateStyle = style
        } else if let format {
            dateFormatterToString.dateFormat = format
        }
        return dateFormatterToString.string(from: isoDate)
    }
}
