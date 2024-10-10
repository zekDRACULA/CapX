//
//  SearchBarView.swift
//  CapX
//
//  Created by Abhay singh on 10/10/24.
//

import SwiftUI

struct SearchBarView : View {
    @Binding var key : String
    var body: some View {
        HStack{
            TextField("AAPL, MSFT Search", text: $key)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .padding(.leading)
                .background(Color("bgColor"))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.leading)
                .shadow(color: Color("shadowColor").opacity(0.2), radius: 4, x: 0, y: 2)
                .shadow(color: Color("shadowColor").opacity(0.1), radius: 10, x: 0, y: 5)
            SearchButton(key: $key)
                .padding(.trailing)
        }
        }
}

