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
            return "Set Game!"
        }
    }
    
    func matchStatusTextColor() -> Color {
        if model.getMatchedState() == 1 {
            return Color.red
        }
        else if model.getMatchedState() == 2 {
            return Color.cyan
        }
        else {
            return Color.black
        }
    }
    
    func getDealCardsIconColor() -> Color {
        model.deckIsEmpty() ? Color.gray : Color.blue
    }
    
    func getCardBackgroundColor(_ card: Card) -> Color {
        if model.getMatchedState() == 1 && card.isChosen {
            // the cards involved in a non-matching trio must look different
            return Color.red.opacity(0.3)
        }
        else if model.getMatchedState() == 2 && card.isChosen {
            return Color.cyan.opacity(0.3)
        }
        else if card.isChosen {
            return Color.gray.opacity(0.3)
        }
        else {
            return Color.white
        }
    }
    
    func restart() {
        model = SetGameViewModel.createSetGame()
    }
}
