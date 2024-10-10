//
//  PriceChartViewModel.swift
//  CapX
//
//  Created by Abhay singh on 10/10/24.
//

import Foundation
import SwiftUICore

class PriceChartViewModel : ObservableObject{
    static let shared = PriceChartViewModel()
    @ObservedObject var history = stockHistoryManager.shared
    @ObservedObject var view = StockInfoManager.shared
    
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
}
