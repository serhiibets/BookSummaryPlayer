//
//  TimeFormatter.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation

/// Shared time formatter for audio timings
struct TimeFormatter {
    static let shared = TimeFormatter()
    
    private let formatter: DateComponentsFormatter
    
    private init() {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        self.formatter = formatter
    }

    func string(for time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return "\(minutes):" + String(format: "%02d", seconds)
    }
}
