//
//  AssignmentIII_SetApp.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/7/25.
//

import SwiftUI

@main
struct AssignmentIII_SetApp: App {
    private let game = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
