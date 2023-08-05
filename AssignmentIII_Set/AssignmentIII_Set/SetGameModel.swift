//
//  SetGame.swift
//  AssignmentIII_Set
//
//  Created by 林士平 on 2023/8/3.
//

import Foundation

struct SetGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init (numberOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for idx in 0..<numberOfCards {
            let content = createCardContent(idx)
            cards.append(Card(content: content, id: idx))
        }
    }

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            cards.remove(at: chosenIndex)
        }
    }

    struct Card: Identifiable {
        var isChosen = false
        let content: CardContent
        let id: Int
    }
}

