//
//  Book.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation

/// Represents a Book containing chapters and metadata
struct Book: Equatable, Identifiable {
    let id: UUID
    let title: String
    let author: String
    let coverImage: String
    let chapters: [Chapter]
    let audioURL: URL
}

extension Book {
    static let sample = Book(
        id: UUID(),
        title: "The Hitchhiker's Guide to the Galaxy",
        author: "Douglas Adams",
        coverImage: "hitchhikers_guide",
        chapters: [
            .init(id: UUID(), title: "Chapter 1", duration: 180, audioURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!),
            .init(id: UUID(), title: "Chapter 2", duration: 240, audioURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3")!),
            .init(id: UUID(), title: "Chapter 3", duration: 300, audioURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3")!)
        ],
        audioURL: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!
    )
}
