//
//  PlayerServiceTests.swift
//  BookPlayerTests
//
//  Created by Serhii Bets on 27/4/25.
//

import Foundation
import XCTest
@testable import BookPlayer

final class PlayerServiceTests: XCTestCase {
    
    var mockService: PlayerService!
    var didPlay = false
    var didPause = false
    var seekedTime: TimeInterval?
    var setPlaybackRate: Float?
    var chapterIndexSet: Int?
    
    override func setUp() {
        super.setUp()
        
        // Reset all flags
        didPlay = false
        didPause = false
        seekedTime = nil
        setPlaybackRate = nil
        chapterIndexSet = nil
        
        // Create Mock PlayerService
        mockService = PlayerService(
            load: { _, _ in },
            play: { [weak self] in self?.didPlay = true },
            pause: { [weak self] in self?.didPause = true },
            seek: { [weak self] time in self?.seekedTime = time },
            setRate: { [weak self] rate in self?.setPlaybackRate = rate },
            currentTime: { 120 },
            duration: { 300 },
            status: { .playing },
            chapterIndex: { 1 },
            setChapter: { [weak self] index in self?.chapterIndexSet = index }
        )
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    func test_load_doesNotThrow() async throws {
        let url = URL(string: "https://example.com/audio.mp3")!
        let chapters = [Chapter(id: UUID(), title: "Chapter 1", duration: 180, audioURL: url)]
        
        do {
            try await mockService.load(url, chapters)
            // Success: no throw
        } catch {
            XCTFail("Expected load to succeed, but failed with error: \(error)")
        }
    }
    
    func test_play_setsDidPlayTrue() {
        mockService.play()
        XCTAssertTrue(didPlay)
    }
    
    func test_pause_setsDidPauseTrue() {
        mockService.pause()
        XCTAssertTrue(didPause)
    }
    
    func test_seek_setsSeekedTime() {
        mockService.seek(90)
        XCTAssertEqual(seekedTime, 90)
    }
    
    func test_setRate_setsPlaybackRate() {
        mockService.setRate(1.5)
        XCTAssertEqual(setPlaybackRate, 1.5)
    }
    
    func test_currentTime_returnsCorrectValue() {
        XCTAssertEqual(mockService.currentTime(), 120)
    }
    
    func test_duration_returnsCorrectValue() {
        XCTAssertEqual(mockService.duration(), 300)
    }
    
    func test_status_returnsPlaying() {
        XCTAssertEqual(mockService.status(), .playing)
    }
    
    func test_chapterIndex_returnsCorrectValue() {
        XCTAssertEqual(mockService.chapterIndex(), 1)
    }
    
    func test_setChapter_setsChapterIndex() {
        mockService.setChapter(2)
        XCTAssertEqual(chapterIndexSet, 2)
    }
}
