//
//  InitTests.swift
//  SwiftDayTests
//
//  Created by wangyu on 10/12/21.
//

import XCTest
@testable import SwiftDay

class InitTests: XCTestCase {

    func testInit() throws {
        var d: Day
        d = Day.init()
        XCTAssert(d.isValid())
        let td: Date = Date()
        d = Day.init(date: td)
        XCTAssert(d.isValid())
        XCTAssert(d.toDate()!.timeIntervalSince1970 == td.timeIntervalSince1970)
        d = Day.init(string: "2021-10-10 10:10:10")
        XCTAssert(d.isValid())
        XCTAssert(d.format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-10 10:10:10")
        d = Day.init(timestamp: 1634028300)
        XCTAssert(d.isValid())
        XCTAssert(d.format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-12 16:45:00")
        d = Day.init(year: 2021)
        XCTAssert(d.isValid())
        XCTAssert(d.format(format: "yyyy-MM-dd HH:mm:ss") == "2021-01-01 00:00:00")
        d = Day.init(year: 2021, month: 10, day: 10, hour: 10, minute: 10, second: 10, millisecond: 10)
        XCTAssert(d.isValid())
        XCTAssert(d.format(format: "yyyy-MM-dd HH:mm:ss.SSS") == "2021-10-10 10:10:10.010")
    }
}
