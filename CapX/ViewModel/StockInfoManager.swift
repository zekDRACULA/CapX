//
//  StockInfoManager.swift
//  CapX
//
//  Created by Abhay singh on 10/10/24.
//


import Foundation

//MARK: manager for stock Info
class StockInfoManager : ObservableObject{
    static let shared = StockInfoManager()
    @Published var stockInfoData : StockInfo
    private init() {
        stockInfoData = StockInfo(previousClose: 0.0,
                                  open: 0.0,
                                  dayLow: 0.0,
                                  dayHigh: 0.0,
                                  fiftyTwoWeekLow: 0.0,
                                  fiftyTwoWeekHigh: 0.0,
                                  symbol: "",
                                  longName: "",
                                  currentPrice: 0.0)
    }
}
