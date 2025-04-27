import XCTest
import ComposableArchitecture
@testable import BookPlayer

final class PlayerFeatureExtraTests: XCTestCase {
    
    func test_sleepTimerSelected_offCancelsTimer() async throws {
        let store = await TestStore(initialState: PlayerFeature.State(book: .sample)) {
            PlayerFeature()
        }

        await store.send(.sleepTimerSelected(.off)) {
            $0.sleepTimer = .off
        }
    }
    
    func test_rewindTapped_underThreshold_resetsToZero() async throws {
        let store = await TestStore(initialState: PlayerFeature.State(
            book: .sample,
            currentTime: 2,
            duration: 300
        )) {
            PlayerFeature()
        } withDependencies: {
            $0.audioService.seek = { _ in }
        }

        await store.send(.rewindTapped) {
            $0.currentTime = 0
        }
    }
    
    func test_forwardTapped_nearEnd_doesNotGoOverDuration() async throws {
        let store = await TestStore(initialState: PlayerFeature.State(
            book: .sample,
            currentTime: 290,
            duration: 300
        )) {
            PlayerFeature()
        } withDependencies: {
            $0.audioService.seek = { _ in }
        }

        await store.send(.forwardTapped) {
            $0.currentTime = 300
        }
    }
    
    func test_nextChapterTapped_atLastChapter_doesNothing() async throws {
        let book = Book(
            id: UUID(),
            title: "Test Book",
            author: "Author",
            coverImage: "",
            chapters: [
                Chapter(id: UUID(), title: "Chapter 1", duration: 120, audioURL: URL(string: "https://test1.com")!),
                Chapter(id: UUID(), title: "Chapter 2", duration: 130, audioURL: URL(string: "https://test2.com")!)
            ],
            audioURL: URL(string: "https://testmain.com")!
        )
        
        let store = await TestStore(initialState: PlayerFeature.State(
            book: book,
            currentChapterIndex: 1
        )) {
            PlayerFeature()
        }

        await store.send(.nextChapterTapped)
        // No state changes expected
    }
    
    func test_previousChapterTapped_atFirstChapter_doesNothing() async throws {
        let store = await TestStore(initialState: PlayerFeature.State(
            book: .sample,
            currentChapterIndex: 0
        )) {
            PlayerFeature()
        }

        await store.send(.previousChapterTapped)
        // No state changes expected
    }
    
    func test_playbackStatusChanged_readyToPlay_cancelsTimer() async throws {
        let store = await TestStore(initialState: PlayerFeature.State(
            book: .sample,
            playbackStatus: .playing
        )) {
            PlayerFeature()
        }

        await store.send(.playbackStatusChanged(.readyToPlay)) {
            $0.playbackStatus = .readyToPlay
        }
    }
    
    func test_playbackStatusChanged_paused_cancelsTimer() async throws {
        let store = await TestStore(initialState: PlayerFeature.State(
            book: .sample,
            playbackStatus: .playing
        )) {
            PlayerFeature()
        }

        await store.send(.playbackStatusChanged(.paused)) {
            $0.playbackStatus = .paused
        }
    }
    
    func test_playbackStatusChanged_failed_cancelsTimer() async throws {
        let store = await TestStore(initialState: PlayerFeature.State(
            book: .sample,
            playbackStatus: .playing
        )) {
            PlayerFeature()
        }

        let error = NSError(domain: "TestError", code: 123)

        await store.send(.playbackStatusChanged(.failed(error))) {
            $0.playbackStatus = .failed(error)
        }
    }
}


