//
//  AudioServiceError.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation

/// Represents specific known audio service errors
enum PlayerServiceError: Error, Equatable, LocalizedError {
    case fileNotFound(path: String)
    case downloadFailed(URL)
    case audioSessionSetupFailed
    case audioEngineFailed
    case playerLoadFailed
    case playbackFailed
    case unknown(Error)

    static func == (lhs: PlayerServiceError, rhs: PlayerServiceError) -> Bool {
        switch (lhs, rhs) {
        case let (.fileNotFound(lPath), .fileNotFound(rPath)):
            return lPath == rPath
        case let (.downloadFailed(lURL), .downloadFailed(rURL)):
            return lURL == rURL
        case (.audioSessionSetupFailed, .audioSessionSetupFailed),
             (.audioEngineFailed, .audioEngineFailed),
             (.playerLoadFailed, .playerLoadFailed),
             (.playbackFailed, .playbackFailed):
            return true
        case let (.unknown(lError), .unknown(rError)):
            return lError.localizedDescription == rError.localizedDescription
        default:
            return false
        }
    }

    var errorDescription: String? {
        switch self {
        case let .fileNotFound(path):
            return "Audio file not found at path: \(path)"
        case let .downloadFailed(url):
            return "Failed to download audio from \(url.absoluteString)"
        case .audioSessionSetupFailed:
            return "Failed to configure audio session."
        case .audioEngineFailed:
            return "Failed to start audio engine."
        case .playerLoadFailed:
            return "Failed to load the audio file."
        case .playbackFailed:
            return "Failed to start playback."
        case let .unknown(error):
            return error.localizedDescription
        }
    }
}
