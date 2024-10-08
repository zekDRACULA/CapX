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
                            GraphCard(key: $key)
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
                do {
                    DataManager.shared.resetPrev()
                    DataManager.shared.history.resetData()
                    let historyArray = try await getHistory(key: key.capitalized, duration: "1mo")
                    if let records = historyArray.records, let firstRecord = records.first{
                        stockHistoryManager.shared.stockHistoryData.append(contentsOf: records)
                        DataManager.shared.previousClose = firstRecord.closeDouble ?? 0
                        print("data for records from search button: \(records.count)")
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
    @ObservedObject var stock = DataManager.shared
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
                Text(stock.currOpenString)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("High")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text(stock.highString)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("Low")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text(stock.lowString)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("52 Week high")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text(stock.fiftyTwoWeekHighString)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            HStack{
                Text("52 Week Low")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text(stock.fiftyTwoWeekLowString)
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

class DataManager : ObservableObject{
    static let shared = DataManager()
    
    @ObservedObject var view = stockInfoManager.shared
    @ObservedObject var history = stockHistoryManager.shared
    
    @Published var previousClose: Double = 0.0
    @Published var changePeriod : String = "This Month"
    
    func resetPrev(){
        previousClose = 0
    }
    
    var currPrice : Double{
        view.stockInfoData.currentPrice ?? 0
    }
    
    var currentPriceString : String{
        String(format: "%.2f", currPrice)
    }
    
    
    var currOpen : Double{
        history.stockHistoryData.last?.openDouble ?? 0
    }
    
    var currOpenString : String{
        String(format: "%.2f", currOpen)
    }
    
    var priceChange : Double{
        currPrice - previousClose
    }
    
    var priceChangeString : String{
        String(format: "%.2f", priceChange)
    }
    
    var isPositive : Bool{
        (currPrice - previousClose) >= 0 ? true : false
    }
    
    var highString : String{
        String(format: "%.2f", view.stockInfoData.dayHigh ?? 0)
    }
    
    var lowString : String{
        String(format: "%.2f", view.stockInfoData.dayLow ?? 0)
    }
    
    var fiftyTwoWeekHighString : String{
        String(format: "%.2f", view.stockInfoData.fiftyTwoWeekHigh ?? 0)
    }
    
    var fiftyTwoWeekLowString : String{
        String(format: "%.2f", view.stockInfoData.fiftyTwoWeekLow ?? 0)
    }
}



struct GraphCard : View {
 
    @ObservedObject var stock = DataManager.shared
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
                        
                        Text("\(stock.isPositive ? "+" : "-")" + stock.priceChangeString)
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
            PriceChart(key: key)
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
