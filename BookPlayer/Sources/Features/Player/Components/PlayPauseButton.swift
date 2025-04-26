//
//  PlayPauseButtonView.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import SwiftUI

struct PlayPauseButton: View {
    let isPlaying: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .font(.system(size: 50))
                .scaleEffect(isPlaying ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.3), value: isPlaying)
        }
    }
}

#Preview("Play Button", traits: .sizeThatFitsLayout) {
    PlayPauseButton(isPlaying: false) {}
        .padding()
}

#Preview("Pause Button", traits: .sizeThatFitsLayout) {
    PlayPauseButton(isPlaying: true) {}
        .padding()
}
