//
//  SleapTimerMenu.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation
import SwiftUI
import ComposableArchitecture

import SwiftUI

struct SleepTimerMenu: View {
    @State private var selectedTimer: SleepTimer = .off
    
    var body: some View {
        Menu {
            Button("Off") {
                selectedTimer = .off
                print("Sleep Timer: Off")
            }
            Button("5 minutes") {
                selectedTimer = .minutes(5)
                print("Sleep Timer: 5 minutes")
            }
            Button("10 minutes") {
                selectedTimer = .minutes(10)
                print("Sleep Timer: 10 minutes")
            }
        } label: {
            Image(systemName: "moon.zzz")
                .font(.title2)
        }
    }
}

private enum SleepTimer: Equatable {
    case off
    case minutes(Int)
}

#Preview("Sleep Timer Menu", traits: .sizeThatFitsLayout) {
    SleepTimerMenu().padding()
}
