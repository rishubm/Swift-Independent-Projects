//
//  TransactionType.swift
//  Mynance
//
//  Created by Madhav, Rishub P on 4/13/23.
//

import Foundation
enum TransactionType : String, Encodable, Decodable {
    case income = "Income"
    case utilities = "Utilities"
    case groceries = "Groceries"
}
