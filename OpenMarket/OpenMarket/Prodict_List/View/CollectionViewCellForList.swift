//
//  CollectionViewCellForList.swift
//  OpenMarket
//
//  Created by 김찬우 on 2021/06/11.
//

import UIKit

class CollectionViewCellForList: UICollectionViewCell {
    
    static let identifier = "listCell"
    var item: Item!
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .white
        stackView.spacing = 5

        return stackView
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "yagom")

        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.backgroundColor = .white
        stackView.spacing = 5

        return stackView
    }()

    let productLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "야곰아카데미"
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        return textLabel
    }()

    let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .white
        stackView.spacing = 5

        return stackView
    }()

    let discountedPriceLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "KRW 1,000"
        textLabel.textColor = .lightGray
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 15)
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        return textLabel
    }()

    let originalPriceLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "USD 2,000"
        textLabel.textColor = .lightGray
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 15)
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        return textLabel
    }()

    let stockLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "품절"
        textLabel.textColor = .orange
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        return textLabel
    }()
    
    let chevronButton: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .systemGray2
        
        return button
    }()

    func configure(item: Item) {
            productLabel.text = item.title
            originalPriceLabel.text = "\(item.currency) \(item.price)"
            
            if item.discountedPrice != nil {
                discountedPriceLabel.text = "\(item.currency) \(item.discountedPrice!)"
                originalPriceLabel.textColor = UIColor.systemRed
                originalPriceLabel.attributedText = originalPriceLabel.text?.strikeThrough()
            } else {
                discountedPriceLabel.text = nil
                discountedPriceLabel.isHidden = true
            }

            if item.stock == 0 {
                stockLabel.text = "품절"
                stockLabel.textColor = .orange
            } else if item.stock > 99 {
                stockLabel.text = "잔여수량: 99↑"
                stockLabel.textColor = .systemGray2
            } else {
                stockLabel.text = "잔여수량: \(item.stock)"
                stockLabel.textColor = .systemGray2
            }
        
        
        DispatchQueue.global().async {
            guard let image = try? Data(contentsOf: URL(string: item.thumbnailURLs[0])!) else { return }

            DispatchQueue.main.async { [self] in
                imageView.image = UIImage(data: image)

            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mainStackView)

        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(contentsStackView)
        mainStackView.addArrangedSubview(stockLabel)
        mainStackView.addArrangedSubview(chevronButton)

        contentsStackView.addArrangedSubview(productLabel)
        contentsStackView.addArrangedSubview(priceStackView)

        priceStackView.addArrangedSubview(originalPriceLabel)
        priceStackView.addArrangedSubview(discountedPriceLabel)

        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),

            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.18),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productLabel.text = "야곰 아카데미"
        self.imageView.image = UIImage(named: "yagom")
//        self.originalPriceLabel.text = "USD 100"
        self.discountedPriceLabel.text = ""
        self.stockLabel.text = "품절"
        discountedPriceLabel.isHidden = false
        originalPriceLabel.attributedText = nil
        originalPriceLabel.textColor = UIColor.systemGray2
    }
}
