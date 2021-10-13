参考 day.js 设计，使用如下：

###初始化
```swift
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
```

### 属性
```swift
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
```

### 常用方法
```swift
let d1 = Day.init(string: "2021-10-13 13:31:57", format: "yyyy-MM-dd HH:mm:ss") // 1634103117
let d2 = Day.init(string: "2021-10-13 13:32:57", format: "yyyy-MM-dd HH:mm:ss")
let d3 = Day.init()

let mind = Day.min(days: d1, d2, d3)
XCTAssert(mind.isSame(anotherDay: d1))

let maxd = Day.max(days: d1, d2, d3)
XCTAssert(maxd.isSame(anotherDay: d3))

XCTAssert(d1.isBefore(anotherDay: d2))
XCTAssert(d2.isAfter(anotherDay: d1))
XCTAssert(d1.isSame(anotherDay: d2, unit: .year))
XCTAssert(d1.isSame(anotherDay: d2, unit: .month))
XCTAssert(d1.isSame(anotherDay: d2, unit: .day))
XCTAssert(d1.isSame(anotherDay: d2, unit: .date) == false) // 这个没有比较
XCTAssert(d1.isSame(anotherDay: d2, unit: .hour))
XCTAssert(d1.isSame(anotherDay: d2, unit: .minute) == false)
XCTAssert(d1.isSame(anotherDay: d2, unit: .second) == false)
XCTAssert(d1.isSame(anotherDay: d2, unit: .millisecond) == false)

let d = Day.init(string: "2021-10-10 10:10:10")
var dd = d.add(delta: 1, unit: .year)
XCTAssert(dd.year == 2022)
dd = d.add(delta: 1, unit: .month)
XCTAssert(dd.month == 11)
dd = d.add(delta: 1, unit: .day)
XCTAssert(dd.day == 11)
dd = d.add(delta: 1, unit: .hour)
XCTAssert(dd.hour == 11)
dd = d.add(delta: 1, unit: .minute)
XCTAssert(dd.minute == 11)
dd = d.add(delta: 1, unit: .second)
XCTAssert(dd.second == 11)
dd = d.add(delta: 180, unit: .second)
XCTAssert(dd.minute == 13)
XCTAssert(dd.second == 10)
dd = d.subtract(delta: 180, unit: .second)
XCTAssert(dd.minute == 7)
XCTAssert(dd.second == 10)

XCTAssert(d1.valueOf() == 1634103117000)
XCTAssert(d1.unix() == 1634103117)
XCTAssert(d1.clone().isSame(anotherDay: d1))
XCTAssert(d.startOf(unit: .year).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-01-01 00:00:00")
XCTAssert(d.startOf(unit: .month).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-01 00:00:00")
XCTAssert(d.startOf(unit: .day).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-10 00:00:00")
XCTAssert(d.startOf(unit: .hour).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-10 10:00:00")
XCTAssert(d.startOf(unit: .minute).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-10 10:10:00")
XCTAssert(d.startOf(unit: .second).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-10 10:10:10")

XCTAssert(d.endOf(unit: .year).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-12-31 23:59:59")
XCTAssert(d.endOf(unit: .month).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-31 23:59:59")
XCTAssert(d.endOf(unit: .day).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-10 23:59:59")
XCTAssert(d.endOf(unit: .hour).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-10 10:59:59")
XCTAssert(d.endOf(unit: .minute).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-10 10:10:59")
XCTAssert(d.endOf(unit: .second).format(format: "yyyy-MM-dd HH:mm:ss") == "2021-10-10 10:10:10")

XCTAssert(d1.diff(anotherDay: d2) == -60)
XCTAssert(d1.diff(anotherDay: d2, unit: .year) == 0)
XCTAssert(d1.diff(anotherDay: d2, unit: .month) == 0)
XCTAssert(d1.diff(anotherDay: d2, unit: .day) == 0)
XCTAssert(d1.diff(anotherDay: d2, unit: .hour) == 0)
XCTAssert(d1.diff(anotherDay: d2, unit: .minute) == -1)
XCTAssert(d1.diff(anotherDay: d2, unit: .second) == -60)

XCTAssert(d.toJSON() == "2021-10-10T02:10:10.000Z")
XCTAssert(d.toString() == "Sun, 10 Oct 2021 10:10:10 GMT+8")
XCTAssert(d.toISOString() == "2021-10-10T02:10:10.000Z")
XCTAssert(d.daysInMonth() == 31)
```