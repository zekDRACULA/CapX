//
//  stockHistoryManager.swift
//  CapX
//
//  Created by Abhay singh on 10/10/24.
//


import Foundation

//MARK: manager for stock history
class stockHistoryManager : ObservableObject{
    static let shared = stockHistoryManager()
    @Published var stockHistoryData : [records] = []
    func resetData(){
        stockHistoryData.removeAll()
    }
}
