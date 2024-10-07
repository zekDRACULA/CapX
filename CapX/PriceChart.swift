//
//  PriceChart.swift
//  CapX
//
//  Created by Abhay singh on 03/10/24.
//
import SwiftUI
import Charts

struct PriceChart : View {
    @ObservedObject var history = stockHistoryManager.shared
    @ObservedObject var view = stockInfoManager.shared
    var key : String
    var previousClose : Double{
        history.stockHistoryData.first?.closeDouble ?? 0
    }
    var currOpen : Double{
        history.stockHistoryData.last?.openDouble ?? 0
    }
    
    var priceChange : Double{
        currOpen - previousClose
    }
    var minClose: Double {
        stockHistoryManager.shared.stockHistoryData.map { $0.closeDouble ?? 400 }.min() ?? 400
    }
    
    var maxClose: Double {
        stockHistoryManager.shared.stockHistoryData.map { $0.closeDouble ?? 450 }.max() ?? 450
    }

    var lastDate: String {
        stockHistoryManager.shared.stockHistoryData.first?.day ?? ""
    }
    
    var currDate: String {
        stockHistoryManager.shared.stockHistoryData.last?.day ?? ""
    }
    
    
    var body: some View {
        
        Chart {
            ForEach(history.stockHistoryData) { data in
                let xValue = data.index ?? ""
                let yValue = data.closeDouble ?? 0
                LineMark(x: .value("", xValue),
                         y: .value("", yValue))
                .foregroundStyle((priceChange > 0) ? Color.green : Color.red)
                .shadow(color: (priceChange > 0) ? Color.green : Color.red, radius: 10, x: 10, y: 10)
            }
        }
        .chartYScale(domain: (minClose - 10) ... (maxClose + 10))
        .chartXAxis {
            if let firstIndex = stockHistoryManager.shared.stockHistoryData.first?.index,
               let lastIndex = stockHistoryManager.shared.stockHistoryData.last?.index {
                AxisMarks(values: [firstIndex, lastIndex]) { value in
                    if value.as(String.self) == firstIndex {
                        AxisValueLabel {
                            Text(lastDate)
                                .padding(.leading)
                                .foregroundStyle(Color.black)
                                .frame(width: 250)
                        }
                    } else if value.as(String.self) == lastIndex {
                        AxisValueLabel {
                            Text(currDate)
                                .padding(.horizontal)
                                .foregroundStyle(Color.black)
                                .frame(width: 200)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        SegmentedControl(key: key)
    }
}

#Preview {
    PriceChart(key: "1mo")
}
