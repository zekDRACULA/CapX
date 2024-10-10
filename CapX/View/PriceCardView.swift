//
//  PriceCardView.swift
//  CapX
//
//  Created by Abhay singh on 10/10/24.
//


import SwiftUI

struct PriceCardView : View {
    @ObservedObject var stock = MainViewModel.shared
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            HStack{
                Text("Open")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text(stock.currOpenString)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            HStack{
                Text("High")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text(stock.highString)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            HStack{
                Text("Low")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text(stock.lowString)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            HStack{
                Text("52 Week high")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text(stock.fiftyTwoWeekHighString)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            HStack{
                Text("52 Week Low")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text(stock.fiftyTwoWeekLowString)
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color("bgColor"))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
        .shadow(color: Color("shadowColor").opacity(0.2), radius: 4, x: 0, y: 2)
        .shadow(color: Color("shadowColor").opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
#Preview{
    PriceCardView()
}
