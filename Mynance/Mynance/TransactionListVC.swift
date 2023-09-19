//
//
//  Mynance
//
//  Created by Madhav, Rishub P on 4/11/23.
//

import UIKit

class TransactionListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var items : [Transaction] = []
    @IBOutlet var background: UIImageView!
    @IBOutlet var tableView: UITableView!
    var totalBalance = 0.0
    @IBOutlet var balanceStr: UILabel!
    var user : Account?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 10
        
        self.view.sendSubviewToBack(background)
        self.tableView.backgroundColor =  UIColor.clear
        
        if let data = UserDefaults.standard.data(forKey: "User")
        {
            do{
                user = try JSONDecoder().decode(Account.self, from: data)
                print("decoded Account into user")
            }
            catch
            {
                print("error Account")
            }
            
        }
        else{
            user = Account(transactions: items, balance: totalBalance)
        }
        items = user!.transactions
        totalBalance = user!.balance
        balanceStr.text = Formatting.FormatAsCurrency(totalBalance)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionTableViewCell
        cell.cellTitle.text? = items[indexPath.row].cellTitle
        cell.cellDetail.text? = items[indexPath.row].cellDetail
        cell.cellBalance.text? = items[indexPath.row].cellBalance
        cell.cellBalance.textColor = items[indexPath.row].cellBalance.starts(with: "+") ? UIColor.systemGreen : UIColor.systemRed
        cell.img.image! = UIImage(named: items[indexPath.row].img)!
        cell.cellDate.text? = items[indexPath.row].cellDate
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8
            let maskLayer = CALayer()
            maskLayer.cornerRadius = 10
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
            cell.layer.mask = maskLayer
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let old = items[indexPath.row]
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateBalance(old.cellBalance, old.type == .groceries || old.type == .utilities ? .income : .utilities)
            user?.transactions = items
            updateUserDefaults()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "add", sender: self)
    }
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as! AddTransactionVC
        let amount = sourceViewController.amount
        if amount == "" {
            return
        }
        let typeStr = sourceViewController.selectedType
        let type  = TransactionType(rawValue: typeStr)!
        let description = sourceViewController.descriptionStr
        
     
        let stringDate = Formatting.getCurrentDate()
        let transaction =  Transaction(type: type, detailText: description, date: stringDate, balance: amount)
        
        items.append(transaction)
        user?.transactions = items
        tableView.reloadData()
        updateBalance(amount, type)
        updateUserDefaults()
    }
    
    func updateUserDefaults()
    {
        guard let encoded = try? JSONEncoder().encode(user) else {return}
        UserDefaults.standard.set(encoded, forKey: "User")
    }
    
    func updateBalance(_ amount : String, _ type : TransactionType)
    {
        var amountNum = Formatting.getDoubleValue(amount: amount)
        if type == .utilities || type == .groceries
        {
            amountNum  *= -1
        }
        totalBalance += amountNum
        user?.balance = totalBalance
        balanceStr.text = totalBalance.formatted(.currency(code: "USD"))
        updateUserDefaults()
    }
}

