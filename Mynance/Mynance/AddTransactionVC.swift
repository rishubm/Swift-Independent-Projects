//
//  AddTransactionVC.swift
//  Mynance
//
//  Created by Madhav, Rishub P on 4/17/23.
//

import Foundation
import UIKit

class AddTransactionVC : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet var boxView: UIView!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var amountField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var background: UIImageView!
    let types = ["Income", "Groceries", "Utilities"]
    var selectedType = "Income"
    var descriptionStr = ""
    var amount = ""
    
    var amountFlag = false
    var descriptionFlag = false
    
    
    override func viewDidLoad() {
        picker.delegate = self
        picker.dataSource = self
        boxView.layer.cornerRadius = 10
        saveButton.isEnabled = false
        self.view.sendSubviewToBack(background)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = types[row]
    }
    
    @IBAction func amountChanged(_ sender: UITextField) {
        guard let value = sender.text else
        {
            amountFlag = false
            updateSaveButtonState()
            return
        }
        
        if value.first == "$" && Formatting.textIsValidCurrencyFormat(text: value)
        {
            amountFlag = true
            amount = value
            updateSaveButtonState()
        }
        else if value.first != "$" {
            if let doubleValue = Double(value)
            {
                amountFlag = true
                amount = doubleValue.formatted(.currency(code: "USD"))
                updateSaveButtonState()
            }
        }
    }
    
    @IBAction func descriptionChanged(_ sender: UITextField) {
        guard let text = sender.text else
        {
            descriptionFlag = false
            updateSaveButtonState()
            return
        }
        descriptionStr = text
        descriptionFlag = true
        updateSaveButtonState()
    }
    func updateSaveButtonState()
    {
        saveButton.isEnabled = amountFlag && descriptionFlag
    }
}
