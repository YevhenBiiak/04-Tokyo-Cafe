//
//  OrderViewController.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 07.06.2022.
//

import UIKit

class OrderViewController: UIViewController {
    lazy var preferencesButton: UIBarButtonItem = {
        let image = UIImage(systemName: "gearshape.fill")
        let buttItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showPreferences))
        buttItem.tintColor = UIColor.darkGray
        return buttItem
    }()
    
    lazy var deleteAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("delete account", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.systemRed
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(nil, action: #selector(deleteAccount), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var reserveLabel: UILabel = {
        let label = UILabel()
        label.text = "Reserve a table"
        return label
    }()
    
    lazy var reserveSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = #colorLiteral(red: 0.4535181522, green: 0.5280769467, blue: 1, alpha: 1)
        return switcher
    }()
    
    lazy var myOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "My order list"
        return label
    }()
    
    lazy var editButton: UIButton = {
        var conf = UIButton.Configuration.plain()
        conf.image = UIImage(systemName: "checklist")
        conf.baseForegroundColor = .white
        let button = UIButton(configuration: conf)
        button.backgroundColor = #colorLiteral(red: 0.5483660102, green: 0.5474765897, blue: 0.5609511733, alpha: 0.3381622517)
        button.layer.cornerRadius = 17
        button.isEnabled = false
        button.addTarget(nil, action: #selector(switchEditingMode), for: .touchUpInside)
        return button
    }()
    
    lazy var orderTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    lazy var menuButton: UIButton = {
        let symbolConf = UIImage.SymbolConfiguration(pointSize: 20)
        var conf = UIButton.Configuration.plain()
        conf.image = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConf)
        conf.imagePadding = 8
        conf.imagePlacement = .leading
        conf.title = "Open menu"
        conf.baseForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let button = UIButton(configuration: conf)
        button.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.8)
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(showMenuViewController), for: .touchUpInside)
        return button
    }()
    
    lazy var confirmOrderButton: UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.title = "Confirm order"
        conf.baseBackgroundColor = #colorLiteral(red: 0.4535181522, green: 0.5280769467, blue: 1, alpha: 1)
        let button = UIButton(configuration: conf)
        button.addTarget(nil, action: #selector(showCheckViewController), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Properties
    
    let storage = UserDefaults.standard
    let customerKey = "account"
    
    var customer: String? {
        didSet {
            storage.set(customer, forKey: customerKey)
            self.title = customer
        }
    }
    
    var products: [(prod: Product, qty: Int)] = [] {
        didSet {
            orderTableView.reloadData()
            editButton.isEnabled = !orderList.isEmpty
            if orderList.isEmpty {
                editButton.backgroundColor = #colorLiteral(red: 0.5483660102, green: 0.5474765897, blue: 0.5609511733, alpha: 0.3381622517)
                isEditing = false
            }
        }
    }
    
    var orderList: [(prod: Product, qty: Int)] {
        products.filter { item in
            item.qty > 0
        }
    }
    
    let cellHeight: CGFloat = 85
    
    // MARK: - Life Cycle and override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        customer = storage.string(forKey: customerKey)
        if customer == nil {
            showLoginViewController()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deleteAccountButton.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        deleteAccountButton.isHidden = true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        orderTableView.isEditing = editing
        if editing {
            editButton.backgroundColor = #colorLiteral(red: 0.4535181522, green: 0.5280769467, blue: 1, alpha: 1)
        } else {
            editButton.backgroundColor = #colorLiteral(red: 0.5483660102, green: 0.5474765897, blue: 0.5609511733, alpha: 0.3381622517)
        }
    }
   
    // MARK: - Action methods
    
    private func showLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.loginCompletion = { customer in
            self.customer = customer
        }
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
    
    @objc private func showMenuViewController() {
        let menuViewController = MenuViewController()
        menuViewController.products = products
        menuViewController.closedMenuCompletion = { [unowned self] changedProducts in
            self.products = changedProducts
        }
        menuViewController.modalPresentationStyle = .popover
        present(menuViewController, animated: true)
    }
    
    @objc private func showCheckViewController() {
        let checkViewController = CheckViewController()
        checkViewController.orderList = orderList
        show(checkViewController, sender: nil)
    }
    
    @objc private func showPreferences() {
        deleteAccountButton.isHidden = !deleteAccountButton.isHidden
    }
    
    @objc private func deleteAccount() {
        storage.set(nil, forKey: customerKey)
        deleteAccountButton.isHidden = true
        viewDidAppear(true)
    }
    
    @objc private func switchEditingMode() {
        isEditing = !isEditing
    }
    
    // MARK: - Help methods
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = "back"
        navigationItem.setRightBarButton(preferencesButton, animated: true)
        
        orderTableView.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")
        orderTableView.dataSource = self
        orderTableView.delegate = self
        orderTableView.allowsSelectionDuringEditing = true
        
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(reserveLabel)
        view.addSubview(reserveSwitcher)
        view.addSubview(myOrderLabel)
        view.addSubview(editButton)
        view.addSubview(orderTableView)
        view.addSubview(menuButton)
        view.addSubview(confirmOrderButton)
        view.addSubview(deleteAccountButton)
    }
    
    private func addConstraints() {
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAccountButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        deleteAccountButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        deleteAccountButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        deleteAccountButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        reserveLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        reserveLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        reserveSwitcher.translatesAutoresizingMaskIntoConstraints = false
        reserveSwitcher.centerYAnchor.constraint(equalTo: reserveLabel.centerYAnchor).isActive = true
        reserveSwitcher.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        myOrderLabel.translatesAutoresizingMaskIntoConstraints = false
        myOrderLabel.topAnchor.constraint(equalTo: reserveLabel.bottomAnchor, constant: 24).isActive = true
        myOrderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.centerYAnchor.constraint(equalTo: myOrderLabel.centerYAnchor).isActive = true
        editButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -28).isActive = true
        
        orderTableView.translatesAutoresizingMaskIntoConstraints = false
        orderTableView.topAnchor.constraint(equalTo: myOrderLabel.bottomAnchor, constant: 12).isActive = true
        orderTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        orderTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        orderTableView.bottomAnchor.constraint(equalTo: confirmOrderButton.topAnchor, constant: -15).isActive = true
        
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.bottomAnchor.constraint(equalTo: confirmOrderButton.topAnchor, constant: -20).isActive = true
        menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                
        confirmOrderButton.translatesAutoresizingMaskIntoConstraints = false
        confirmOrderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmOrderButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        confirmOrderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        confirmOrderButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

}

// MARK: - Table View DataSource

extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        guard let cell = cell as? OrderCell else { return cell }
        
        let product = orderList[indexPath.row]
        cell.product = product
        cell.deleteButtonPressedCompletion = { [unowned self] in
            let productName = orderList[indexPath.row].prod.name
            if let index = products.firstIndex(where: { $0.prod.name == productName }) {
                products[index].qty = 0
            }
        }
        return cell
    }
}

// MARK: - Table View Delegate

extension OrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switchEditingMode()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.isEditing = false
        }
    }
    
}
