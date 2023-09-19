//
//  Transaction.swift
//  Mynance
//
//  Created by Madhav, Rishub P on 4/17/23.
//

import Foundation
import UIKit

class Transaction : Encodable, Decodable
{
    var cellTitle : String
    var cellDetail : String
    var cellDate : String
    var cellBalance : String
    var type : TransactionType
    let img : String
    
    init(type : TransactionType, detailText : String, date : String, balance : String)
    {
        self.type = type
        cellTitle = type.rawValue   
        cellDetail  = detailText
        cellDate = date
        
        switch type
        {
        case .income:
            img = "money"
            cellBalance = "+" + balance
        case .utilities:
            img = "gear"
            cellBalance = "-" + balance
        case .groceries:
            img =  "cart"
            cellBalance = "-" + balance
        }
    }
}
