//
//  DataManager.swift
//  CapX
//
//  Created by Abhay singh on 10/10/24.
//


import SwiftUI

final class MainViewModel : ObservableObject{
    static let shared = MainViewModel()
    
    @ObservedObject var view = StockInfoManager.shared
    @ObservedObject var history = stockHistoryManager.shared
    
    @Published var previousClose: Double = 0.0
    @Published var changePeriod : String = "This Month"
    @Published var selectedInterval: Int = 0
    
    @Published var showError : Bool = false
    @Published var ErrorMessage : String = ""
    
    @Published var isLoading : Bool = false
    
    func resetPrev(){
        previousClose = 0
    }
    
    var currPrice : Double{
        view.stockInfoData.currentPrice ?? 0
    }
    
    var percentageChangeString : String{
        String(format: "%.2f", (priceChange/previousClose)*100)
    }
    
    var currentPriceString : String{
        String(format: "%.2f", currPrice)
    }
    
    
    var currOpen : Double{
        history.stockHistoryData.last?.openDouble ?? 0
    }
    
    var currOpenString : String{
        String(format: "%.2f", currOpen)
    }
    
    var priceChange : Double{
        currPrice - previousClose
    }
    
    var priceChangeString : String{
        String(format: "%.2f", priceChange)
    }
    
    var isPositive : Bool{
        (currPrice - previousClose) >= 0 ? true : false
    }
    
    var highString : String{
        String(format: "%.2f", view.stockInfoData.dayHigh ?? 0)
    }
    
    var lowString : String{
        String(format: "%.2f", view.stockInfoData.dayLow ?? 0)
    }
    
    var fiftyTwoWeekHighString : String{
        String(format: "%.2f", view.stockInfoData.fiftyTwoWeekHigh ?? 0)
    }
    
    var fiftyTwoWeekLowString : String{
        String(format: "%.2f", view.stockInfoData.fiftyTwoWeekLow ?? 0)
    }
}
