//
//  MockedState.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation

struct PlayerUIState {
    var book: Book
    var currentChapterIndex: Int
    var currentTime: TimeInterval
    var duration: TimeInterval
    var isPlaying: Bool
    var playbackRate: Float
}

extension PlayerUIState {
    static let sample = PlayerUIState(
        book: .sample,
        currentChapterIndex: 1,
        currentTime: 45,
        duration: 300,
        isPlaying: false,
        playbackRate: 1.0
    )
}
