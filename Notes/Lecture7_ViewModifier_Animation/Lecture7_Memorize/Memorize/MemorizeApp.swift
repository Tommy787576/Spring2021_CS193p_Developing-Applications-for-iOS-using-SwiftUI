//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 林士平 on 2023/3/9.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
