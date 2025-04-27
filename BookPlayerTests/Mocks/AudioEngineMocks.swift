//
//  AudioEngineMocks.swift
//  BookPlayerTests
//
//  Created by Serhii Bets on 27/4/25.
//

import Foundation
import AVFoundation
import AudioKit
@testable import BookPlayer

// MARK: - Mock Classes

final class MockAudioEngine: AudioEngineProtocol {
    var output: (any AudioKit.Node)?
    
    var avEngine = AVAudioEngine()
    var isStarted = false
    
    func start() throws {
        isStarted = true
    }
}

final class MockAudioPlayer: AudioPlayerProtocol, Node {
    var connections: [any AudioKit.Node] = []
    var avAudioNode: AVAudioNode = AVAudioNode() 

    var isPlaying = false
    var isStarted = false
    var currentTime: TimeInterval = 0
    var duration: TimeInterval = 300

    func play() {
        isPlaying = true
        isStarted = true
    }

    func pause() {
        isPlaying = false
    }

    func seek(time: TimeInterval) {
        currentTime = time
    }

    func load(file: AVAudioFile) throws {
        isStarted = true
    }
}
