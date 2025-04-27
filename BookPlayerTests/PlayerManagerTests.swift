//
//  PlayerManagerTests.swift
//  BookPlayerTests
//
//  Created by Serhii Bets on 27/4/25.
//

import Foundation
import XCTest
import AudioKit
@testable import BookPlayer

final class PlayerManagerTests: XCTestCase {
    
    var manager: PlayerManager!
    var mockEngine: MockAudioEngine!
    var mockPlayer: MockAudioPlayer!
    
    override func setUp() {
        super.setUp()
        
        mockEngine = MockAudioEngine()
        mockPlayer = MockAudioPlayer()
        
        manager = PlayerManager(
            engine: mockEngine,
            player: mockPlayer
        )
    }
    
    override func tearDown() {
        manager = nil
        mockEngine = nil
        mockPlayer = nil
        super.tearDown()
    }
    
    func test_play_startsEngineAndPlays() {
        manager.play()
        XCTAssertTrue(mockEngine.isStarted, "Engine should be started")
        XCTAssertTrue(mockPlayer.isPlaying, "Player should start playing")
    }
    
    func test_pause_pausesPlayer() {
        mockPlayer.isPlaying = true
        manager.pause()
        XCTAssertFalse(mockPlayer.isPlaying, "Player should be paused")
    }
    
    func test_seek_updatesPlayerCurrentTime() {
        manager.seek(120)
        XCTAssertEqual(mockPlayer.currentTime, 120)
    }
    
    func test_setRate_updatesSpeedControl() {
        manager.setRate(1.5)
        XCTAssertEqual(manager.speedControl.rate, 1.5, "SpeedControl rate should match set value")
    }
    
    func test_currentTime_returnsCorrectTime() {
        mockPlayer.currentTime = 45
        XCTAssertEqual(manager.currentTime(), 45)
    }
    
    func test_duration_returnsCorrectDuration() {
        XCTAssertEqual(manager.duration(), 300)
    }
    
    func test_status_whenPlaying_returnsPlaying() {
        mockPlayer.isPlaying = true
        XCTAssertEqual(manager.status(), .playing)
    }
    
    func test_status_whenPaused_returnsPaused() {
        mockPlayer.isStarted = true
        mockPlayer.isPlaying = false
        XCTAssertEqual(manager.status(), .paused)
    }
    
    func test_status_whenReadyToPlay() {
        mockPlayer.isStarted = false
        mockPlayer.isPlaying = false
        XCTAssertEqual(manager.status(), .readyToPlay)
    }
    
    func test_chapterIndex_initialValue() {
        XCTAssertEqual(manager.chapterIndex(), 0)
    }
    
    func test_setChapters_setsChaptersCorrectly() {
        let chapters = [
            Chapter(id: UUID(), title: "Chapter 1", duration: 180, audioURL: URL(string: "https://example.com/1.mp3")!),
            Chapter(id: UUID(), title: "Chapter 2", duration: 200, audioURL: URL(string: "https://example.com/2.mp3")!)
        ]
        manager.setChapters(chapters)
        XCTAssertEqual(manager.chapterIndex(), 0)
    }
    
    func test_setChapter_invalidIndex_doesNothing() {
        manager.setChapters([])
        manager.setChapter(5)
        XCTAssertEqual(manager.chapterIndex(), 0)
    }
}
