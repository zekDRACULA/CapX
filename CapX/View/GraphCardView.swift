//
//  GraphCardView.swift
//  CapX
//
//  Created by Abhay singh on 10/10/24.
//


import SwiftUI

struct GraphCardView : View {
 
    @ObservedObject var stock = MainViewModel.shared
    @Binding var key : String
    var body: some View {
        VStack(alignment: .leading ,spacing: 2){
            HStack(alignment: .top){
                //Stock Name
                VStack(alignment: .leading, spacing: 2){
                    Text("\(stock.view.stockInfoData.symbol ?? "N/A")")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(stock.view.stockInfoData.longName ?? "")")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                
                Spacer()
                //Stock Price
                VStack(alignment: .center, spacing: 1){
                        Text(stock.currentPriceString)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        Text("\(stock.isPositive ? "+" : "")" + stock.priceChangeString)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(stock.isPositive ? Color.green : Color.red)
                    
                    Text("\(stock.changePeriod)")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.gray)
                }
            }
            Spacer()
            PriceChartView(key: key)
            Spacer()
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
