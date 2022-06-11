//
//  OrderCell.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 08.06.2022.
//

import UIKit

class OrderCell: UITableViewCell {
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var productTitleLable: UILabel = {
        let attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19, weight: .bold)]
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "title", attributes: attr)
        return label
    }()
    
    lazy var productSubtitleLabel: UILabel = {
        let label = UILabel()
        let attr = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.systemGray
        ]
        label.attributedText = NSAttributedString(string: "subtitle", attributes: attr)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var leftConstraint: NSLayoutConstraint?
    
    var product: (prod: Product, qty: Int)? {
        didSet {
            productImageView.image = product?.prod.image
            productTitleLable.text = product?.prod.name
            productSubtitleLabel.text = product?.prod.description
            var prefix = ""
            if let qty = product?.qty, qty > 0 {
                prefix = "\(qty) x"
            }
            productPriceLabel.text = "\(prefix) \(product!.prod.price) UAH"
        }
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            leftConstraint?.constant = 60.0
        } else {
            leftConstraint?.constant = 16
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
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
    
    // MARK: - Help methods
    
    private func setupCell() {
        contentView.isUserInteractionEnabled = true
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        addSubview(productImageView)
        addSubview(productTitleLable)
        addSubview(productSubtitleLabel)
        addSubview(productPriceLabel)
    }
    
    private func addConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        leftConstraint = productImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        leftConstraint?.isActive = true
        productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor).isActive = true
        
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.topAnchor.constraint(equalTo: productImageView.topAnchor).isActive = true
        productPriceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        productTitleLable.translatesAutoresizingMaskIntoConstraints = false
        productTitleLable.topAnchor.constraint(equalTo: productImageView.topAnchor).isActive = true
        productTitleLable.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 8).isActive = true
        productTitleLable.rightAnchor.constraint(lessThanOrEqualTo: productPriceLabel.leftAnchor, constant: -8).isActive = true
        
        productSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        productSubtitleLabel.topAnchor.constraint(equalTo: productTitleLable.bottomAnchor, constant: 10).isActive = true
        productSubtitleLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 8).isActive = true
        productSubtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    }
    
}
