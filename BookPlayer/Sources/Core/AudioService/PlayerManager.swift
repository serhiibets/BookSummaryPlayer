//
//  PlayerManager.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import AudioKit
import AVFoundation
import Foundation

/// Handles low-level audio playback using AudioKit
final class PlayerManager {
    private let engine: AudioEngine
    private let player: AudioPlayer
    internal let speedControl: VariSpeed
    private var currentChapterIndex = 0
    private var chapters: [Chapter] = []

    init(engine: AudioEngine = AudioEngine(), player: AudioPlayer = AudioPlayer()) {
        self.engine = engine
        self.player = player
        speedControl = VariSpeed(player)
        engine.output = speedControl
        try? configureAudioSession()
        try? startEngine()
    }

    // MARK: - Public API

    func load(_ url: URL) async throws {
        do {
            let audioURL = try await prepareAudioFile(from: url)
            let file = try AVAudioFile(forReading: audioURL)
            try player.load(file: file)
        } catch let error as PlayerServiceError {
            throw error
        } catch {
            throw PlayerServiceError.unknown(error)
        }
    }

    func play() {
        restartEngineIfNeeded()
        player.play()
    }

    func pause() {
        player.pause()
    }

    func seek(_ time: TimeInterval) {
        LoggerService.shared.log("[AudioService] Seek to time: \(time)")
        player.seek(time: time)
    }

    func setRate(_ rate: Float) {
        speedControl.rate = rate
    }

    func currentTime() -> TimeInterval {
        LoggerService.shared.log("[AudioService] Current time: \(player.currentTime)")
        return player.currentTime
    }

    func duration() -> TimeInterval {
        player.duration
    }

    func status() -> PlayerService.PlaybackStatus {
        if player.isPlaying {
            return .playing
        } else if player.isStarted {
            return .paused
        } else {
            return .readyToPlay
        }
    }

    func chapterIndex() -> Int {
        currentChapterIndex
    }

    func setChapters(_ chapters: [Chapter]) {
        self.chapters = chapters
    }

    func setChapter(_ index: Int) {
        guard index >= 0 && index < chapters.count else { return }
        currentChapterIndex = index

        Task {
            do {
                let chapter = chapters[index]
                let localURL = try await prepareAudioFile(from: chapter.audioURL)
                let file = try AVAudioFile(forReading: localURL)
                try player.load(file: file)
                player.play()
            } catch {
                LoggerService.shared.log("[AudioService] Failed to load chapter audio: \(error)")
            }
        }
    }

    // MARK: - Private helpers

    private func configureAudioSession() throws {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            LoggerService.shared.log("[AudioService] Audio session setup failed: \(error)")
            throw PlayerServiceError.audioSessionSetupFailed
        }
    }

    private func startEngine() throws {
        do {
            try engine.start()
        } catch {
            LoggerService.shared.log("[AudioService] AudioEngine failed to start: \(error)")
            throw PlayerServiceError.audioEngineFailed
        }
    }

    private func restartEngineIfNeeded() {
        if !engine.avEngine.isRunning {
            try? startEngine()
        }
    }

    private func prepareAudioFile(from url: URL) async throws -> URL {
        if url.isFileURL {
            return url
        } else {
            let tempDir = FileManager.default.temporaryDirectory
            let tempFile = tempDir.appendingPathComponent(UUID().uuidString + ".mp3")
            do {
                let (tempURL, _) = try await URLSession.shared.download(from: url)
                try FileManager.default.moveItem(at: tempURL, to: tempFile)
                return tempFile
            } catch {
                throw PlayerServiceError.downloadFailed(url)
            }
        }
    }
}
