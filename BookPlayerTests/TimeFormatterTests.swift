//
//  TimeFormatterTests.swift
//  BookPlayerTests
//
//  Created by Serhii Bets on 27/4/25.
//

import XCTest
@testable import BookPlayer

final class TimeFormatterTests: XCTestCase {
    func test_timeFormatting() {
        let formatter = TimeFormatter.shared
        
        XCTAssertEqual(formatter.string(for: 0), "0:00")
        XCTAssertEqual(formatter.string(for: 5), "0:05")
        XCTAssertEqual(formatter.string(for: 75), "1:15")
        XCTAssertEqual(formatter.string(for: 3600), "60:00")
    }
}
