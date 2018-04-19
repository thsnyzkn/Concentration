//
//  Card.swift
//  Concentration
//
//  Created by Tahsin Yazkan on 9.04.2018.
//  Copyright © 2018 Tahsin Yazkan. All rights reserved.
//

import Foundation


struct Card: Hashable
{
    var hashValue: Int {return identifier}
    static func == (lhs: Card, rhs: Card)-> Bool{
        return lhs.identifier == rhs.identifier
    }
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    var previouslyFlipped = false
    private static var identifierFactory = 0
    private static func getUniqueIdentifier()-> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
