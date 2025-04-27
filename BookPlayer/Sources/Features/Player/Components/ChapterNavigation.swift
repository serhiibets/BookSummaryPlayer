//
//  ChapterNavigationView.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct ChapterNavigation: View {
    let viewStore: ViewStore<PlayerFeature.State, PlayerFeature.Action>

    var body: some View {
        HStack {
            Button {
                viewStore.send(.previousChapterTapped)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            .disabled(viewStore.currentChapterIndex == 0)

            Picker(
                "Chapter",
                selection: viewStore.binding(
                    get: \.currentChapterIndex,
                    send: PlayerFeature.Action.chapterSelected
                )
            ) {
                ForEach(Array(viewStore.book.chapters.enumerated()), id: \.element.id) { index, chapter in
                    Text(chapter.title).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity)

            Button {
                viewStore.send(.nextChapterTapped)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
            .disabled(viewStore.currentChapterIndex >= viewStore.book.chapters.count - 1)
        }
        .padding(.horizontal)
    }
}

#Preview("Chapter Navigation", traits: .sizeThatFitsLayout) {
    ChapterNavigation(
        viewStore: ViewStore(
            Store(
                initialState: PlayerFeature.State(
                    book: Book.sample,
                    currentChapterIndex: 1,
                    currentTime: 0,
                    duration: 300,
                    playbackRate: 1.0,
                    playbackStatus: .paused
                ),
                reducer: { PlayerFeature() }
            ),
            observe: { $0 }
        )
    )
    .padding()
}
