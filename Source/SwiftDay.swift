//
//  SwiftDay.swift
//  swift-demo
//
//  Created by wangyu on 4/2/21.
//

import Foundation

public enum DayUnit {
    case millisecond
    
    case second
    
    case minute
    
    case hour
    
    case day
    
    case week
        
    case month
    
    case quarter
        
    case year
    
    case date
}

let SECONDS_A_MINUTE : Double = 60
let SECONDS_A_HOUR : Double = SECONDS_A_MINUTE * 60
let SECONDS_A_DAY : Double = SECONDS_A_HOUR * 24
let SECONDS_A_WEEK : Double = SECONDS_A_DAY * 7

let MILLISECONDS_A_SECOND : Double = 1e3
let MILLISECONDS_A_MINUTE : Double = SECONDS_A_MINUTE * MILLISECONDS_A_SECOND
let MILLISECONDS_A_HOUR : Double = SECONDS_A_HOUR * MILLISECONDS_A_SECOND
let MILLISECONDS_A_DAY : Double = SECONDS_A_DAY * MILLISECONDS_A_SECOND
let MILLISECONDS_A_WEEK : Double = SECONDS_A_WEEK * MILLISECONDS_A_SECOND

let FORMAT_DEFAULT : String = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
let FORMAT_ISO8601 : String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
let INVALID_DATE_STRING : String = "Invalid Date"

let REGEX_PARSE : String = "^(\\d{4})[-]?(\\d{1,2})?[-]?(\\d{0,2})[^0-9]*(\\d{1,2})?:?(\\d{1,2})?:?(\\d{1,2})?[.:]?(\\d+)?$"

// MARK: class Day

public class Day {
    private var innerDate : Date!
    private var dateformatter: DateFormatter = DateFormatter()
    
    // current time
    init() {
        self.innerDate = Date.init()
    }
    
    // init with day
    init(anotherDay: Day) {
        self.innerDate = anotherDay.innerDate
        self.dateformatter = anotherDay.dateformatter
    }
    
    // init with timestamp
    init(timestamp: Double) {
        self.innerDate = Date.init(timeIntervalSince1970: TimeInterval(timestamp))
    }
    
    // init with string format
    // yyyy-MM-ddTHH:mm:ss.SSSXXXXX ~ 2021-01-02T03:04:05.666Z
    
    // yyyy ~ 2021
    // yyyyMM / yyyy-MM ~ 2021:01
    // yyyyMMdd / yyyy-MM-dd ~ 2021-01-02
    // yyyyMMddHH / yyyy-MM-dd HH ~ 2021-01-02 03
    // yyyyMMddHHmm / yyyy-MM-dd HH:mm ~ 2021-01-02 03:04
    // yyyyMMddHHmmss / yyyy-MM-dd HH:mm:ss ~ 2021-01-02 03:04:05
    // yyyyMMddHHmmssSSS / yyyy-MM-dd HH:mm:ss.SSS ~ 2021-01-02 03:04:05.666
    init(string: String) {
        let _regex : NSRegularExpression = try! NSRegularExpression(pattern: REGEX_PARSE, options: [])
    
        let _matches : [NSTextCheckingResult] = _regex.matches(in: string, options: [], range: NSRange.init(location: 0, length: string.count))
    
        if _matches.count > 0 {
            var _params : [Int] = [Int](repeating: 0, count: 7)
            for _index in 1...7 {
                let _range = _matches[0].range(at: _index)
                if _range.length == 0 {
                    break
                }
    
                let _value : String = string.substring(_range.location, _range.length) ?? "0"
                _params[_index - 1] = Int(_value)!
            }
            
            self.innerDate = Date(timeIntervalSince1970: TimeInterval(0))
            self.innerDate = Calendar.current.date(bySetting: .year, value: _params[0], of: self.innerDate)
            self.innerDate = Calendar.current.date(bySetting: .month, value: _params[1], of: self.innerDate)
            self.innerDate = Calendar.current.date(bySetting: .day, value: _params[2], of: self.innerDate)
            self.innerDate = Calendar.current.date(bySetting: .hour, value: _params[3], of: self.innerDate)
            self.innerDate = Calendar.current.date(bySetting: .minute, value: _params[4], of: self.innerDate)
            self.innerDate = Calendar.current.date(bySetting: .second, value: _params[5], of: self.innerDate)
            self.innerDate = Calendar.current.date(bySetting: .nanosecond, value: _params[6] * 1000000, of: self.innerDate)
        } else {
            self.dateformatter.dateFormat = FORMAT_DEFAULT
            self.innerDate = self.dateformatter.date(from: string)
        }
    }
    
