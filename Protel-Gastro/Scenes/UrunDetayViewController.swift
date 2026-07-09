//
//  UrunDetayViewController.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 9.07.2026.
//

import SnapKit
import UIKit

class UrunDetayViewController: UIViewController {
    
    private let product: MenuItem
    private let viewModel: UrunViewModel
    
    init(product:MenuItem){
        self.product = product
        self.viewModel = UrunViewModel(product: product)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let image: UIImageView = {
       let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let closeButton:UIButton = {
        let button=UIButton()
        let image = UIImage(systemName: "xmark.circle.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .themeOrange
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let salesCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let badge : UIView = {
        let view = UIView()
        view.backgroundColor = .themeOrange
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.text="Popüler"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let badgeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "flame.fill")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let badgeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()
    
    private let kitchenNoteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mutfak Notu (İsteğe bağlı)"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let kitchenNotePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "\"Sos olmasın\", \"Burger az pişsin\"..."
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let kitchenNote: UITextView = {
        let note = UITextView()
        note.backgroundColor = .themeCardBackground
        note.textColor = .white
        note.font = .systemFont(ofSize: 15, weight: .regular)
        note.layer.cornerRadius = 12
        
        note.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return note
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 22
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .themeOrange
        button.layer.cornerRadius = 22
        return button
    }()
    
    private let stepperStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 24
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let addToOrderButton: UIButton = {
            var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .themeOrange
            config.baseForegroundColor = .white
            config.image = UIImage(systemName: "bag.fill")
            config.imagePadding = 8
            
            let button = UIButton(configuration: config)
            button.layer.cornerRadius = 16
            button.clipsToBounds = true
            return button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
