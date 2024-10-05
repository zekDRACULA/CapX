//
//  Model.swift
//  CapX
//
//  Created by Abhay singh on 03/10/24.
//

import Foundation

//MARK: data to be taken from {baseUrl}/info
struct PriceCardModel: Identifiable{
    var id : UUID = UUID()
    var open : String
    var dayHigh : String
    var dayLow : String
    var fiftyTwoWeekHigh : String
    var fiftyTwoWeekLow : String
}

let priceCardData: [PriceCardModel] = [
    PriceCardModel(open: "225.89", dayHigh: "227.37", dayLow: "223.03", fiftyTwoWeekHigh: "237.23", fiftyTwoWeekLow: "164.08")
]

//MARK: data model for Monthly data
struct MonthlyPriceModel: Identifiable {
    var id: UUID = UUID()
    var index: String
    var Close: Double
   // var result : [MonthResult]
   
    var date: Date{
       let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        return inputFormatter.date(from: index) ?? Date()
    }
    
    var day : String{
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        return outputFormatter.string(from: date)
    }
}

//MARK: Month Result
struct MonthResult : Identifiable{
    var id: UUID = UUID()
    
}




let monthlyPriceGraphData: [MonthlyPriceModel] = [
    MonthlyPriceModel(index: "2024-09-03 00:00:00-04:00", Close: 409.44),
    MonthlyPriceModel(index: "2024-09-04 00:00:00-04:00", Close: 408.89),
    MonthlyPriceModel(index: "2024-09-05 00:00:00-04:00", Close: 408.39),
    MonthlyPriceModel(index: "2024-09-06 00:00:00-04:00", Close: 401.70),
    MonthlyPriceModel(index: "2024-09-09 00:00:00-04:00", Close: 405.72),
    MonthlyPriceModel(index: "2024-09-10 00:00:00-04:00", Close: 414.20),
    MonthlyPriceModel(index: "2024-09-11 00:00:00-04:00", Close: 423.04),
    MonthlyPriceModel(index: "2024-09-12 00:00:00-04:00", Close: 427.00),
    MonthlyPriceModel(index: "2024-09-13 00:00:00-04:00", Close: 430.58),
    MonthlyPriceModel(index: "2024-09-16 00:00:00-04:00", Close: 431.33),
    MonthlyPriceModel(index: "2024-09-17 00:00:00-04:00", Close: 435.14),
    MonthlyPriceModel(index: "2024-09-18 00:00:00-04:00", Close: 430.80),
    MonthlyPriceModel(index: "2024-09-19 00:00:00-04:00", Close: 438.69),
    MonthlyPriceModel(index: "2024-09-20 00:00:00-04:00", Close: 435.26),
    MonthlyPriceModel(index: "2024-09-23 00:00:00-04:00", Close: 433.51),
    MonthlyPriceModel(index: "2024-09-24 00:00:00-04:00", Close: 429.17),
    MonthlyPriceModel(index: "2024-09-25 00:00:00-04:00", Close: 432.10),
    MonthlyPriceModel(index: "2024-09-26 00:00:00-04:00", Close: 431.30),
    MonthlyPriceModel(index: "2024-09-27 00:00:00-04:00", Close: 428.01),
    MonthlyPriceModel(index: "2024-09-30 00:00:00-04:00", Close: 430.29),
    MonthlyPriceModel(index: "2024-10-01 00:00:00-04:00", Close: 420.69),
    MonthlyPriceModel(index: "2024-10-02 00:00:00-04:00", Close: 417.13),
]

