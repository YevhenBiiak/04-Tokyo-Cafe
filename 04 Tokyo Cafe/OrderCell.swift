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
        let attr: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 19, weight: .bold)
        ]
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "title", attributes: attr)
        return label
    }()
    
    lazy var productSubtitleLabel: UILabel = {
        let label = UILabel()
        let attr: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.systemGray
        ]
        label.attributedText = NSAttributedString(string: "subtitle", attributes: attr)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var productDeleteButton: UIButton = {
        let symbConf = UIImage.SymbolConfiguration(pointSize: 20)
        var conf = UIButton.Configuration.plain()
        conf.image = UIImage(systemName: "xmark.circle.fill", withConfiguration: symbConf)
        conf.baseForegroundColor = .red
        let button = UIButton(configuration: conf)
        button.addTarget(nil, action: #selector(deleteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private var deleteButtonConstraint: NSLayoutConstraint?
    
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
    
    var deleteButtonPressedCompletion: (() -> Void)?
    
    // MARK: - Initializators and override func
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            deleteButtonConstraint?.constant = -15
        } else {
            deleteButtonConstraint?.constant = 40
        }
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Action methods
    
    @objc private func deleteButtonPressed() {
        deleteButtonPressedCompletion?()
    }
    
    // MARK: - Help methods
    
    private func setupCell() {
        selectionStyle = .none
        contentView.isUserInteractionEnabled = true
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        addSubview(productImageView)
        addSubview(productTitleLable)
        addSubview(productSubtitleLabel)
        addSubview(productPriceLabel)
        addSubview(productDeleteButton)
    }
    
    private func addConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        productImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
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
        
        productDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        productDeleteButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        deleteButtonConstraint = productDeleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 40)
        deleteButtonConstraint?.isActive = true
    }
}