    // init with user string format
    init(string : String, format : String) {
        self.dateformatter.dateFormat = format
        self.innerDate = self.dateformatter.date(from: string)
    }
    
    // init with year, month, day, hour, minute, second, millisecond
    init(year : Int,
         month : Int = 0,
         day : Int = 0,
         hour : Int = 0,
         minute : Int = 0,
         second : Int = 0,
         millisecond : Int = 0) {
                
        self.innerDate = Date(timeIntervalSince1970: TimeInterval(0))
        self.innerDate = Calendar.current.date(bySetting: .year, value: year, of: self.innerDate)
        self.innerDate = Calendar.current.date(bySetting: .month, value: month, of: self.innerDate)
        self.innerDate = Calendar.current.date(bySetting: .day, value: day, of: self.innerDate)
        self.innerDate = Calendar.current.date(bySetting: .hour, value: hour, of: self.innerDate)
        self.innerDate = Calendar.current.date(bySetting: .minute, value: minute, of: self.innerDate)
        self.innerDate = Calendar.current.date(bySetting: .second, value: second, of: self.innerDate)
        self.innerDate = Calendar.current.date(bySetting: .nanosecond, value: millisecond * 1000000, of: self.innerDate)
    }
    
    // MARK: property
    public var millisecond: (Int) {
        get {
            return Calendar.current.component(.nanosecond, from: self.innerDate) / 1000000
        }
        set (ns) {
            self.innerDate = Calendar.current.date(bySetting: .nanosecond, value: ns * 1000000, of: self.innerDate)
        }
    }
    
    
    public var second: (Int) {
        get {
            return Calendar.current.component(.second, from: self.innerDate)
        }
        set (s) {
            self.innerDate = Calendar.current.date(bySetting: .second, value: s, of: self.innerDate)
        }
    }
    
    public var minute: (Int) {
        get {
            return Calendar.current.component(.minute, from: self.innerDate)
        }
        set (m) {
            self.innerDate = Calendar.current.date(bySetting: .second, value: m, of: self.innerDate)
        }
    }
    
    public var hour: (Int) {
        get {
            return Calendar.current.component(.hour, from: self.innerDate)
        }
        set (h) {
            self.innerDate = Calendar.current.date(bySetting: .hour, value: h, of: self.innerDate)
        }
    }
    
    public var day: (Int) {
        get {
            return Calendar.current.component(.weekday, from: self.innerDate)
        }
        set (d) {
            self.innerDate = Calendar.current.date(bySetting: .weekday, value: d, of: self.innerDate)
        }
    }
    
    public var date: (Int) {
        get {
            return Calendar.current.component(.day, from: self.innerDate)
        }
        set (d) {
            self.innerDate = Calendar.current.date(bySetting: .day, value: d, of: self.innerDate)
        }
    }
    
    public var month: (Int) {
        get {
            return Calendar.current.component(.month, from: self.innerDate)
        }
        set (m) {
            self.innerDate = Calendar.current.date(bySetting: .month, value: m, of: self.innerDate)
        }
    }
    
    public var year: (Int) {
        get {
            return Calendar.current.component(.year, from: self.innerDate)
        }
        set (y) {
            self.innerDate = Calendar.current.date(bySetting: .year, value: y, of: self.innerDate)
        }
    }
    
    // MARK: func
    public static func min(days : Day...) -> Day {
        var _d = days[0]
        
        for _index in 1..<days.count {
            if _d.innerDate > days[_index].innerDate {
                _d = days[_index]
            }
        }
        
        return _d
    }
    
