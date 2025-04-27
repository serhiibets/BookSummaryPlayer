//
//  SleepTimerMenu.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct SleepTimerMenu: View {
    let send: (PlayerFeature.Action) -> Void
    
    var body: some View {
        Menu {
            Button("Off") {
                send(.sleepTimerSelected(.off))
            }
            Button("5 minutes") {
                send(.sleepTimerSelected(.minutes(5)))
            }
            Button("10 minutes") {
                send(.sleepTimerSelected(.minutes(10)))
            }
        } label: {
            Image(systemName: "moon.zzz")
                .font(.title2)
        }
    }
}

#Preview {
    SleepTimerMenu(send: { _ in })
}