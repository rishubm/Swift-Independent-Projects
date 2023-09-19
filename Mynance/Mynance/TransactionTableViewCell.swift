//
//  TransactionTableViewCell.swift
//  Mynance
//
//  Created by Madhav, Rishub P on 4/13/23.
//

import Foundation
import UIKit



class TransactionTableViewCell : UITableViewCell
{
    @IBOutlet weak var img : UIImageView! //image
    @IBOutlet weak var cellTitle : UILabel! //title of cell
    @IBOutlet weak var cellDetail : UILabel!//detail
    @IBOutlet weak var cellDate : UILabel!//date
    @IBOutlet weak var cellBalance : UILabel!//deposit or withdrawl balance
    
    
}
