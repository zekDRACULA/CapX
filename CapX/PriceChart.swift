//
//  PriceChart.swift
//  CapX
//
//  Created by Abhay singh on 03/10/24.
//
import SwiftUI
import Charts

struct PriceChart : View {
    var minClose = monthlyPriceGraphData.map{$0.Close}.min() ?? 400
    var maxClose = monthlyPriceGraphData.map{$0.Close}.max() ?? 450

    
    var body: some View {
        Chart{
            ForEach(monthlyPriceGraphData){ data in
                LineMark(x: .value("", data.index),
                         y: .value("", data.Close))
            }
        }
        .chartYScale(domain: (minClose - 10) ... (maxClose + 10))
        .foregroundStyle(Color.green)
        .chartXAxis {
                    AxisMarks { value in
                        // Extract the day value from AxisValue
                        if let dayValue = value.as(Double.self) {
                            // Format day based on the value
                            let dayString = String(format: "%.0f", dayValue)
                            AxisValueLabel(dayString)
                        }
                    }
                }
    }
}

#Preview {
    PriceChart()
}
