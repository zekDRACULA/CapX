//
//  SegmentedControl.swift
//  CapX
//
//  Created by Abhay singh on 04/10/24.
//

import SwiftUI

struct SegmentedControl: View {
    @State private var selectedInterval = 0
    @State private var duration : String = "1mo"
    var key : String
    @ObservedObject var stock = DataManager.shared
    var body: some View {
        Picker("Interval", selection: $selectedInterval){
            Text("1M").tag(0)
            Text("6M").tag(1)
            Text("1Y").tag(2)
            Text("5Y").tag(3)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .onChange(of: selectedInterval) {
            switch selectedInterval{
            case 0:
                duration = "1mo"
                stock.changePeriod = "This Month"
            
            case 1:
                duration = "6mo"
                stock.changePeriod = "Past 6 Months"
            
            case 2: 
                duration = "1y"
                stock.changePeriod = "Past 1 year"
                
            case 3: 
                duration = "5y"
                stock.changePeriod = "Past 5 years"
            default:
                duration = "1mo"
                stock.changePeriod = "This Month"
            }
            
            Task{
                //MARK: getInfo()
                do{
                     let infoData = try await getInfo(key: key.capitalized)
                     stock.view.stockInfoData = infoData
                     print("info data: \(infoData)")
                }catch{
                    print("Error: \(error.localizedDescription)")
                }
                
                //MARK: getHistory()
                do{
                    DataManager.shared.resetPrev()
                    DataManager.shared.history.resetData()
                    let historyData = try await getHistory(key: key, duration: duration)
                    if let records = historyData.records, let firstRecord = records.first{
                        DataManager.shared.history.stockHistoryData.append(contentsOf: records)
                        DataManager.shared.previousClose = firstRecord.closeDouble ?? 0
                        print("fetched Sucessfully in segmented Control:\(records)")
                    }else{
                        print("No recoeds found during segmented control change")
                    }
                }catch{
                    stock.showError = true
                    stock.ErrorMessage = error.localizedDescription
                    print("Error fetching history Data: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    SegmentedControl(key: "1mo")
}