    public static func max(days : Day...) -> Day {
        var _d = days[0]
        
        for _index in 1..<days.count {
            if _d.innerDate < days[_index].innerDate {
                _d = days[_index]
            }
        }
        
        return _d
    }
    
    public func valueOf() -> Int {
        return Int(self.innerDate.timeIntervalSince1970 * MILLISECONDS_A_SECOND)
    }
    
    public func unix() -> Int {
        return Int(self.innerDate.timeIntervalSince1970)
    }
    
    public func add(delta : Int, unit : DayUnit) -> Day {
        let _d = self.clone()
        
        switch unit {
        case .second:
            _d.innerDate = Calendar.current.date(byAdding: .second, value: delta, to: _d.innerDate)
            break
        case .minute:
            _d.innerDate = Calendar.current.date(byAdding: .minute, value: delta, to: _d.innerDate)
            break
        case .hour:
            _d.innerDate = Calendar.current.date(byAdding: .hour, value: delta, to: _d.innerDate)
            break
        case .day:
            _d.innerDate = Calendar.current.date(byAdding: .weekday, value: delta, to: _d.innerDate)
            break
        case .month:
            _d.innerDate = Calendar.current.date(byAdding: .month, value: delta, to: _d.innerDate)
            break
        case .year:
            _d.innerDate = Calendar.current.date(byAdding: .year, value: delta, to: _d.innerDate)
            break
        case .millisecond:
            _d.innerDate = Calendar.current.date(byAdding: .nanosecond, value: delta * 1000000, to: _d.innerDate)
            break
        case .date:
            _d.innerDate = Calendar.current.date(byAdding: .day, value: delta, to: _d.innerDate)
            break
        case .week:
            break
        case .quarter:
            break
        }

        return _d
    }

    // subtract enum
    public func subtract(delta : Int, unit : DayUnit) -> Day {
        return add(delta: -delta, unit: unit)
    }
    
    // start of
    public func startOf(unit: DayUnit) -> Day {
        let _year : Int = self.year
        var _month : Int = self.month
        var _day : Int = self.date
        var _hour : Int = self.hour
        var _minute : Int = self.minute
        var _second : Int = self.second
        var _millisecond : Int = self.millisecond
        
        switch unit {
        case .year:
            _month = 1
            fallthrough
        case .month:
            _day = 1
            fallthrough
        case .date:
            _hour = 0
            fallthrough
        case .hour:
            _minute = 0
            fallthrough
        case .minute:
            _second = 0
            fallthrough
        case .second:
            _millisecond = 0
            fallthrough
        case .week: break
        case .day: break
        case .millisecond: break
        case .quarter: break
        }
        
        return Day.init(year: _year, month: _month, day: _day, hour: _hour, minute: _minute, second: _second, millisecond: _millisecond)
    }
    
    // end of
    public func endOf(unit: DayUnit) -> Day {
        
        var _d = self.startOf(unit: unit)
        _d = _d.add(delta: 1, unit: unit)
        _d = _d.subtract(delta: 1, unit: .millisecond)
        
        return _d
    }
    
    // diff
    public func diff(anotherDay : Day, unit : DayUnit) -> Int {
        let _delta = valueOf() - anotherDay.valueOf()
        
        switch unit {
        case .millisecond:
            return _delta
        case .second:
            return _delta / Int(MILLISECONDS_A_SECOND)
        case .minute:
            return _delta / Int(MILLISECONDS_A_MINUTE)
        case .hour:
            return _delta / Int(MILLISECONDS_A_HOUR)
        case .day:
            break
        case .week:
            return _delta / Int(MILLISECONDS_A_MINUTE)
        case .month:
            return (self.year * 12 + self.month) - (anotherDay.year * 12 + anotherDay.month)
        case .year:
            return self.year - anotherDay.year
        case .date:
            return _delta / Int(MILLISECONDS_A_DAY)
        case .quarter:
            let _om = (self.year * 12 + self.month) / 3
            let _tm = (anotherDay.year * 12 + anotherDay.month) / 3
            return _om - _tm
        }
        
        return _delta / Int(MILLISECONDS_A_SECOND)
    }
    
