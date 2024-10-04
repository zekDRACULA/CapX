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
