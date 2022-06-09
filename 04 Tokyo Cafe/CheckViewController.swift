//
//  CheckViewController.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 07.06.2022.
//

import UIKit

class CheckViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    var orderList: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tableView.register(CheckCell.self, forCellReuseIdentifier: "CheckCell")
                
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true
    }
}

extension CheckViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckCell", for: indexPath)
        guard let cell = cell as? CheckCell else { return cell }
        
        if indexPath.row < orderList.count {
            
            let title = orderList[indexPath.row].name
            let price = orderList[indexPath.row].price
            cell.productTitleLable.text = title
            cell.productPriceLabel.text = String(price)
            
        } else {
            
            let totalPrice = orderList.reduce(Float(0)) { res, item in
                res + item.price
            }
            cell.productTitleLable.text = "Total"
            cell.productPriceLabel.text = String(totalPrice)
            
        }
            
        return cell
    }
}
