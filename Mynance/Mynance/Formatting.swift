//
//  Formatting.swift
//  Mynance
//
//  Created by Madhav, Rishub P on 5/2/23.
//

import Foundation

class Formatting
{
    static func getDoubleValue(amount : String) -> Double
    {
        var newStr = ""
        if(amount.first != "$")
        {
            newStr = String(amount[amount.index(amount.startIndex, offsetBy: 1)...])
        }
        else
        {
            newStr = amount
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        let number = numberFormatter.number(from: newStr)
        return number!.doubleValue
    }
    static func textIsValidCurrencyFormat(text: String) -> Bool {
        var isValidCurrencyFormat = false

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        let number = numberFormatter.number(from: text)

        if number != nil {
            isValidCurrencyFormat = true
            if Double(truncating: number!) * 100 != floor(Double(truncating: number!) * 100) {
                isValidCurrencyFormat = false
            }
        }

        return isValidCurrencyFormat
    }
    
    static func FormatAsCurrency(_ amount : Double) -> String
    {
        return amount.formatted(.currency(code: "USD"))
    }
    static func getCurrentDate() -> String
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: date)
    }
    
}
