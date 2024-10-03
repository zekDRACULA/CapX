//
//  Model.swift
//  CapX
//
//  Created by Abhay singh on 03/10/24.
//

import Foundation



struct MonthlyPriceGraph: Identifiable {
    var id: UUID = UUID()
    var date: String
    var Close: Double
}

let MonthlyPriceGraphData: [MonthlyPriceGraph] = [
    MonthlyPriceGraph(date: "2024-09-03", Close: 409.44),
    MonthlyPriceGraph(date: "2024-09-04", Close: 408.89),
    MonthlyPriceGraph(date: "2024-09-05", Close: 408.39),
    MonthlyPriceGraph(date: "2024-09-06", Close: 401.70),
    MonthlyPriceGraph(date: "2024-09-09", Close: 405.72),
    MonthlyPriceGraph(date: "2024-09-10", Close: 414.20),
    MonthlyPriceGraph(date: "2024-09-11", Close: 423.04),
    MonthlyPriceGraph(date: "2024-09-12", Close: 427.00),
    MonthlyPriceGraph(date: "2024-09-13", Close: 430.58),
    MonthlyPriceGraph(date: "2024-09-16", Close: 431.33),
    MonthlyPriceGraph(date: "2024-09-17", Close: 435.14),
    MonthlyPriceGraph(date: "2024-09-18", Close: 430.80),
    MonthlyPriceGraph(date: "2024-09-19", Close: 438.69),
    MonthlyPriceGraph(date: "2024-09-20", Close: 435.26),
    MonthlyPriceGraph(date: "2024-09-23", Close: 433.51),
    MonthlyPriceGraph(date: "2024-09-24", Close: 429.17),
    MonthlyPriceGraph(date: "2024-09-25", Close: 432.10),
    MonthlyPriceGraph(date: "2024-09-26", Close: 431.30),
    MonthlyPriceGraph(date: "2024-09-27", Close: 428.01),
    MonthlyPriceGraph(date: "2024-09-30", Close: 430.29),
    MonthlyPriceGraph(date: "2024-10-01", Close: 420.69),
    MonthlyPriceGraph(date: "2024-10-02", Close: 417.13),
]

