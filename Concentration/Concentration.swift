//
//  Concentration.swift
//  Concentration
//
//  Created by Tahsin Yazkan on 9.04.2018.
//  Copyright © 2018 Tahsin Yazkan. All rights reserved.
//

import Foundation
import UIKit
extension Array{
    mutating func shuffle(){
        
        for  index in 0..<count{
            let randomIndex = Int(arc4random_uniform(UInt32(count)))
            swapAt(randomIndex, index)
        }
    }
}
struct Concentration
{
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?
    {
        get {
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices{
                if cards[index].isFaceUp{
                    cards[index].previouslyFlipped = true
                }
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    var score = 0
    var flipCount = 0
    var numberOfPairedMatches = 0
    var isOver:Bool{
        return numberOfPairedMatches == 8
    }
     struct Theme
    {
        var emojis : String!
         var cardColor : UIColor!
         var backgroundColor : UIColor!
        
    }
    var chosen = Theme()
    var themes = [Theme(emojis: "👻👹😈🎃🍭🍬😱🤡☠️🕸", cardColor: #colorLiteral(red: 1, green: 0.5834846681, blue: 0.1984327281, alpha: 1), backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                  Theme(emojis: "🐣😘🧐🤓😔🤫🤭🐤🍇🥜", cardColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), backgroundColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
                  Theme(emojis: "⚽️🏀🏈⚾️🎾🎱🏓🏒🥊🎿", cardColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), backgroundColor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)),
                  Theme(emojis: "🥃🍸🍺🍷🍾🍹🥂🥤🍵☕️", cardColor: #colorLiteral(red: 0.9782849284, green: 0.9958103951, blue: 0.2426556567, alpha: 1), backgroundColor: #colorLiteral(red: 0.6767147856, green: 0.8123832268, blue: 0.9764705896, alpha: 1)),
                  Theme(emojis: "🍏🍎🥒🍆🥕🍌🥝🍑🍒🍓", cardColor: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), backgroundColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
                  Theme(emojis: "🐬🐙🐡🐠🐟🦈🦐🦀🦑🐳", cardColor: #colorLiteral(red: 0.06341744434, green: 0.5664875015, blue: 1, alpha: 1), backgroundColor: #colorLiteral(red: 0.06717305696, green: 0.9764705896, blue: 0.1164800607, alpha: 1))]
   mutating func chooseCard (at index : Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : chosen index not in the cards")
        flipCount += 1
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    numberOfPairedMatches += 1
                    score += 2
                }
                else if cards[index].previouslyFlipped,cards[matchIndex].previouslyFlipped{
                    score -= 2
                }
                else if  cards[index].previouslyFlipped {
                    score -= 1
                }
                else if  cards[matchIndex].previouslyFlipped {
                    score -= 1
                }
                
                cards[index].isFaceUp = true
                
            } else{
                //either no cards or 2 cards are face up
                
                indexOfOneAndOnlyFaceUpCard = index
                
            }
        }
        
    }
    init(numberOfPairsOfCards : Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : must have at least one pair of cards ")
        let randomInex = Int(arc4random_uniform(UInt32(themes.count)))
        chosen = themes[randomInex]
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
        cards.shuffle()
        
    }
    
}
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first:nil
    }
}
