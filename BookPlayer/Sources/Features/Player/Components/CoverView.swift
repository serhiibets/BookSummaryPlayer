//
//  CoverView.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation
import SwiftUI

struct CoverView: View {
    let book: Book
    
    var body: some View {
        Image(book.coverImage)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 300)
            .cornerRadius(8)
            .shadow(radius: 5)
    }
}

#Preview {
    CoverView(book: .sample)
}