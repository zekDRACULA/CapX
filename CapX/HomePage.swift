//
//  HomePage.swift
//  CapX
//
//  Created by Abhay singh on 03/10/24.
//

import SwiftUI

struct HomePage: View {
    @State var key : String = ""
    var body: some View {
        SearchBar(key: $key)
        Spacer()
    }
}

struct SearchBar : View {
    @Binding var key : String
    var body: some View {
        TextField("Search... AAPL, MSFT", text: $key)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            //.background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .padding(.horizontal)
    }
}

struct GraphCard : View {
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 2){
            HStack(alignment: .top){
                //Stock Name
                VStack(alignment: .leading, spacing: 2){
                    Text("AAPL")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Apple Inc.")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                
                Spacer()
                //Stock Price
                VStack(alignment: .leading, spacing: 2){
                    Text("226.78")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("+0.57")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.green)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.black, lineWidth: 2)
        )
        .padding()
    }
}

#Preview {
    GraphCard()
}
