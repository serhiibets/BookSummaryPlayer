//
//  ControlsView.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct ControlsView: View {
    @State private var isPlaying = false
    @State private var playbackRate: Float = 1.0
    
    var body: some View {
        HStack(spacing: 40) {
            PlaybackRateMenu(currentRate: playbackRate) { rate in
                playbackRate = rate
            }
            
            ControlButton(icon: "gobackward.15") {
                // Handle rewind
            }
            
            PlayPauseButton(isPlaying: isPlaying) {
                isPlaying.toggle()
            }
            
            ControlButton(icon: "goforward.15") {
                // Handle forward
            }
            
            SleepTimerMenu()
        }
        .foregroundColor(.primary)
        .padding(.vertical)
    }
}

#Preview {
    ControlsView().padding()
}
