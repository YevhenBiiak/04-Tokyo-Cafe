//
//  MenuCell.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 11.06.2022.
//

import UIKit

class MenuCell: UITableViewCell {
    
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
    
    lazy var addToCartButton: UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.baseBackgroundColor = #colorLiteral(red: 0.4535181522, green: 0.5280769467, blue: 1, alpha: 1)
        conf.image = UIImage(systemName: "cart.badge.plus")
        conf.title = "Add"
        conf.imagePlacement = .trailing
        conf.imagePadding = 10
        let button = UIButton(configuration: conf)
        button.addTarget(nil, action: #selector(addButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Properties
    
    var product: (prod: Product, qty: Int)? {
        didSet {
            productImageView.image = product?.prod.image
            productTitleLable.text = product?.prod.name
            productSubtitleLabel.text = product?.prod.description
            productPriceLabel.text = String(product?.prod.price ?? 0) + " UAH"
            if let qty = product?.qty, qty > 0 {
                let imageName = "\(qty).circle.fill"
                addToCartButton.setImage(UIImage(systemName: imageName), for: .normal)
            } else {
                addToCartButton.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
            }
        }
    }
    
    var addToCartCompletion: (((prod: Product, qty: Int)) -> Void)?
    
    // MARK: - Initializators and override func
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Help methods
    
    @objc private func addButtonPressed() {
        if let qty = product?.qty, qty < 10 {
            product?.qty += 1
            addToCartCompletion?(product!)
        }
    }
    
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
        addSubview(addToCartButton)
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
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        addToCartButton.widthAnchor.constraint(equalToConstant: 95).isActive = true
    }
    
}
