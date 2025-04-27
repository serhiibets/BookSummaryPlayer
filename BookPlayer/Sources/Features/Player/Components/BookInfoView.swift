//
//  BookInfoView.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation
import SwiftUI

struct BookInfoView: View {
    let book: Book
    
    var body: some View {
        VStack(spacing: 4) {
            Text(book.title)
                .font(.title2.bold())
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    BookInfoView(book: .sample)
}