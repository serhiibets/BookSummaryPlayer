//
//  LoggerService.swift
//  BookPlayer
//
//  Created by Serhii Bets on 26/4/25.
//

import Foundation

/// Simple logger service to unify logs
final class LoggerService {
    static let shared = LoggerService()
    
    private init() {}

    func log(_ message: String) {
        print("[LOG]", message)
    }
}
