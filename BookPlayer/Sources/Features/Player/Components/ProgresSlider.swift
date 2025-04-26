//
//  ProgresSliderView.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation
import SwiftUI

struct ProgressSliderView: View {
    let currentTime: TimeInterval
    let duration: TimeInterval
    @Binding var isDragging: Bool
    @Binding var draggedTime: TimeInterval
    var onSeek: (TimeInterval) -> Void
    
    var body: some View {
        VStack {
            Slider(
                value: Binding(
                    get: {
                        isDragging ? draggedTime : currentTime
                    },
                    set: { newValue in
                        isDragging = true
                        draggedTime = newValue
                    }
                ),
                in: 0...max(duration, 1),
                onEditingChanged: { editing in
                    if !editing {
                        onSeek(draggedTime)
                        isDragging = false
                    }
                }
            )
            .accentColor(.blue)
            .animation(.easeInOut(duration: 0.25), value: isDragging)
            
            HStack {
                Text(TimeFormatter.shared.string(for: isDragging ? draggedTime : currentTime))
                Spacer()
                Text(TimeFormatter.shared.string(for: duration))
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProgressSliderView(
        currentTime: 10,
        duration: 100,
        isDragging: .constant(false),
        draggedTime: .constant(0),
        onSeek: { _ in }
    )
}