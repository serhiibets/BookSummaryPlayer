//
//  PlayerFeature.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//
import ComposableArchitecture
import Foundation

struct PlayerFeature: Reducer {
    struct State: Equatable {
        var book: Book
        var currentChapterIndex = 0
        var currentTime: TimeInterval = 0
        var duration: TimeInterval = 0
        var playbackRate: Float = 1.0
        var playbackStatus: PlayerService.PlaybackStatus = .readyToPlay
        var error: String?
        var sleepTimer: SleepTimer? = nil
    }
    
    enum SleepTimer: Equatable {
        case off
        case minutes(Int)
    }
    
    enum Action: Equatable {
        case onAppear
        case playPauseTapped
        case forwardTapped
        case rewindTapped
        case chapterSelected(Int)
        case nextChapterTapped
        case previousChapterTapped
        case rateSelected(Float)
        case seek(TimeInterval)
        case timerTick
        case playbackStatusChanged(PlayerService.PlaybackStatus)
        case playbackFailed(PlayerServiceError)
        case sleepTimerSelected(SleepTimer)
        case sleepTimerFired
    }
    
    @Dependency(\.audioService) var audioService
    @Dependency(\.continuousClock) var clock
    
    private enum CancelID { case timer, sleepTimer }
    
    private enum Constants {
        static let forwardSkipInterval: TimeInterval = 10
        static let backSkipInterval: TimeInterval = 5

        static let rewindThreshold: TimeInterval = 3
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        
        // MARK: - Lifecycle
        case .onAppear:
            return loadAudio(state: &state)
        
        // MARK: - Playback
        case .playPauseTapped:
            return handlePlayPause(state: &state)
        
        // MARK: - Seeking
        case .forwardTapped:
            return skip(forward: true, state: &state)
            
        case .rewindTapped:
            return skip(forward: false, state: &state)
            
        case let .seek(time):
            audioService.seek(time)
            return .none
        
        // MARK: - Chapter, Rate
        case let .chapterSelected(index):
            state.currentChapterIndex = index
            audioService.setChapter(index)
            state.currentTime = 0
            state.duration = 0
            return .none
            
        case .nextChapterTapped:
            let nextIndex = state.currentChapterIndex + 1
            guard nextIndex < state.book.chapters.count else { return .none }
            state.currentChapterIndex = nextIndex
            audioService.setChapter(nextIndex)
            state.currentTime = 0
            state.duration = 0
            return .none

        case .previousChapterTapped:
            let previousIndex = state.currentChapterIndex - 1
            guard previousIndex >= 0 else { return .none }
            state.currentChapterIndex = previousIndex
            audioService.setChapter(previousIndex)
            state.currentTime = 0
            state.duration = 0
            return .none
            
        case let .rateSelected(rate):
            state.playbackRate = rate
            audioService.setRate(rate)
            return .none
        
        // MARK: - Timer
        case .timerTick:
            state.currentTime += 1
            state.duration = audioService.duration()
            return .none
            
        // MARK: - Playback Status
        case let .playbackStatusChanged(status):
            return handlePlaybackStatusChange(status: status, state: &state)
        
        // MARK: - Errors
        case let .playbackFailed(errorMessage):
            return handleError(errorMessage: errorMessage.errorDescription!, state: &state)
            
        case let .sleepTimerSelected(timer):
            state.sleepTimer = timer
        
            switch timer {
            case .off:
                return .cancel(id: CancelID.sleepTimer)
            
            case let .minutes(minutes):
                return .run { send in
                    try await clock.sleep(for: .seconds(minutes * 60))
                    await send(.sleepTimerFired)
                }
                .cancellable(id: CancelID.sleepTimer, cancelInFlight: true)
            }
        
        case .sleepTimerFired:
            audioService.pause()
            return .send(.playbackStatusChanged(.paused))
        }
    }
    
    // MARK: - Private helpers
    
    private func loadAudio(state: inout State) -> Effect<Action> {
        .run { [book = state.book] send in
            do {
                try await audioService.load(book.audioURL, book.chapters)
                await send(.playbackStatusChanged(.readyToPlay))
            } catch {
                await send(.playbackFailed(PlayerServiceError.unknown(error)))
            }
        }
    }
    
    private func handlePlayPause(state: inout State) -> Effect<Action> {
        switch state.playbackStatus {
        case .readyToPlay, .paused:
            audioService.play()
            return .send(.playbackStatusChanged(.playing))
        case .playing:
            audioService.pause()
            return .send(.playbackStatusChanged(.paused))
        default:
            return .none
        }
    }
    
    private func skip(forward: Bool, state: inout State) -> Effect<Action> {
        let current = state.currentTime
        let duration = state.duration
        
        let newTime: TimeInterval
        if forward {
            newTime = min(current + Constants.forwardSkipInterval, duration)
        } else {
            if current > Constants.rewindThreshold {
                newTime = max(current - Constants.backSkipInterval, 0)
            } else {
                newTime = 0
            }
        }
        
        state.currentTime = newTime
        audioService.seek(newTime)
        return .none
    }
    
    private func handlePlaybackStatusChange(status: PlayerService.PlaybackStatus, state: inout State) -> Effect<Action> {
        state.playbackStatus = status
        
        switch status {
        case .playing:
            return .run { send in
                for await _ in clock.timer(interval: .seconds(1)) {
                    await send(.timerTick)
                }
            }
            .cancellable(id: CancelID.timer)
        default:
            return .cancel(id: CancelID.timer)
        }
    }
    
    private func handleError(errorMessage: String, state: inout State) -> Effect<Action> {
        state.error = errorMessage
        state.playbackStatus = .failed(
            NSError(domain: "PlayerFeature", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        )
        return .none
    }
}
