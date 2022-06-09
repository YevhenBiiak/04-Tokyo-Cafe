//
//  CheckCell.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 09.06.2022.
//

import UIKit

class CheckCell: UITableViewCell {
    
    lazy var productTitleLable: UILabel = {
        let attrDict = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "title", attributes: attrDict)
        return label
    }()
    
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Initializators
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
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
