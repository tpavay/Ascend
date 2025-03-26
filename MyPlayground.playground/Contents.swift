import Foundation

var date = Date.now

print(date)

// Create an instance of the system calendar
let calendar = Calendar.current
let components = DateComponents(calendar: calendar, hour: 9, minute: 30)
var date2 = calendar.date(from: components)
print(date2)

let date3 = Date.now.formatted(.dateTime.hour().minute())
print(date3)
