//
//  ContentView.swift
//  BookSummaryPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import SwiftUI
import ComposableArchitecture

/// Main Audio Player View
struct PlayerView: View {
    let store: StoreOf<PlayerFeature>
    
    @State private var isDraggingSlider = false
    @State private var draggedTime: TimeInterval = 0
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    CoverView(book: viewStore.book)
                    BookInfoView(book: viewStore.book)
                    
                    ProgressSlider(
                        currentTime: viewStore.currentTime,
                        duration: viewStore.duration,
                        isDragging: $isDraggingSlider,
                        draggedTime: $draggedTime
                    ) { time in
                        viewStore.send(.seek(time))
                    }
                    
                    ChapterNavigation(viewStore: viewStore)
                    
                    ControlsView(viewStore: viewStore)
                }
                .padding()
            }
            .onAppear { viewStore.send(.onAppear) }
            .alert(
                "Playback Error",
                isPresented: viewStore.binding(
                    get: { $0.error != nil },
                    send: .playbackStatusChanged(.readyToPlay)
                )
            ) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewStore.error ?? "Unknown error")
            }
        }
    }
}
