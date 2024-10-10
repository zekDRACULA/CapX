//
//  NotFoundView.swift
//  CapX
//
//  Created by Abhay singh on 10/10/24.
//

import SwiftUI

//MARK: Not Found
struct NotFoundView : View {
    var text : String = " Search Stock"
    var body: some View {
        Text("Search Stock")
            .font(.title2)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .background(Color("bgColor"))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding()
            .shadow(color: Color("shadowColor").opacity(0.2), radius: 4, x: 0, y: 2)
            .shadow(color: Color("shadowColor").opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    NotFoundView()
}
