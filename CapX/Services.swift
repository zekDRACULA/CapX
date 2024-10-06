//
//  Services.swift
//  CapX
//
//  Created by Abhay singh on 05/10/24.
//

import Foundation

func getInfo(key : String) async throws -> StockInfo{
    
    let apiKey : String = "48fe470d4cmsh65b83cc32be84eep1634a2jsn0c8aa1ba5842"
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
    
    let(data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else{
        print("failed to cast response to HTTPURLResponse")
        throw URLError(.badServerResponse)
    }
    
    guard (httpResponse.statusCode == 200) else{
        print("Invalid status code: \(httpResponse.statusCode)")
        throw URLError(.badServerResponse)
    }
    
    if let jsonData = String(data: data, encoding: .utf8){
       // print("jsonData: \(jsonData)")
        print("Sucess")
    }else{
        print("failed to Convert json Data")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(StockInfo.self, from: data)
    }catch{
        print("failed to decode data getInfo : \(error.localizedDescription)")
        throw URLError(.cannotDecodeContentData)
    }
}

func getHistory(key: String, duration: String) async throws -> HistoryData{
    let apiKey : String = "09d4cc6643msh2b9aeddfdda704bp1928f3jsn3b6536c61a0c"
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
    
    let(data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else{
        print("failed to cast response to HTTPURLResponse")
        throw URLError(.badServerResponse)
    }
    
    guard(httpResponse.statusCode == 200) else{
        print("Invalid status code: \(httpResponse.statusCode)")
        throw URLError(.badServerResponse)
    }
    
    if let jsonData = String(data: data, encoding: .utf8){
        print("jsonData: sucess")
    }else{
        print("failed to convert json Data")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(HistoryData.self, from: data)
    }catch{
        print("failed to decode data in history: \(error.localizedDescription)")
        throw URLError(.cannotDecodeContentData)
    }
}