    public func diff(anotherDay : Day) -> Int {
        return diff(anotherDay: anotherDay, unit: .second)
    }
    
    // daysInMonth
    public func daysInMonth() -> Int {
        return self.endOf(unit: .month).date
    }
    
    // toDate
    public func toDate() -> Date {
        return Date.init(timeIntervalSince1970: self.innerDate.timeIntervalSince1970)
    }
    
    public func isBefore(anotherDay: Day) -> Bool {
        if self.innerDate > anotherDay.innerDate {
            return false
        } else {
            return true
        }
    }
    
    public func isSame(anotherDay: Day) -> Bool {
        if self.innerDate == anotherDay.innerDate {
            return true
        } else {
            return false
        }
    }
    
    public func isSame(anotherDay: Day, unit: DayUnit) -> Bool {
        let _year0 = self.year
        var _month0 = self.month
        var _date0 = self.date
        var _hour0 = self.hour
        var _minute0 = self.minute
        var _second0 = self.second
        var _millisecond0 = self.millisecond
        let _year1 = anotherDay.year
        var _month1 = anotherDay.month
        var _date1 = anotherDay.date
        var _hour1 = anotherDay.hour
        var _minute1 = anotherDay.minute
        var _second1 = anotherDay.second
        var _millisecond1 = anotherDay.millisecond
        
        switch unit {
        case .year:
            _month0 = 1
            _month1 = 1
            fallthrough
        case .month:
            _date0 = 1
            _date1 = 1
            fallthrough
        case .date:
            _hour0 = 0
            _hour1 = 0
            fallthrough
        case .hour:
            _minute0 = 0
            _minute1 = 0
            fallthrough
        case .minute:
            _second0 = 0
            _second1 = 0
            fallthrough
        case .second:
            _millisecond0 = 0
            _millisecond1 = 0
            fallthrough
        case .millisecond: break
        case .week: break
        case .quarter: break
        case .day: break
        }
        
        let _d0 = Day.init(year: _year0, month: _month0, day: _date0, hour: _hour0, minute: _minute0, second: _second0, millisecond: _millisecond0)
        let _d1 = Day.init(year: _year1, month: _month1, day: _date1, hour: _hour1, minute: _minute1, second: _second1, millisecond: _millisecond1)
        return _d0.isSame(anotherDay: _d1)
    }
    
    // is after
    public func isAfter(anotherDay: Day) -> Bool {
        return !isBefore(anotherDay: anotherDay)
    }
    
    // clone
    public func clone() -> Day {
        let _d = Day.init()
        _d.innerDate = self.innerDate
        _d.dateformatter = self.dateformatter
        return _d
    }
    
    // check if valid
    public func isValid() -> Bool {
        if (self.innerDate == nil) {
            return false
        }
        return true
    }
    
    // MARK: format
    
    public func format(format : String) -> String {
        dateformatter.dateFormat = format
        
        return dateformatter.string(from: self.innerDate)
    }
    
    // default format
    public func format() -> String {
        if self.isValid() {
            dateformatter.dateFormat = FORMAT_DEFAULT
            return dateformatter.string(from: self.innerDate)
        } else {
            return INVALID_DATE_STRING
        }
    }
    
    public func toJSON() -> String {
        if self.isValid() {
            let _df = DateFormatter()
            _df.dateFormat = FORMAT_ISO8601
            _df.timeZone = TimeZone.init(identifier: "UTC")
            return _df.string(from: self.innerDate)
        } else {
            return INVALID_DATE_STRING
        }
    }
    
    public func toISOString() -> String {
        return toJSON()
    }
    
    public func toString() -> String {
        return format(format: "EEE, dd MMM yyyy HH:mm:ss z")
    }
}

private extension String {
    func substring(_ start : Int, _ length : Int) -> String? {
        let start = self.index(self.startIndex, offsetBy: start)
        let end = self.index(start, offsetBy: length)
        return String(self[start..<end])
    }
}
