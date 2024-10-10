//
//  ShimmerView.swift
//  CapX
//
//  Created by Abhay singh on 08/10/24.
//

import SwiftUI

struct ShimmerView : View {
    var body: some View {
        HomePageView()
            .redacted(reason: .placeholder)
            .modifier(Shimmer())
    }
}

struct Shimmer: ViewModifier {
    @State var isInitialState : Bool = true
    
    public func body(content: Content) -> some View {
        content
            .mask {
                LinearGradient(
                    gradient: .init(colors: [Color("bgColor").opacity(0.4), Color("bgColor"), Color("bgColor").opacity(0.4)]),
                    startPoint: (isInitialState ? .init(x: -0.3, y: -0.3) : .init(x: 1.0, y: 1.0)),
                    endPoint: (isInitialState ? .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3)))
            }
            .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isInitialState)
            .onAppear(){
                isInitialState = false
            }
    }
}

#Preview {
    ShimmerView()
}
