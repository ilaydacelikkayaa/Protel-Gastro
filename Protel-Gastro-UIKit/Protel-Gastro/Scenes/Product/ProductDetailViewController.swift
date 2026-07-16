//
//  ProductDetailViewController.swift
//  Protel-Gastro
//
//  Created by İlayda Çelikkaya on 9.07.2026.
//

import SnapKit
import UIKit

class ProductDetailViewController: UIViewController {
    
    private let product: MenuItem
    private let viewModel: ProductViewModel
    private let tableId: Int
    
    init(product: MenuItem, tableId: Int) {
        self.product = product
        self.tableId = tableId
        self.viewModel = ProductViewModel(product: product)
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
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
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
        view.backgroundColor = .themeBackground
        setupHierarchy()
        setUpConstraints()
        setupBindings()
        configureData()
        fetchProductImage()
        setupActions()
        kitchenNote.delegate=self
        setupKeyboardNotifications()
        setupDismissKeyboardGesture()
    }
    
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(image)
        contentView.addSubview(closeButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(salesCountLabel)
        contentView.addSubview(badge)
        contentView.addSubview(kitchenNoteTitleLabel)
        contentView.addSubview(kitchenNote)
        contentView.addSubview(stepperStackView)
        
        view.addSubview(addToOrderButton)
        
        kitchenNote.addSubview(kitchenNotePlaceholderLabel)
        badge.addSubview(badgeStackView)
        badgeStackView.addArrangedSubview(badgeIcon)
        badgeStackView.addArrangedSubview(badgeLabel)
        
        stepperStackView.addArrangedSubview(minusButton)
        stepperStackView.addArrangedSubview(countLabel)
        stepperStackView.addArrangedSubview(plusButton)
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addToOrderButton.snp.top).offset(-16)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(350)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(44)
        }
        
        badge.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        badgeStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(20)
            make.trailing.lessThanOrEqualTo(priceLabel.snp.leading).offset(-16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(24)
            make.trailing.equalToSuperview().inset(20)
        }
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        priceLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        salesCountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        kitchenNoteTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(salesCountLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        kitchenNote.snp.makeConstraints { make in
            make.top.equalTo(kitchenNoteTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(120)
        }
        
        kitchenNotePlaceholderLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        stepperStackView.snp.makeConstraints { make in
            make.top.equalTo(kitchenNote.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        minusButton.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        plusButton.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        addToOrderButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
    }
    private func setupActions() {
            minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
            plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
            closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
            addToOrderButton.addTarget(self, action: #selector(addToOrderButtonTapped), for: .touchUpInside)
        }
    // MARK: - Data Binding
        private func setupBindings() {
            viewModel.onQuantityChanged = { [weak self] newCount in
                self?.countLabel.text = "\(newCount)"
            }
            
            viewModel.onTotalPriceChanged = { [weak self] priceText in
                var titleAttr = AttributedString("Adisyona Ekle — \(priceText)")
                titleAttr.font = .systemFont(ofSize: 18, weight: .bold)
                self?.addToOrderButton.configuration?.attributedTitle = titleAttr
            }
        }
    
    private func configureData() {
            titleLabel.text = viewModel.productName
            priceLabel.text = viewModel.productPriceText
            salesCountLabel.text = viewModel.orderCountText
            badge.isHidden = !viewModel.isPopular
            
            var titleAttr = AttributedString("Adisyona Ekle — \(viewModel.productPriceText)")
            titleAttr.font = .systemFont(ofSize: 18, weight: .bold)
            addToOrderButton.configuration?.attributedTitle = titleAttr
        }
    
    private func updateBottomButtonPrice(count: Int) {
        let priceText = viewModel.calculateTotalPrice(for: count)
        
        var titleAttr = AttributedString("Adisyona Ekle — \(priceText)")
        titleAttr.font = .systemFont(ofSize: 18, weight: .bold)
        
        addToOrderButton.configuration?.attributedTitle = titleAttr
    }
    
    @objc private func minusButtonTapped() {
            viewModel.decreaseQuantity()
        }
        
        @objc private func plusButtonTapped() {
            viewModel.increaseQuantity()
        }
    
    @objc private func closeButtonTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addToOrderButtonTapped() {
            let finalNote = viewModel.processKitchenNote(kitchenNote.text)
            
            CartManager.shared.addItem(
                tableId: self.tableId,
                menuItem: product,
                quantity: viewModel.quantity,
                kitchenNote: finalNote
            )
            
            dismiss(animated: true, completion: nil)
        }
    
    private func fetchProductImage() {
        viewModel.fetchImage{
            [weak self] image in
            self?.image.image=image
        }
    }
    // MARK: - Keyboard Handling Entegrasyonu
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.verticalScrollIndicatorInsets = contentInsets
        
        if kitchenNote.isFirstResponder {
            let rect = kitchenNote.convert(kitchenNote.bounds, to: scrollView)
            scrollView.scrollRectToVisible(rect, animated: true)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.verticalScrollIndicatorInsets = contentInsets
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension ProductDetailViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        kitchenNotePlaceholderLabel.isHidden = !textView.text.isEmpty
    }
}

