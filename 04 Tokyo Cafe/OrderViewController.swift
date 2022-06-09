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
//      #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        button.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.5)
        button.layer.cornerRadius = 10
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
    let customerKey = "account"
    
    var customer: String? {
        didSet {
            storage.set(customer, forKey: customerKey)
            self.title = customer
        }
    }
    
    var orderList: [Product] = [] {
        didSet { orderTableView.reloadData() }
    }
    
    let cellHeight: CGFloat = 85
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderTableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        orderTableView.dataSource = self
        orderTableView.delegate = self
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//      storage.set(nil, forKey: customerKey)
        customer = storage.string(forKey: customerKey)
        if customer == nil {
            showLoginViewController()
        }
    }
    
    // MARK: - Help methods
    
    private func showLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.loginComplition = { customer in
            self.customer = customer
        }
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
    
    @objc private func showMenuViewController() {
        let menuViewController = MenuTableViewController(style: .grouped)
        menuViewController.addToCartComplition = { (product: Product) in
            self.orderList.append(product)
        }
        menuViewController.modalPresentationStyle = .popover
        present(menuViewController, animated: true)
    }
    
    @objc private func showCheckViewController() {
        let checkViewController = CheckViewController()
        checkViewController.orderList = orderList
        show(checkViewController, sender: nil)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = "back"
        
        addSubviews()
        addConstraints()
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
        orderTableView.bottomAnchor.constraint(equalTo: checkButton.topAnchor, constant: -15).isActive = true
        
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.bottomAnchor.constraint(equalTo: checkButton.topAnchor, constant: -20).isActive = true
        menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        checkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

}

// MARK: - Table View DataSource

extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

// MARK: - Table View Delegate

extension OrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            self.orderList.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
