//
//  PlayerServiceErrorTests.swift
//  BookPlayerTests
//
//  Created by Serhii Bets on 27/4/25.
//

import Foundation
import XCTest
@testable import BookPlayer

final class PlayerServiceErrorTests: XCTestCase {
    
    func test_errorDescriptions() {
        XCTAssertEqual(
            PlayerServiceError.fileNotFound(path: "/path").errorDescription,
            "Audio file not found at path: /path"
        )
        
        XCTAssertEqual(
            PlayerServiceError.downloadFailed(URL(string: "https://example.com")!).errorDescription,
            "Failed to download audio from https://example.com"
        )
        
        XCTAssertEqual(
            PlayerServiceError.audioSessionSetupFailed.errorDescription,
            "Failed to configure audio session."
        )
        
        XCTAssertEqual(
            PlayerServiceError.audioEngineFailed.errorDescription,
            "Failed to start audio engine."
        )
        
        XCTAssertEqual(
            PlayerServiceError.playerLoadFailed.errorDescription,
            "Failed to load the audio file."
        )
        
        XCTAssertEqual(
            PlayerServiceError.playbackFailed.errorDescription,
            "Failed to start playback."
        )
    }
    
    func test_errorEquatable_sameCases() {
        XCTAssertEqual(
            PlayerServiceError.fileNotFound(path: "/same"),
            PlayerServiceError.fileNotFound(path: "/same")
        )
        
        XCTAssertEqual(
            PlayerServiceError.downloadFailed(URL(string: "https://same.com")!),
            PlayerServiceError.downloadFailed(URL(string: "https://same.com")!)
        )
        
        XCTAssertEqual(
            PlayerServiceError.audioSessionSetupFailed,
            PlayerServiceError.audioSessionSetupFailed
        )
        
        XCTAssertEqual(
            PlayerServiceError.audioEngineFailed,
            PlayerServiceError.audioEngineFailed
        )
        
        XCTAssertEqual(
            PlayerServiceError.playerLoadFailed,
            PlayerServiceError.playerLoadFailed
        )
        
        XCTAssertEqual(
            PlayerServiceError.playbackFailed,
            PlayerServiceError.playbackFailed
        )
    }
    
    func test_errorEquatable_differentCases() {
        XCTAssertNotEqual(
            PlayerServiceError.fileNotFound(path: "/one"),
            PlayerServiceError.fileNotFound(path: "/two")
        )
        
        XCTAssertNotEqual(
            PlayerServiceError.downloadFailed(URL(string: "https://one.com")!),
            PlayerServiceError.downloadFailed(URL(string: "https://two.com")!)
        )
        
        XCTAssertNotEqual(
            PlayerServiceError.audioSessionSetupFailed,
            PlayerServiceError.audioEngineFailed
        )
    }
}
