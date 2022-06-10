//
//  ProductCell.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 08.06.2022.
//

import UIKit

class ProductCell: UITableViewCell {
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var productTitleLable: UILabel = {
        let attrDict = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "title", attributes: attrDict)
        return label
    }()
    
    lazy var productSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var addToOrderButton: UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.baseBackgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        conf.image = UIImage(systemName: "cart.badge.plus")
        conf.title = "Add"
        conf.imagePlacement = .trailing
        conf.imagePadding = 10
        let button = UIButton(configuration: conf)
        button.addTarget(nil, action: #selector(addToCart), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    var product: Product? {
        didSet {
            productImageView.image = product?.image
            productTitleLable.text = product?.name
            productSubtitleLabel.text = product?.description
            productPriceLabel.text = String(product?.price ?? 0) + " UAH"
        }
    }
    
    var isOrderList = false {
        didSet {
            addToOrderButton.isHidden = isOrderList
        }
    }
    var addToCartComplition: ((Product) -> Void)?
    
    // MARK: - Initializators
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Help methods
    
    @objc private func addToCart() {
        
    }
    
    private func setupCell() {
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        addSubview(productImageView)
        addSubview(productTitleLable)
        addSubview(productSubtitleLabel)
        addSubview(productPriceLabel)
        addSubview(addToOrderButton)
    }
    
    private func addConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        productImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor).isActive = true
        
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.topAnchor.constraint(equalTo: productImageView.topAnchor).isActive = true
        productPriceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        
        addToOrderButton.translatesAutoresizingMaskIntoConstraints = false
        addToOrderButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        addToOrderButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        addToOrderButton.widthAnchor.constraint(equalToConstant: 95).isActive = true
        
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
