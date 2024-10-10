//
//  StockInfo.swift
//  CapX
//
//  Created by Abhay singh on 10/10/24.
//


import Foundation

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



