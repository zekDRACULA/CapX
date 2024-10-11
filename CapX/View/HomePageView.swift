//
//  HomePage.swift
//  CapX
//
//  Created by Abhay singh on 03/10/24.
//


import SwiftUI

#Preview {
    HomePageView()
}

struct HomePageView: View {
    @State var key : String = ""
    @ObservedObject var history = stockHistoryManager.shared
    @ObservedObject var data = MainViewModel.shared
    var body: some View {
        ScrollView{
            ZStack{
                VStack(spacing: 12){
                    SearchBarView(key: $key)
                    if (data.isLoading){
                        VStack{
                            GraphCardView(key: $key)
                            PriceCardView()
                            Spacer()
                        }
                        .redacted(reason: .placeholder)
                        .modifier(Shimmer())
                    }
                    else if (key == "" || data.history.stockHistoryData.isEmpty){
                        NotFoundView()
    
                    }else{
                    VStack(spacing: 12){
                            GraphCardView(key: $key)
                            PriceCardView()
                            Spacer()
                        }
                    }
                }
            }
        }
        .alert(isPresented: $data.showError) {
            Alert(
                title: Text("Error"),
                message: Text(data.ErrorMessage),
                dismissButton: .cancel(Text("Dismiss")
                                       , action: {
                                           key = ""
                                           data.showError = false
                                       })
            )
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
                     StockInfoManager.shared.stockInfoData = infoData
                     //print("info data: \(infoData)")
                }catch{
                    MainViewModel.shared.showError = true
                    MainViewModel.shared.ErrorMessage = error.localizedDescription
                    //print("Error: \(error.localizedDescription)")
                }
                
                //MARK: getHistory()
                do {
                    MainViewModel.shared.resetPrev()
                    MainViewModel.shared.history.resetData()
                    let historyArray = try await getHistory(key: key.capitalized, duration: "1mo")
                    if let records = historyArray.records, let firstRecord = records.first{
                        stockHistoryManager.shared.stockHistoryData.append(contentsOf: records)
                        MainViewModel.shared.previousClose = firstRecord.closeDouble ?? 0
                        //print("data for records from search button: \(records.count)")
                    }else{
                        print("No records found for the typed symbol")
                        MainViewModel.shared.showError = true
                        MainViewModel.shared.ErrorMessage = "No records found in the fetched history data"
                    }
                }catch{
                    MainViewModel.shared.showError = true
                    MainViewModel.shared.ErrorMessage = error.localizedDescription
                    //print("Error: \(error.localizedDescription)")
                }
            }
        } label: {
            Text("Done")
                .foregroundStyle(Color("bgColor"))
                .padding()
                .frame(maxHeight: 50)
                .background(Color("shadowColor"))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(color: Color("shadowColor").opacity(0.2), radius: 4, x: 0, y: 2)
                .shadow(color: Color("shadowColor").opacity(0.1), radius: 10, x: 0, y: 5)
        }
    }
}








