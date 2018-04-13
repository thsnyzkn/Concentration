//
//  ViewController.swift
//  Concentration
//
//  Created by Tahsin Yazkan on 9.04.2018.
//  Copyright © 2018 Tahsin Yazkan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2 
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    override func viewDidLoad() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        for button in cardButtons {
            button.backgroundColor = game.chosen.cardColor
        }
        self.view.backgroundColor = game.chosen.backgroundColor
        scoreLabel.textColor = game.chosen.cardColor
        flipCountLabel.textColor = game.chosen.cardColor
    }
    @IBAction func createNewGame(_ sender: UIButton) {
        flipCountLabel.text = "Flips: \(0)"
        scoreLabel.text = "Score: \(0)"
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        updateViewFromModel()
    }
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreLabel.text = "Score: \(game.score)"
            
        } else {
            print ("chosen card is not set ")
        }
        
    }
    func updateViewFromModel(){
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
    
    var emoji = [Int:String]()
    func emoji (for card: Card) -> String{
        if emoji[card.identifier] == nil, game.chosen.emojis.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(game.chosen.emojis.count)))
            emoji[card.identifier] = game.chosen.emojis.remove(at: randomIndex)
        }
            return emoji[card.identifier] ?? "?"
        }
    
   
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
}

