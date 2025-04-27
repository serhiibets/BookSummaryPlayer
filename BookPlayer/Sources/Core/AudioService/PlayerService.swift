//
//  PlayerService.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import AudioKit
import AVFoundation
import Dependencies
import Foundation

/// A service responsible for handling audio playback logic
struct PlayerService {
    var load: (URL, [Chapter]) async throws -> Void
    var play: () -> Void
    var pause: () -> Void
    var seek: (TimeInterval) -> Void
    var setRate: (Float) -> Void
    var currentTime: () -> TimeInterval
    var duration: () -> TimeInterval
    var status: () -> PlaybackStatus
    var chapterIndex: () -> Int
    var setChapter: (Int) -> Void

    enum PlaybackStatus: Equatable {
        case loading
        case readyToPlay
        case playing
        case paused
        case failed(Error)

        static func == (lhs: PlaybackStatus, rhs: PlaybackStatus) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading),
                 (.readyToPlay, .readyToPlay),
                 (.playing, .playing),
                 (.paused, .paused):
                return true
            case let (.failed(lhsError), .failed(rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
            default:
                return false
            }
        }
    }
}

// MARK: - DependencyKey

extension PlayerService: DependencyKey {
    static let liveValue: PlayerService = {
        let playerManager = PlayerManager()

        return PlayerService(
            load: { url, chapters in
                try await playerManager.load(url)
                playerManager.setChapters(chapters)
            },
            play: playerManager.play,
            pause: playerManager.pause,
            seek: playerManager.seek,
            setRate: playerManager.setRate,
            currentTime: playerManager.currentTime,
            duration: playerManager.duration,
            status: playerManager.status,
            chapterIndex: playerManager.chapterIndex,
            setChapter: playerManager.setChapter
        )
    }()
}

extension DependencyValues {
    var audioService: PlayerService {
        get { self[PlayerService.self] }
        set { self[PlayerService.self] = newValue }
    }
}
