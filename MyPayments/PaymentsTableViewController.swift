//
//  paymentsTableViewController.swift
//  MyPayments
//
//  Created by Dima Chirukhin on 21.10.2021.
//

import UIKit

class PaymentsTableViewController: UITableViewController {
    var token = ""
    var answ : (Bool, [pay] , String) = (true,[],"")

    @objc func ExitButton(){ dismiss(animated: true, completion: nil)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Мои платежи"
        DispatchQueue.main.async { [self] in
            answ = loadPauments(token: token)
            self.tableView.reloadData()
            if answ.0 == false{
                let alert = UIAlertController(title: "Ошибка загрузки данных", message: answ.2, preferredStyle: .alert)
                let aletactoin = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                alert.addAction(aletactoin)
                present(alert,animated: true,completion: nil)
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выйти", style: .done, target: self, action: #selector(ExitButton))
        tableView.register(paymentsCell.self, forCellReuseIdentifier: "cel")
        
    }

    //----------------------//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answ.1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cel", for: indexPath) as! paymentsCell
        let item = answ.1[indexPath.row]
        cell.descLabel.text = item.desc
        cell.amountLabel.text = item.amount + " " + item.currency
        if let time = Double(item.created) {
            let exactDate = NSDate.init(timeIntervalSince1970: time)
            let dateFormatt = DateFormatter();
            dateFormatt.dateFormat = "dd.MM.yyy HH:mm"
            cell.createdLabel.text = dateFormatt.string(from: exactDate as Date)
        }
        return cell
    }
}
    
