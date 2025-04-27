//
//  Chapter.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation

/// Represents an individual audio chapter
struct Chapter: Equatable, Identifiable {
    let id: UUID
    let title: String
    let duration: TimeInterval
    let audioURL: URL
}
