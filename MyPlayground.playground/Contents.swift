import Foundation

let calendar = Calendar.current

let date: Date = .now
let oneDayAgo = calendar.date(byAdding: .day, value: -1, to: .now)!

date.formatted(Date.FormatStyle().weekday(.wide))
oneDayAgo.formatted(Date.FormatStyle().weekday(.wide))

// ----------------------------
