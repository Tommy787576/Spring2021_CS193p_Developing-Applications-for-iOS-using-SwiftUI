//
//  ContentView.swift
//  Memorize
//
//  Created by 林士平 on 2023/3/9.
//

import SwiftUI

// More smaller views, less larger views
struct ContentView: View {
    // swift array -> []
    // Array<String> = [String] = Array of String
//    var emojis: Array<String> = ["🛳️", "🚌", "🚃", "🛵"]
//    var emojis: [String] = ["🛳️", "🚌", "🚃", "🛵"]
    var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍️", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡"]
//    var emojiCount: Int = 6
    @State var emojiCount = 7
    
    var body: some View {
        VStack {
            // LazyVGrid: specify a number of columns
            // LazyHGrid: specify a number of rows
            // GridItem(): can control more
            // .fixed vs. .flexible (flexible: default)
            
            // HStack -> use all the space in both w and h direction
            // LazyVGrid -> use all the width horizontally
            // but the height as small as possible
            // Lazy -> access view body part "if necessary!"
            
            // ScrollView: if overflow can be scrolled
            ScrollView {
//                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                // just 1 GridItem
                // adaptive: put as many as possible
                // one column contains multiple items!
                // like text in the book
                // minimum: minimum width of the each item
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    // ForEach -> elements in array must be identifiable
                    // here, we can use string itself as an identifier
                    // emoji in -> the argument of the function!
                    //            ForEach(emojis, id: \.self, content: { emoji in
                    //                CardView(content: emoji)
                    //            })
                    
                    // emojis[0..<6] -> 0 to 5
                    // emojis[0...5] -> 0 to 5
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
                
                //            CardView(content: emojis[0])
                //            CardView(content: emojis[1])
                //            CardView(content: emojis[2])
                //            CardView(content: emojis[3])
                //            CardView(isFaceUp: true)
                //            CardView(isFaceUp: true)
                //            CardView(isFaceUp: false)
                //            CardView(isFaceUp: true)
            }.foregroundColor(.red)
            // Spacer: will fill "all" the spaces between up and down
            Spacer()
            HStack {
                remove
                // Grab as much space as it can
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)

    }
    
    // we don't have to declare remove and add button as structures
    // => overkill => just varible is ok
    // SF symbol: https://developer.apple.com/sf-symbols/
//    var remove: some View {
//        Button(action: {
//            if emojiCount > 1 {
//                emojiCount -= 1
//            }
//        }, label: {
//            Image(systemName: "minus.circle")
//            VStack {
//                Text("Remove")
//                Text("Card")
//            }
//        })
//    }
    
    // two consequtive function arguments -> can move outside ()!
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    var add: some View {
        Button{
            // emojis.count: how many in that array
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
//            VStack {
//                Text("Add")
//                Text("Card")
//            }
            // plus.circle from SF symbol
            Image(systemName: "plus.circle")
        }
    }
}

// Edit -> emoji
// ios13: dark mode / light mode
struct CardView: View {
    // cannot have varibles with no values!!
//    var isFaceUp: Bool {
//        return true
//    }
    
    // can be provided as the argument
//    var isFaceUp: Bool
    // can also have the default value
//    var isFaceUp: Bool = true
    
    // @State: turns this variable a pointer to somewhere is mutable
    // @State won't use very much
    // when isFaceUp value is changed -> swiftUI will rebuild body itself
    @State var isFaceUp: Bool = true
    
    // option + click: document summary
    // or menu -> window -> developer document
    var content: String
    
    var body: some View {
        ZStack {
            // let vs. var
            // variable -> can change
            // let -> constant
//            var shape = RoundedRectangle(cornerRadius: 20.0)
            // shape has no type -> swift will infer the type!
//            let shape: RoundedRectangle = RoundedRectangle(cornerRadius: 20.0)
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                // .stroke().fill(): fill the racetrack not the rectangle
                // stroke: draw line outside the border
                // we want the border inside the shape
//                shape.stroke(lineWidth: 8)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        // self: enter view is immutable!
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}























// Control what the preview works
// Color Scheme: dark / light mode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
