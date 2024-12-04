//
//  DateFormatter.swift
//  MedicReminder Watch App
//
//  Created by Janindu Dissanayake on 2024-06-11.
//

import Foundation

extension DateFormatter {
    static var twelveHourFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }
}
