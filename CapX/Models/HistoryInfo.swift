//
//  Model.swift
//  CapX
//
//  Created by Abhay singh on 04/10/24.
//

import Foundation

//MARK: Data coming from {{base_url}}/history
struct HistoryData : Codable{
    let records : [records]?
}

struct records : Codable, Identifiable{
    let index : String?
    let Open : String?
    let High : String?
    let Low : String?
    let Close : String?
    let range : String?
    
    var id : UUID{
        return UUID()
    }
    
    var openDouble : Double?{
        let open = Double(Open ?? "0")
        return open
    }
    
    var closeDouble : Double?{
        let close = Double(Close ?? "0")
        return close
    }
    
    var date : Date?{
       let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        return inputFormatter.date(from: index ?? "") ?? Date()
    }
    
    var day : String?{
        let outputFormatter = DateFormatter()
        if(range == "1y" || range == "5y"){
            outputFormatter.dateFormat = "yyyy-MM"
        }else{
            outputFormatter.dateFormat = "MM-dd"
        }
        
            return outputFormatter.string(from: date ?? Date())
    }
}








