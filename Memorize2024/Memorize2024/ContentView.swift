//
//  ContentView.swift
//  Memorize2024
//
//  Created by Chris Beloglazov on 7/28/24.
//

import SwiftUI

// a View is a rectangular area on screen that draws something. Views are immutable
// Swift is a very strongly typed language, use type inference

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

struct CardView: View {
    @State var isFaceUp = false // without @State we have an error
    var body: some View { // only lets in View because it's read-only
        ZStack { // trailing closure syntax
            let base = RoundedRectangle(cornerRadius: 12) // type inference
            if isFaceUp{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            } else {
                base.fill()
            }
            
        }.onTapGesture {
//            print("tapped")
//            isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }
        // the stuff in curly brackets is a function
        // VStack(content: {Image() Text()})
    }
}
















#Preview {
    ContentView()
}
