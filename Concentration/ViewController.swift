//
//  ViewController.swift
//  Concentration
//
//  Created by Tahsin Yazkan on 9.04.2018.
//  Copyright © 2018 Tahsin Yazkan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2 
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var newGameButton: UIButton!
    override  func viewDidLoad() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        for button in cardButtons {
            button.backgroundColor = game.chosen.cardColor
        }
        self.view.backgroundColor = game.chosen.backgroundColor
        scoreLabel.textColor = game.chosen.cardColor
        flipCountLabel.textColor = game.chosen.cardColor
    }
    @IBAction private func createNewGame(_ sender: UIButton) {
        flipCountLabel.text = "Flips: \(0)"
        scoreLabel.text = "Score: \(0)"
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        updateViewFromModel()
    }
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            let attributes: [NSAttributedStringKey : Any] = [
                .strokeWidth :5.0,
                .strokeColor : game.chosen.cardColor
            ]
            
            let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
                
            
            flipCountLabel.attributedText = attributedString
            scoreLabel.text = "Score: \(game.score)"
            
        } else {
            print ("chosen card is not set ")
        }
        
    }
    private func  updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if !game.isOver, card.isFaceUp{
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
                }else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5766271658, blue: 0.06862082923, alpha: 0): game.chosen.cardColor
                    button.isEnabled = card.isMatched ? false : true
                    
                }
            
            
            self.view.backgroundColor = game.chosen.backgroundColor
            scoreLabel.textColor = game.chosen.cardColor
            flipCountLabel.textColor = game.chosen.cardColor
        }
    }
    
    private var emoji = [Card:String]()
    private func emoji (for card: Card) -> String{
        if emoji[card] == nil, game.chosen.emojis.count > 0 {
            let randomStringIndex = game.chosen.emojis.index(game.chosen.emojis.startIndex, offsetBy: game.chosen.emojis.count.arc4random)
            emoji[card] = String(game.chosen.emojis.remove(at: randomStringIndex))
        }
            return emoji[card] ?? "?"
        }
    
   
    
    @IBOutlet weak var flipCountLabel: UILabel!
}
extension Int {
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
        
    }
}

