//
//  BalanceChartVC.swift
//  Mynance
//
//  Created by Madhav, Rishub P on 4/28/23.
//

import Foundation
import UIKit
import Charts

class BalanceChartVC : UIViewController, ChartViewDelegate
{
    var user : Account {
        get {
            return (self.tabBarController!.viewControllers![0] as! TransactionListVC).user!
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for sub in view.subviews
        {
            if !(sub is UIImageView) && !(sub is UILabel)
            {
                sub.removeFromSuperview()
            }
        }
        createChart()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func getDataSet() -> [Double]
    {
        var incomeCount = 0.0
        var groceryCount = 0.0
        var utitlityCount = 0.0
        for transaction in user.transactions
        {
            switch transaction.type
            {
            case .income:
                incomeCount += getDoubleValue(amount: transaction.cellBalance)
            case.utilities:
                utitlityCount += getDoubleValue(amount: transaction.cellBalance)
            case .groceries:
                groceryCount += getDoubleValue(amount: transaction.cellBalance)
            }
            
        }
        return [incomeCount, groceryCount, utitlityCount]
    }
    
    func createChart()
    {
    
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        barChart.xAxis.drawLabelsEnabled = false
        barChart.leftAxis.drawLabelsEnabled = true
        barChart.rightAxis.drawLabelsEnabled = false
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.leftAxis.drawGridLinesEnabled = true
        barChart.rightAxis.drawGridLinesEnabled = false
        barChart.drawBordersEnabled = true
        barChart.isUserInteractionEnabled = false
        barChart.drawGridBackgroundEnabled = true
        barChart.gridBackgroundColor = NSUIColor.white
        barChart.layer.cornerRadius = 10
    

        
        var entries = [BarChartDataEntry]()
        let userBals = getDataSet()
        for x in 0..<3{
            entries.append(BarChartDataEntry(x: Double(x), y: userBals[x]))
        }
        let setIncome  = BarChartDataSet(entries: [entries[0]], label: "Income")
        setIncome.colors = [NSUIColor.systemGreen]
        
        
        let setGrocery  = BarChartDataSet(entries: [entries[1]], label: "Groceries")
        setGrocery.colors = [NSUIColor.systemRed]
        
        let setUtil = BarChartDataSet(entries: [entries[2]], label: "Utilities")
        setUtil.colors = [NSUIColor.systemBlue]
        
        let data = BarChartData(dataSets: [setIncome, setGrocery, setUtil])
        
        barChart.data = data
        
        view.addSubview(barChart)
        barChart.center = view.center
        
        
    }
    func getDoubleValue(amount : String) -> Double
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
    
}
