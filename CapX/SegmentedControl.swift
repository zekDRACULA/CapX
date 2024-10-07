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
            case 0: duration = "1mo"
            case 1: duration = "6mo"
            case 2: duration = "1y"
            case 3: duration = "5y"
            default: duration = "1mo"
            }
            
            Task{
                do{
//                    DataManager.shared.history.resetData()
                    let historyData = try await getHistory(key: key, duration: duration)
                    print(historyData)
                }catch{
                    print("Error fetching history Data: \(error)")
                }
            }
        }
    }
}

#Preview {
    SegmentedControl(key: "1mo")
}
