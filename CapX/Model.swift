//
//  Model.swift
//  CapX
//
//  Created by Abhay singh on 04/10/24.
//

import Foundation

//MARK: Data coming from {{base_url}}/history
struct MonthlyData : Codable{
   let records : [records]?
}

struct records : Codable{
    let index : String?
    let Close : String?
    
    var date: Date?{
       let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        return inputFormatter.date(from: index ?? "") ?? Date()
    }
    
    var day : String?{
        let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MM-dd"
            return outputFormatter.string(from: date ?? Date())
    }
}

//MARK: Data coming from {{base_url}}/info
struct BasicData : Codable{
    let symbol : String?
    let longName : String?
    let previousClose : String?
    let currentPrice : String?
    let open : String?
    let dayLow : String?
    let dayHigh : String?
    let fiftyTwoWeekHigh : String?
    let fiftyTwoWeekLow : String?
}
