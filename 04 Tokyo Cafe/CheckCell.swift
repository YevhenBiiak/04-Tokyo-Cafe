//
//  CheckCell.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 09.06.2022.
//

import UIKit

class CheckCell: UITableViewCell {
    private lazy var attrItem: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16),
        .foregroundColor: UIColor.darkGray
    ]
    
    private lazy var attrTotal: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16, weight: .heavy),
        .foregroundColor: UIColor.darkGray
    ]
    
    private lazy var productTitleLable: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "title", attributes: attrItem)
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "price", attributes: attrItem)
        return label
    }()
    
    var product: (prod: Product, qty: Int)? {
        didSet {
            var prefix = ""
            if let qty = product?.qty, qty > 0 {
                prefix = "\(qty) x"
            }
            
            let title = product?.prod.name
            let price = "\(prefix) \(product?.prod.price ?? 0) UAH"
            
            productTitleLable.text = title
            productPriceLabel.text = price
        }
    }
    
    // MARK: - Initializators
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productTitleLable.attributedText = NSAttributedString(string: "title", attributes: attrItem)
        productPriceLabel.attributedText = NSAttributedString(string: "price", attributes: attrItem)
    }
    
    // MARK: - Help methods
    
    func totalRow(withPrice total: Float) {
        productTitleLable.attributedText = NSAttributedString(string: "Total", attributes: attrTotal)
        productPriceLabel.attributedText = NSAttributedString(string: "\(total) UAH", attributes: attrTotal)
    }
    
    private func setupCell() {
        backgroundColor = .white
        
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        addSubview(productTitleLable)
        addSubview(productPriceLabel)
    }
    
    private func addConstraints() {
        productTitleLable.translatesAutoresizingMaskIntoConstraints = false
        productTitleLable.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        productTitleLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        productTitleLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.centerYAnchor.constraint(equalTo: productTitleLable.centerYAnchor).isActive = true
        productPriceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    }
}
