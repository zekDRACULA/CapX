//
//  PriceChart.swift
//  CapX
//
//  Created by Abhay singh on 03/10/24.
//
import SwiftUI
import Charts

struct PriceChart : View {
    var minClose = MonthlyPriceGraphData.map{$0.Close}.min() ?? 400
    var maxClose = MonthlyPriceGraphData.map{$0.Close}.max() ?? 450
    var body: some View {
        Chart{
            ForEach(MonthlyPriceGraphData){ data in
                LineMark(x: .value("", data.date),
                         y: .value("", data.Close))
            }
        }
        .chartYScale(domain: (minClose - 10) ... (maxClose + 10))
        .foregroundStyle(Color.green)
    }
}

#Preview {
    PriceChart()
}
