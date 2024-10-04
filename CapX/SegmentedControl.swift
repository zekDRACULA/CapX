//
//  SegmentedControl.swift
//  CapX
//
//  Created by Abhay singh on 04/10/24.
//

import SwiftUI

struct SegmentedControl: View {
    @State private var selectedInterval = 0
    var body: some View {
        Picker("Interval", selection: $selectedInterval){
            Text("1M").tag(0)
            Text("6M").tag(1)
            Text("1Y").tag(2)
            Text("5Y").tag(3)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

#Preview {
    SegmentedControl()
}
