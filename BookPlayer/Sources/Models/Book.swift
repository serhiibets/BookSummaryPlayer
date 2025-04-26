//
//  Book.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation

struct Book: Equatable, Identifiable {
    let id: UUID
    let title: String
    let author: String
    let coverImage: String
    let chapters: [Chapter]
    let audioURL: URL
}
