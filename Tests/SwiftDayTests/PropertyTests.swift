//
//  PropertyTests.swift
//  SwiftDayTests
//
//  Created by wangyu on 10/13/21.
//

import XCTest
import SwiftDay

class PropertyTests: XCTestCase {
    func testExample() throws {
        let d = Day.init(year: 2021, month: 10, day: 10, hour: 10, minute: 10, second: 10, millisecond: 10)
        XCTAssert(d.year == 2021)
        XCTAssert(d.month == 10)
        XCTAssert(d.day == 10)
        XCTAssert(d.date == 1)
        XCTAssert(d.minute == 10)
        XCTAssert(d.second == 10)
        XCTAssert(d.millisecond == 10)
        d.year = 2022
        d.month = 11
        d.day = 11
        d.date = 6
        d.hour = 11
        d.minute = 11
        d.second = 11
        d.millisecond = 11
        XCTAssert(d.year == 2022)
        XCTAssert(d.month == 11)
        XCTAssert(d.day == 11)
        XCTAssert(d.date == 6)
        XCTAssert(d.minute == 11)
        XCTAssert(d.second == 11)
        XCTAssert(d.millisecond == 11)
    }
}
