import Foundation
import SwiftUI
import Charts
import PlaygroundSupport

struct ChartDataPoint {
    var id: UUID = UUID()
    var date: Date
    var value: Double
}

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "MM/dd/yyyy"
dateFormatter.string(from: .now)
let point1 = ChartDataPoint(date: Date.from(month: 4, day: 16, year: 2025), value: 200)
let point2 = ChartDataPoint(date: Date.from(month: 4, day: 17, year: 2025), value: 300)


struct MyChart: View {
    var body: some View {
        ScrollView {
            
            Chart {
                BarMark(x: .value("Date", point1.date), y: .value("Value", point1.value))
                //BarMark(x: .value("Date", point2.date), y: .value("Value", point2.value))
                
            }
//            .chartXAxis(content: {
//                AxisMarks(values: .stride(by: .day)) { value in
//                    AxisValueLabel(format: .dateTime.day())
//                }
//            })
//            .chartXAxis {
//                AxisMarks(values: ["S", "M", "T", "W", "T", "F", "S"]) {
//                AxisGridLine()
//            }
//            }
                
            .padding(.top, 50)
            .padding(.horizontal)
        }
        .frame(width: 500,height: 400,alignment: .center)
       
        
        
        
    }
}

PlaygroundPage.current.setLiveView(MyChart())
