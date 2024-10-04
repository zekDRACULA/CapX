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

    var lastDate = monthlyPriceGraphData.first?.day ?? ""
    var currDate = monthlyPriceGraphData.last?.day ?? ""
    
    var body: some View {
        Chart{
            ForEach(monthlyPriceGraphData){ data in
                let xValue = data.index
                let yValue = data.Close
                LineMark(x: .value("", xValue),
                         y: .value("", yValue))
                .foregroundStyle(Color.green)
            }
        }
        .chartYScale(domain: (minClose - 10) ... (maxClose + 10))
        .chartXAxis{
            if let firstIndex = monthlyPriceGraphData.first?.index,
               let lastIndex = monthlyPriceGraphData.last?.index{
                AxisMarks(values: [firstIndex, lastIndex]){ value in
                    if value.as(String.self) == firstIndex{
                        AxisValueLabel{
                            Text(lastDate)
                                .frame(width: 100)
                            }
                    }else if value.as(String.self) == lastIndex{
                        AxisValueLabel{
                            Text(currDate)
                                .frame(width: 100)
                        }
                    }
                }
            }
        }
       
        .padding()
        
    }
}

#Preview {
    PriceChart()
}
