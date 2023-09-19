//
//  Account.swift
//  Mynance
//
//  Created by Madhav, Rishub P on 4/25/23.
//

import Foundation
import UIKit

struct Account : Encodable, Decodable
{
    var transactions : [Transaction]
    var balance : Double
}
