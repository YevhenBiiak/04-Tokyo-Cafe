//
//  MenuViewController.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 08.06.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    let menuTitleLabel: UILabel = {
        let font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        let attr = [NSAttributedString.Key.font: font]
        let attrString = NSAttributedString(string: "Menu", attributes: attr)
        let label = UILabel()
        label.attributedText = attrString
        return label
    }()
    
    let closeMenuButton: UIButton = {
        let symbolConf = UIImage.SymbolConfiguration(pointSize: 20)
        var conf = UIButton.Configuration.plain()
        conf.baseForegroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        conf.image = UIImage(systemName: "xmark.circle.fill", withConfiguration: symbolConf)
        let button = UIButton(configuration: conf)
        button.addTarget(nil, action: #selector(closeMenu), for: .touchUpInside)
        return button
    }()
    
    let menuTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let cellHeight: CGFloat = 120
    var products: [Product] = []
    var addToCartComplition: ((Product) -> Void)?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        products = MenuItem.testSet
        
        setupViews()
        menuTableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        
    }
    
    // MARK: - Actions
    
    @objc private func closeMenu() {
        self.dismiss(animated: true)
    }
    
    // MARK: - Help functions
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        self.title = "sds"
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(menuTitleLabel)
        view.addSubview(closeMenuButton)
        view.addSubview(menuTableView)
    }
    private func addConstraints() {
        closeMenuButton.translatesAutoresizingMaskIntoConstraints = false
        closeMenuButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        closeMenuButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        menuTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        menuTitleLabel.centerYAnchor.constraint(equalTo: closeMenuButton.centerYAnchor).isActive = true
        menuTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.topAnchor.constraint(equalTo: closeMenuButton.bottomAnchor, constant: 8).isActive = true
        menuTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        menuTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true
    }
}
    
// MARK: - Table view data source

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        guard let cell = cell as? ProductCell else { return cell }
        
        let product = products[indexPath.row]
        cell.product = product
        
        return cell
    }
}

// MARK: - Table view delegate

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = products[indexPath.row]
        addToCartComplition?(product)
    }
}
