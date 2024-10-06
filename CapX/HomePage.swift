//
//  HomePage.swift
//  CapX
//
//  Created by Abhay singh on 03/10/24.
//

import SwiftUI

#Preview {
    HomePage()
}

struct HomePage: View {
    
    @State var key : String = ""
    
    var body: some View {
        ScrollView{
            ZStack{
                    VStack{
                        HStack(spacing: 4){
                            SearchBar(key: $key)
                            SearchButton(key: $key)
                                .padding(.trailing)
                        }.padding(.top)
                        GraphCard()
                        PriceCard(priceCard: priceCardData[0])
                        Spacer()
                    }
                }
        }
    }
}

struct SearchBar : View {
    @Binding var key : String
    var body: some View {
        TextField("AAPL, MSFT Search", text: $key)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            //.background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.black, lineWidth: 2)
            )
            .padding(.leading)
    }
}

struct SearchButton : View {
    @Binding var key : String
    var body: some View {
        Button {
            Task{
                //MARK: getInfo()
                do{
                     let infoData = try await getInfo(key: key.capitalized)
                     stockInfoManager.shared.stockInfoData.append(infoData)
                     print("info data: \(infoData)")
                }catch{
                    print("Error: \(error.localizedDescription)")
                }
                
                //MARK: getHistory()
                do{
                    let historyArray = try await getHistory(key: key.capitalized, duration: "1mo")
                    if let records = historyArray.records{
                        stockHistoryManager.shared.stockHistoryData.append(contentsOf: records)
                        print(stockHistoryManager.shared.stockHistoryData.count)
                    }else{
                        print("No records found in the fetched history data")
                    }
                }catch{
                    print("Error: \(error.localizedDescription)")
                }
            }
        } label: {
            Text("Done")
                .padding()
                .foregroundStyle(Color.white)
                .frame(maxHeight: 50)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

struct PriceCard : View {
    var priceCard : PriceCardModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            HStack{
                Text("Open")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text(priceCard.open)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("High")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text(priceCard.dayHigh)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("Low")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text(priceCard.dayLow)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("52 Week high")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text(priceCard.fiftyTwoWeekHigh)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("52 Week Low")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text(priceCard.fiftyTwoWeekLow)
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.black, lineWidth: 2)
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
                    
                    Text("+0.57 (1.35%)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.green)
                }
            }
            PriceChart()
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.black, lineWidth: 2)
        )
        .padding(.horizontal)
    }
}
