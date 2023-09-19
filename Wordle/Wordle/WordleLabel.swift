//
//  WordleLabel.swift
//  Wordle
//
//  Created by Madhav, Rishub P on 2/27/23.
//

import Foundation
import UIKit

class WordleLabel : UILabel
{
    static let GRAY = UIColor(red: 84/255.0, green: 84/255.0, blue: 84/255.0, alpha: 1)
    static let YELLOW =  UIColor(red: 177/255.0, green: 159/255.0, blue: 76/255.0, alpha: 1)
    static let GREEN =  UIColor(red: 97/255.0, green: 139/255.0, blue: 85/255.0, alpha: 1)
    var letter = ""
    var colorFlag = 0
    func flip(letter : String, colorFlag : Int)
    {
        UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromTop],
        animations: {
            self.updateLetter()
            self.updateColor()
        }
        )
    }
    func updateLetter()
    {
        self.text = letter
    }
    func updateColor()
    {
        switch colorFlag {
        case 0:
            self.backgroundColor = WordleLabel.GRAY
        case 1:
            self.backgroundColor = WordleLabel.YELLOW
        case 2:
            self.backgroundColor =  WordleLabel.GREEN
        default:
            self.backgroundColor = WordleLabel.GRAY
        }
    }
}
