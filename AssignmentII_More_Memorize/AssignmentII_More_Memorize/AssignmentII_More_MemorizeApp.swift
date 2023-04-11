//
//  AssignmentII_More_MemorizeApp.swift
//  AssignmentII_More_Memorize
//
//  Created by 林士平 on 2023/4/11.
//

import SwiftUI

@main
struct AssignmentII_More_MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
