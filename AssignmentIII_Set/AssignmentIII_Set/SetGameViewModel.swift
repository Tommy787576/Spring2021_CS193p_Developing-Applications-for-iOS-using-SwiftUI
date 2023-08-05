//
//  SetGameViewModel.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/8/3.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGameModel<String>.Card
    private static let emojis = ["", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", "","", "", "", "", ""]

    private static func createSetGame() -> SetGameModel<String> {
        SetGameModel<String>(numberOfCards: 10) { idx in
            emojis[idx]
        }
    }
    
    @Published private var model = createSetGame()

    var cards: Array<Card> {
        model.cards
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
