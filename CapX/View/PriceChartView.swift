//
//  PriceChart.swift
//  CapX
//
//  Created by Abhay singh on 03/10/24.
//
import SwiftUI
import Charts



struct PriceChartView : View {
    @ObservedObject var price = PriceChartViewModel.shared
    var key : String
   
    
    
    var body: some View {
        
        Chart {
            ForEach(price.history.stockHistoryData) { data in
                let xValue = data.index ?? ""
                let yValue = data.closeDouble ?? 0
                LineMark(x: .value("", xValue),
                         y: .value("", yValue))
                .foregroundStyle((price.priceChange > 0) ? Color.green : Color.red)
                .shadow(color: (price.priceChange > 0) ? Color.green : Color.red, radius: 10, x: 10, y: 10)
            }
        }
        .chartYScale(domain: (price.minClose - 10) ... (price.maxClose + 10))
        .chartXAxis {
            if let firstIndex = stockHistoryManager.shared.stockHistoryData.first?.index,
               let lastIndex = stockHistoryManager.shared.stockHistoryData.last?.index {
                AxisMarks(values: [firstIndex, lastIndex]) { value in
                    if value.as(String.self) == firstIndex {
                        AxisValueLabel {
                            Text(price.lastDate)
                                .padding(.leading)
                                .foregroundStyle(Color("bgColor"))
                                .frame(width: 250)
                        }
                    } else if value.as(String.self) == lastIndex {
                        AxisValueLabel {
                            Text(price.currDate)
                                .padding(.horizontal)
                                .foregroundStyle(Color("bgColor"))
                                .frame(width: 200)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        SegmentedControlView(key: key)
    }
}

#Preview {
    PriceChartView(key: "1mo")
}
