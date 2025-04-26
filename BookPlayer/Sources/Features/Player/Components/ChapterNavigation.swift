//
//  ChapterNavigationView.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import SwiftUI

struct ChapterNavigation: View {
    @State private var currentChapterIndex: Int = 1
    let chapters: [Chapter]
    
    var body: some View {
        HStack {
            Button {
                previousChapter()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            .disabled(currentChapterIndex == 0)

            Picker(
                "Chapter",
                selection: $currentChapterIndex
            ) {
                ForEach(Array(chapters.enumerated()), id: \.element.id) { index, chapter in
                    Text(chapter.title).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity)

            Button {
                nextChapter()
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
            .disabled(currentChapterIndex >= chapters.count - 1)
        }
        .padding(.horizontal)
    }
    
    private func previousChapter() {
        if currentChapterIndex > 0 {
            currentChapterIndex -= 1
        }
    }
    
    private func nextChapter() {
        if currentChapterIndex < chapters.count - 1 {
            currentChapterIndex += 1
        }
    }
}

#Preview("Chapter Navigation", traits: .sizeThatFitsLayout) {
    ChapterNavigation(
        chapters: [
            Chapter.init(id: UUID(), title: "Chapter 1", duration: 180, audioURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!),
            Chapter.init(id: UUID(), title: "Chapter 2", duration: 240, audioURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3")!),
            Chapter.init(id: UUID(), title: "Chapter 3", duration: 300, audioURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3")!)
        ]
    )
    .padding()
}
