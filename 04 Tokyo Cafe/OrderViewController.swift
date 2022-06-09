//
//  OrderViewController.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 07.06.2022.
//

import UIKit

class OrderViewController: UIViewController {
    
    lazy var reserveLabel: UILabel = {
        let label = UILabel()
        label.text = "Reserve a table"
        return label
    }()
    
    lazy var reserveSwitcher: UISwitch = {
        let switcher = UISwitch()
        return switcher
    }()
    
    lazy var myOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "My order list"
        return label
    }()
    
    lazy var orderTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    lazy var menuButton: UIButton = {
        let symbolConf = UIImage.SymbolConfiguration(pointSize: 20)
        var conf = UIButton.Configuration.plain()
        conf.image = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConf)
        conf.title = "Add another one"
        conf.imagePadding = 8
        conf.imagePlacement = .top
        let button = UIButton(configuration: conf)
        button.addTarget(nil, action: #selector(showMenuViewController), for: .touchUpInside)
        return button
    }()
    
    lazy var checkButton: UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.image = UIImage(systemName: "newspaper")
        conf.imagePadding = 8
        conf.title = "check, pleas"
        conf.baseBackgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let button = UIButton(configuration: conf)
        button.addTarget(nil, action: #selector(showCheckViewController), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let storage = UserDefaults.standard
    var customer: String?
    let cellHeight: CGFloat = 85
    var orderList: [Product] = [] {
        didSet {
            print("chaange")
            orderTableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        orderTableView.dataSource = self
        orderTableView.delegate = self

        customer = getCustomerPhone()
        setupViews()
    }
    
    // MARK: - Help methods
    
    private func getCustomerPhone() -> String? {
//        storage.set(nil, forKey: "account")
        if storage.string(forKey: "account") == nil {
            showLoginViewController()
        }
        return storage.string(forKey: "account")
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        self.title = customer
        navigationItem.backButtonTitle = "back to my order"
        
        addSubviews()
        addConstraints()
    }
    
    private func showLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
    
    @objc private func showMenuViewController() {
        let menuViewController = MenuTableViewController()
        menuViewController.addToCartComplition = { (product: Product) in
            self.orderList.append(product)
        }
        menuViewController.modalPresentationStyle = .popover
        present(menuViewController, animated: true)
    }
    
    @objc private func showCheckViewController() {
        let checkViewController = CheckViewController()
        show(checkViewController, sender: nil)
    }
    
    private func addSubviews() {
        view.addSubview(reserveLabel)
        view.addSubview(reserveSwitcher)
        view.addSubview(myOrderLabel)
        view.addSubview(orderTableView)
        view.addSubview(menuButton)
        view.addSubview(checkButton)
    }
    
    private func addConstraints() {
        reserveLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        reserveLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        reserveSwitcher.translatesAutoresizingMaskIntoConstraints = false
        reserveSwitcher.centerYAnchor.constraint(equalTo: reserveLabel.centerYAnchor).isActive = true
        reserveSwitcher.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        myOrderLabel.translatesAutoresizingMaskIntoConstraints = false
        myOrderLabel.topAnchor.constraint(equalTo: reserveLabel.bottomAnchor, constant: 40).isActive = true
        myOrderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        orderTableView.translatesAutoresizingMaskIntoConstraints = false
        orderTableView.topAnchor.constraint(equalTo: myOrderLabel.bottomAnchor, constant: 12).isActive = true
        orderTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        orderTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        orderTableView.bottomAnchor.constraint(equalTo: checkButton.topAnchor, constant: -50).isActive = true
        
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.centerYAnchor.constraint(equalTo: orderTableView.bottomAnchor, constant: -4).isActive = true
        menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

}

// MARK: - TableView

extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(orderList.count)
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        guard let cell = cell as? ProductCell else { return cell }
        
        let product = orderList[indexPath.row]
        cell.product = product
        cell.isOrderList = true

        return cell
    }
}
extension OrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
