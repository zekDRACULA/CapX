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

struct MonthlyPriceModel: Identifiable {
    var id: UUID = UUID()
    var index: String
    var Close: Double
    var date: Date{
       let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        return inputFormatter.date(from: index) ?? Date()
    }
    
    var day : String{
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd"
        return outputFormatter.string(from: date) 
    }
}

let monthlyPriceGraphData: [MonthlyPriceModel] = [
    MonthlyPriceModel(index: "2024-09-03", Close: 409.44),
    MonthlyPriceModel(index: "2024-09-04", Close: 408.89),
    MonthlyPriceModel(index: "2024-09-05", Close: 408.39),
    MonthlyPriceModel(index: "2024-09-06", Close: 401.70),
    MonthlyPriceModel(index: "2024-09-09", Close: 405.72),
    MonthlyPriceModel(index: "2024-09-10", Close: 414.20),
    MonthlyPriceModel(index: "2024-09-11", Close: 423.04),
    MonthlyPriceModel(index: "2024-09-12", Close: 427.00),
    MonthlyPriceModel(index: "2024-09-13", Close: 430.58),
    MonthlyPriceModel(index: "2024-09-16", Close: 431.33),
    MonthlyPriceModel(index: "2024-09-17", Close: 435.14),
    MonthlyPriceModel(index: "2024-09-18", Close: 430.80),
    MonthlyPriceModel(index: "2024-09-19", Close: 438.69),
    MonthlyPriceModel(index: "2024-09-20", Close: 435.26),
    MonthlyPriceModel(index: "2024-09-23", Close: 433.51),
    MonthlyPriceModel(index: "2024-09-24", Close: 429.17),
    MonthlyPriceModel(index: "2024-09-25", Close: 432.10),
    MonthlyPriceModel(index: "2024-09-26", Close: 431.30),
    MonthlyPriceModel(index: "2024-09-27", Close: 428.01),
    MonthlyPriceModel(index: "2024-09-30", Close: 430.29),
    MonthlyPriceModel(index: "2024-10-01", Close: 420.69),
    MonthlyPriceModel(index: "2024-10-02", Close: 417.13),
]

