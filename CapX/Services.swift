//
//  Services.swift
//  CapX
//
//  Created by Abhay singh on 05/10/24.
//

import Foundation


//MARK: getInfo Method
func getInfo(key : String) async throws -> StockInfo{
    
    let apiKey : String = "54f5255021msh6fb7888140bff8cp1fd844jsn276233b4de19"
    //let apiKey : String = ""
    let endpoint : String = "yahoo-finance160.p.rapidapi.com"
    
    guard let url = URL(string: "https://yahoo-finance160.p.rapidapi.com/info")else{
        print("Invalid Url")
        throw URLError(.badURL)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
    request.setValue(endpoint, forHTTPHeaderField: "x-rapidapi-host")
    
    
    let body = ["stock" : key]
    
    request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
    
    await MainActor.run{
        MainViewModel.shared.isLoading = true
    }
    
    defer{
        Task{
            await MainActor.run{
                MainViewModel.shared.isLoading = false
            }
        }
    }
    
    let(data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else{
        print("failed to cast response to HTTPURLResponse")
        throw URLError(.badServerResponse)
    }
    
    guard (httpResponse.statusCode == 200) else{
        print("Invalid status code: \(httpResponse.statusCode)")
        throw URLError(.badServerResponse)
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(StockInfo.self, from: data)
    }catch{
        print("failed to decode data getInfo : \(error.localizedDescription)")
        await MainActor.run{
            MainViewModel.shared.showError = true
            MainViewModel.shared.ErrorMessage = error.localizedDescription
        }
        throw URLError(.cannotDecodeContentData)
    }
}


//MARK: getHistory Method
func getHistory(key: String, duration: String) async throws -> HistoryData{
    let apiKey : String = "54f5255021msh6fb7888140bff8cp1fd844jsn276233b4de19"
   //let apiKey = ""
    let endPoint : String = "yahoo-finance160.p.rapidapi.com"
    
    
    
    guard let url = URL(string: "https://yahoo-finance160.p.rapidapi.com/history") else{
        print("Invalid Url")
        throw URLError(.badURL)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
    request.setValue(endPoint, forHTTPHeaderField: "x-rapidapi-host")
    
    let body = ["stock" : key, "period": duration]
    
    request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
    
    await MainActor.run{
        MainViewModel.shared.isLoading = true
    }
    
    defer{
        Task{
            await MainActor.run{
                MainViewModel.shared.isLoading = false
            }
        }
    }
    
    let(data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else{
        print("failed to cast response to HTTPURLResponse")
        throw URLError(.badServerResponse)
    }
    
    guard(httpResponse.statusCode == 200) else{
        print("Invalid status code: \(httpResponse.statusCode)")
        throw URLError(.badServerResponse)
    }
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(HistoryData.self, from: data)
    }catch{
        print("failed to decode data in history: \(error.localizedDescription)")
        await MainActor.run{
            MainViewModel.shared.showError = true
            MainViewModel.shared.ErrorMessage = error.localizedDescription
        }
        throw URLError(.cannotDecodeContentData)
    }
}
