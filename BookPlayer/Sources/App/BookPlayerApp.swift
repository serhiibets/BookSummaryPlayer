//
//  BookSummaryPlayerApp.swift
//  BookSummaryPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct BookPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            PlayerView(store: Store(initialState: PlayerFeature.State(book: .sample), reducer: {
                PlayerFeature()._printChanges()
            }))
        }
    }
}

#Preview {
    PlayerView(store: Store(initialState: PlayerFeature.State(book: .sample), reducer: {
        PlayerFeature()._printChanges()
    }))
}
