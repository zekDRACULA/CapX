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
    @ObservedObject var history = stockHistoryManager.shared
    var body: some View {
        ScrollView{
            ZStack{
                VStack{
                    SearchBar(key: $key)
                    if (history.stockHistoryData.isEmpty){
                        notFound()
                    }else{
                        VStack{
                            GraphCard()
                            PriceCard(priceCard: priceCardData[0])
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

//MARK: Not Found
struct notFound : View {
    var body: some View {
        Text("Search Stock")
            .font(.title2)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding()
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct SearchBar : View {
    @Binding var key : String
    var body: some View {
        HStack{
            TextField("AAPL, MSFT Search", text: $key)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .padding(.leading)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.leading)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            SearchButton(key: $key)
                .padding(.trailing)
        }
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
                     stockInfoManager.shared.stockInfoData = infoData
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
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
    }
}

struct PriceCard : View {
    @ObservedObject var info = stockInfoManager.shared
    @ObservedObject var history = stockHistoryManager.shared
    var priceCard : PriceCardModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            HStack{
                Text("Open")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text("\(info.stockInfoData.open ?? 0)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("High")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text("\(info.stockInfoData.dayHigh ?? 0)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("Low")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text("\(info.stockInfoData.dayLow ?? 0)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("52 Week high")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text("\(info.stockInfoData.fiftyTwoWeekHigh ?? 0)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("52 Week Low")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text("\(info.stockInfoData.fiftyTwoWeekLow ?? 0)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct GraphCard : View {
    @ObservedObject var view = stockInfoManager.shared
    var body: some View {
        VStack(alignment: .leading ,spacing: 2){
            HStack(alignment: .top){
                //Stock Name
                VStack(alignment: .leading, spacing: 2){
                    Text("\(view.stockInfoData.symbol ?? "N/A")")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(view.stockInfoData.longName ?? "")")
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
            Spacer()
            PriceChart()
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
