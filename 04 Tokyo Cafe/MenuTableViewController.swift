//
//  MenuTableViewController.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 08.06.2022.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let cellHeight: CGFloat = 120
    var products: [Product] = []
    var addToCartComplition: ((Product) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = MenuItem.testSet
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        guard let cell = cell as? ProductCell else { return cell }
        
        let product = products[indexPath.row]
        cell.product = product

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = products[indexPath.row]
        addToCartComplition?(product)
    }

}
