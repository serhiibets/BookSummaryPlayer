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
    let viewStore: ViewStore<PlayerFeature.State, PlayerFeature.Action>
    
    var body: some View {
        HStack(spacing: 40) {
            PlaybackRateMenu(currentRate: viewStore.playbackRate) { rate in
                viewStore.send(.rateSelected(rate))
            }
            
            ControlButton(icon: "gobackward.5") {
                viewStore.send(.rewindTapped)
            }
            
            PlayPauseButton(isPlaying: viewStore.playbackStatus == .playing) {
                viewStore.send(.playPauseTapped)
            }
            
            ControlButton(icon: "goforward.10") {
                viewStore.send(.forwardTapped)
            }
            
            SleepTimerMenu { action in
                viewStore.send(action)
            }
        }
        .foregroundColor(.primary)
        .padding(.vertical)
    }
}

#Preview("Controls View", traits: .sizeThatFitsLayout) {
    ControlsView(
        viewStore: ViewStore(
            Store(
                initialState: PlayerFeature.State(
                    book: .sample,
                    currentChapterIndex: 0,
                    currentTime: 0,
                    duration: 300,
                    playbackRate: 1.0,
                    playbackStatus: .paused
                ),
                reducer: {
                    PlayerFeature()
                }
            ), observe: { $0 }
        )
    )
    .padding()
}
