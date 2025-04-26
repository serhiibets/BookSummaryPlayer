//
//  ContentView.swift
//  BookSummaryPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import SwiftUI

struct PlayerView: View {
    @State private var isDraggingSlider = false
    @State private var draggedTime: TimeInterval = 0
    
    @State private var book = Book.sample
    @State private var currentChapterIndex = 0
    @State private var currentTime: TimeInterval = 0
    @State private var duration: TimeInterval = 300
    @State private var isPlaying = false
    @State private var playbackRate: Float = 1.0
    @State private var error: String? = nil
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                CoverView(book: book)
                BookInfoView(book: book)
                
                ProgressSliderView(
                    currentTime: currentTime,
                    duration: duration,
                    isDragging: $isDraggingSlider,
                    draggedTime: $draggedTime
                ) { time in
                    currentTime = time
                }
                
                ChapterNavigation(
                    chapters: book.chapters
                )
                
                ControlsView()
            }
            .padding()
        }
        .alert("Playback Error", isPresented: Binding(
            get: { error != nil },
            set: { _ in error = nil }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(error ?? "Unknown error")
        }
    }
}

#Preview {
    PlayerView()
}
