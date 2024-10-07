//
//  Model.swift
//  CapX
//
//  Created by Abhay singh on 04/10/24.
//

import Foundation

//MARK: Data coming from {{base_url}}/history
struct HistoryData : Codable{
    let records : [records]?
}

struct records : Codable, Identifiable{
    let index : String?
    let Open : String?
    let High : String?
    let Low : String?
    let Close : String?
    let range : String?
    
    var id : UUID{
        return UUID()
    }
    
    var openDouble : Double?{
        let open = Double(Open ?? "0")
        return open
    }
    
    var closeDouble : Double?{
        let close = Double(Close ?? "0")
        return close
    }
    
    var date : Date?{
       let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        return inputFormatter.date(from: index ?? "") ?? Date()
    }
    
    var day : String?{
        let outputFormatter = DateFormatter()
        if(range == "1y" || range == "5y"){
            outputFormatter.dateFormat = "yyyy-MM"
        }else{
            outputFormatter.dateFormat = "MM-dd"
        }
        
            return outputFormatter.string(from: date ?? Date())
    }
}

//MARK: manager for stock history
class stockHistoryManager : ObservableObject{
    static let shared = stockHistoryManager()
    @Published var stockHistoryData : [records] = []
    func resetData(){
        stockHistoryData = []
    }
}

//MARK: Data coming from {{base_url}}/info
struct StockInfo : Codable{
    let previousClose : Double?
    let open : Double?
    let dayLow : Double?
    let dayHigh : Double?
    let fiftyTwoWeekLow : Double?
    let fiftyTwoWeekHigh : Double?
    let symbol : String?
    let longName : String?
    let currentPrice : Double?
}

//MARK: manager for stock Info
class stockInfoManager : ObservableObject{
    static let shared = stockInfoManager()
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

