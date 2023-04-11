//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 林士平 on 2023/3/9.
//

import SwiftUI

@main
struct MemorizeApp: App {
    // use let? -> class is a reference type
    // we don't change the pointer (game) itself but change what it points to!
    let game = EmojiMemoryGame()    // free init of class: does nothing
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
