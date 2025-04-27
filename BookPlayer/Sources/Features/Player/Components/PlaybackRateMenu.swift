//
//  PlaybackRateMenu.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation
import SwiftUI

struct PlaybackRateMenu: View {
    let currentRate: Float
    let onSelect: (Float) -> Void
    
    var body: some View {
        Menu {
            ForEach([0.5, 0.75, 1.0, 1.25, 1.5, 2.0], id: \.self) { rate in
                let floatRate = Float(rate)
                Button {
                    onSelect(floatRate)
                } label: {
                    Label(
                        "\(floatRate, specifier: "%.2f")×",
                        systemImage: floatRate == currentRate ? "checkmark" : ""
                    )
                }
            }
        } label: {
            Image(systemName: "speedometer")
                .font(.title2)
        }
    }
}

#Preview {
    PlaybackRateMenu(currentRate: 1.0, onSelect: { _ in })
}