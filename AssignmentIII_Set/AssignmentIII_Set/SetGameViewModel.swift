//
//  SetGameViewModel.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/8/3.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGameModel.Card

    private static func createSetGame() -> SetGameModel {
        SetGameModel()
    }
    
    @Published private var model = createSetGame()

    var cards: Array<Card> {
        model.cards
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func dealThreeMoreCards() {
        model.dealThreeMoreCards()
    }
    
    func deckIsEmpty() -> Bool {
        model.deckIsEmpty()
    }
    
    func matchStatusText() -> String {
        if model.getMatchedState() == 1 {
            return "Unmatched!"
        }
        else if model.getMatchedState() == 2 {
            return "Matched!"
        }
        else {
            return "Set Game!😀"
        }
    }
    
    func restart() {
        model = SetGameViewModel.createSetGame()
    }
}
