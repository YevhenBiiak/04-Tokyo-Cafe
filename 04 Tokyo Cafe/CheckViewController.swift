//
//  CheckViewController.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 07.06.2022.
//

import UIKit

class CheckViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    var orderList: [(prod: Product, qty: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        tableView.backgroundColor = .white
        tableView.layer.borderColor = UIColor.darkGray.cgColor
        tableView.layer.borderWidth = 0.5
        
        tableView.register(CheckCell.self, forCellReuseIdentifier: "CheckCell")
        tableView.allowsSelection = false
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
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
            let product = orderList[indexPath.row].prod
            let qty = orderList[indexPath.row].qty
            
            var prefix = ""
            if qty > 0 {
                prefix = "\(qty) x"
            }
            
            let title = product.name
            let price = "\(prefix) \(product.price) UAH"
            
            cell.productTitleLable.text = title
            cell.productPriceLabel.text = price
            
        } else {
            let totalPrice = orderList.reduce(Float(0)) { res, item in
                res + item.prod.price * Float(item.qty)
            }
            cell.totalRow(withPrice: totalPrice)
        }
            
        return cell
    }
}
