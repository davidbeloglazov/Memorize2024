//
//  ContentView.swift
//  Memorize2024
//
//  Created by Chris Beloglazov on 7/28/24.
//

import SwiftUI

// a View is a rectangular area on screen that draws something. Views are immutable
// Swift is a very strongly typed language, use type inference

enum Theme: Int {
    case halloween,
         education,
         colors
    
    func correspondingImage() -> Image {
        switch self {
        case .halloween:
            return Image(systemName: "cloud.moon.bolt.fill")
        case .education:
            return Image(systemName: "book.pages")
        case .colors:
            return Image(systemName: "circle.lefthalf.filled.righthalf.striped.horizontal.inverse")
//        default:
//            return Image(systemName: "questionmark.square.dashed")
        }
    }
    
    func correspondingColor() -> Color {
        switch self {
        case .halloween:
            return Color.orange
        case .education:
            return Color.green
        case .colors:
            return Color.white
//        default:
//            return Image(systemName: "questionmark.square.dashed")
        }
    }
}

struct ContentView: View { // protocol oriented programming, behaves like a View
    @State var currentTheme = Theme.halloween
    @State var nCards = 12
    @State var scale: (CGFloat, CGFloat) = (80, 100)
    
    let emojis = [["👻", "🎃", "🕷️", "😈", "🧟", "🦇", "🕸️", "🧛", "🌙", "🧙", "🍬", "🔮"],
                  ["📚", "🎨", "🔬", "🧮", "🌍", "🖍️", "🔔", "🍎", "🎓", "✏️", "🧠", "📐"],
                  ["🔴", "🟠", "🟡", "🟢", "🔵", "🟣", "⚪", "⚫", "🟤", "🩶", "🟥", "🟩"]]

    var body: some View { // of type some View, a computed property
        title
        VStack {
            ScrollView {
                cards
            }
            VStack {
//                Spacer()
                themeSelectors
            }
            .padding()
        }
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .bold()
            .foregroundColor(currentTheme.correspondingColor())
    }
    
    func themeSelector(_ theme: Theme) -> some View {
        Button {
            currentTheme = theme
            nCards = Int.random(in: 6...emojis[currentTheme.rawValue].count)
            print(emojis[currentTheme.rawValue].count)
            nCards -= nCards % 2
            if nCards < 10 {
                scale = (100, 120)
            } else {
                scale = (80, 100)
            }
            
        } label: {
            VStack{
                theme.correspondingImage()
                Text(String(describing: theme))
                    .font(.body)
            }
            
        }
    }

    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: scale.0, maximum: scale.1))], spacing: 10) { // implicit return
            ForEach(Array(0..<nCards).shuffled(), id:\.self) { index in
                CardView(content: emojis[currentTheme.rawValue][index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(currentTheme.correspondingColor())
    }
    
    var themeSelectors: some View {
        HStack {
            themeSelector(Theme.halloween)
                .foregroundColor(Theme.halloween.correspondingColor())
            Spacer()
            themeSelector(Theme.education)
                .foregroundColor(Theme.education.correspondingColor())
            Spacer()
            themeSelector(Theme.colors)
                .foregroundColor(Theme.colors.correspondingColor())
        }
        .imageScale(.large)
        .font(.largeTitle)
        
    }

}

struct CardView: View {
    let content: String
    @State var isFaceUp = false // without @State we have an error
    var body: some View { // only lets in View because it's read-only
        ZStack { // trailing closure syntax
            let base = RoundedRectangle(cornerRadius: 12) // type inference
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
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
