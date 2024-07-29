//
//  ContentView.swift
//  Memorize2024
//
//  Created by Chris Beloglazov on 7/28/24.
//

import SwiftUI

// a View is a rectangular area on screen that draws something

struct ContentView: View { // protocol oriented programming, behaves like a View
    var body: some View { // of type some View, a computed property
        HStack{
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View{
    var isFaceUp: Bool = false
    var body: some View{
        ZStack {
            if isFaceUp{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 10)
                Text("👻").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 20)
            }
            
        } // the stuff in curly brackets is a function
        // VStack(content: {Image() Text()})
    }
}
















#Preview {
    ContentView()
}
