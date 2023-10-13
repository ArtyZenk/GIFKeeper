//
//  DetailGifViewController.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 13.10.2023.
//

import UIKit
import SnapKit

class DetailGifViewController: UIViewController {
   
    // MARK: - Adding UI Elements
    
    private var gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = Constants.onePointBorderWidth
        imageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(Constants.halfOfPointAlpha).cgColor
        imageView.layer.cornerRadius = Constants.gifViewRadius
        return imageView
    }()
    
    private var gifAttributesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.spacingStackView
        return stackView
    }()
    
    private var nameStackView = CustomStackViewDetailViewController()
    private var nameLabel = CustomLabelDetailViewController(text: "Name")
    private var nameTextField = CustomTextFieldDetailViewController()
   
    private var tagsStackView = CustomStackViewDetailViewController()
    private var tagsLabel = CustomLabelDetailViewController(text: "Tags")
    private var tagsTextField = CustomTextFieldDetailViewController()
    
    private var descriptionStackView = CustomStackViewDetailViewController()
    private var descriptionLabel = CustomLabelDetailViewController(text: "Description")
    private var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: Constants.appFontSize)
        textView.isScrollEnabled = true
        textView.autocapitalizationType = .sentences
        textView.layer.cornerRadius = Constants.textFieldCornerRadius
        textView.layer.borderWidth = Constants.onePointBorderWidth
        textView.layer.borderColor = UIColor.lightGray.withAlphaComponent(Constants.halfOfPointAlpha).cgColor
        return textView
    }()
    
    private var groupsStackView = CustomStackViewDetailViewController()
    private var groupsLabel = CustomLabelDetailViewController(text: "Groups")
    private var groupsTextField: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.numberOfLinesTextView
        label.layer.cornerRadius = Constants.textFieldCornerRadius
        label.layer.borderWidth = Constants.onePointBorderWidth
        label.layer.borderColor = UIColor.lightGray.withAlphaComponent(Constants.veryLightAlpha).cgColor
        return label
    }()
    
    private var editGroupsButton: UIButton = {
        let button = CustomButtonDetailViewController(text: "Edit groups")
        //         button.addTarget(nil, action: #selector(MainViewController.locationButtonTapped), for: .touchUpInside)
        return button
    }()

    private var deleteButton: UIButton = {
        let button = CustomButtonDetailViewController(text: "Delete")
        //         button.addTarget(nil, action: #selector(MainViewController.locationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupHierarchy()
        setupLayout()
        configureView()
        addGestures()
        registerForKeyboardNotifications()
    }
}

// MARK: - Configure Navigation bar

extension DetailGifViewController {
    private func configureNavigationBar() {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.appMainColor(),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSizeNavBarTitle,
                                                           weight: .thin),
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.title = "Gif name"
    }

    func configureTitleView(gifName: String) {
        navigationItem.title = gifName
    }
}

// MARK: - Setup hierarchy subviews

private extension DetailGifViewController {
    func setupHierarchy() {
        view.addSubview(gifAttributesScrollView)
        gifAttributesScrollView.addSubview(containerStackView)
        gifAttributesScrollView.contentSize = view.frame.size
        
        containerStackView.addArrangedSubview(gifImageView)
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        containerStackView.addArrangedSubview(nameStackView)
        
        tagsStackView.addArrangedSubview(tagsLabel)
        tagsStackView.addArrangedSubview(tagsTextField)
        containerStackView.addArrangedSubview(tagsStackView)
        
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.addArrangedSubview(descriptionTextView)
        containerStackView.addArrangedSubview(descriptionStackView)
        
        groupsStackView.addArrangedSubview(groupsLabel)
        groupsStackView.addArrangedSubview(groupsTextField)
        containerStackView.addArrangedSubview(groupsStackView)
        
        containerStackView.addArrangedSubview(editGroupsButton)
        containerStackView.addArrangedSubview(deleteButton)
    }
}

// MARK: - Setup layouts for UIElements

private extension DetailGifViewController {
    func setupLayout() {
        gifAttributesScrollView.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.left.equalTo(view).offset(Constants.offsetTargetUIElements)
            $0.right.equalTo(view).inset(Constants.insetTargetUIElements)
            $0.bottom.equalTo(view).inset(Constants.insetTargetUIElements)
        }
        
        gifImageView.snp.makeConstraints { $0.height.equalTo(gifImageView.snp.width).multipliedBy(Constants.heightImageView) }
        
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(gifAttributesScrollView.snp.width)
        }
        
        nameTextField.snp.makeConstraints { $0.height.equalTo(Constants.heightTextField) }
        tagsTextField.snp.makeConstraints { $0.height.equalTo(Constants.heightTextField) }
        
        descriptionTextView.snp.makeConstraints { $0.height.equalTo(nameTextField).multipliedBy(Constants.doubleMultiplier) }
        groupsTextField.snp.makeConstraints { $0.height.equalTo(nameTextField.snp.height).multipliedBy(Constants.doubleMultiplier) }
    }
}

// MARK: - Configure view property

private extension DetailGifViewController {
    func configureView() {
        view.backgroundColor = .white
        descriptionTextView.delegate = self
        nameTextField.delegate = self
        tagsTextField.delegate = self
    }
}

// MARK: - Setup gestures

private extension DetailGifViewController {
    func addGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapHideKeyboard)))
    }
    
    @objc func handleTapHideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Keyboard notifications and methods

private extension DetailGifViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowHide(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShowHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        var heightYOffset: CGFloat = 0
        if notification.name == UIResponder.keyboardWillShowNotification {
            let keyboardHeight = keyboardValue.cgRectValue.height
            let tabBarHeight = CGFloat(tabBarController?.tabBar.frame.size.height ?? 0)
            heightYOffset = keyboardHeight - tabBarHeight + Constants.offsetUIElements
        }
       
        changeOffsetMainScrollView(heightYOffset: heightYOffset)
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func changeOffsetMainScrollView(heightYOffset: CGFloat) {
        let scrollViewContentInset = UIEdgeInsets(top: 0, left: 0, bottom: heightYOffset, right: 0)
        gifAttributesScrollView.contentInset = scrollViewContentInset
        gifAttributesScrollView.scrollIndicatorInsets = scrollViewContentInset
      
        if let firstResponderView = findFirstResponderView() {
            let textViewFrame = firstResponderView.convert(firstResponderView.bounds, to: gifAttributesScrollView)
            let visibleRect = gifAttributesScrollView.convert(gifAttributesScrollView.bounds, to: firstResponderView)
            
            let shouldScrollToVisible = !(visibleRect.contains(textViewFrame))
            if shouldScrollToVisible {
                gifAttributesScrollView.scrollRectToVisible(textViewFrame, animated: true)
            }
        }
    }
    
    private func findFirstResponderView() -> UIView? {
        return descriptionTextView.isFirstResponder ? descriptionTextView : nil
    }
}

// MARK: - UIElements delegation methods

extension DetailGifViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            tagsTextField.becomeFirstResponder()
        } else {
            descriptionTextView.becomeFirstResponder()
        }
        return true
    }
}

extension DetailGifViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

// MARK: - Constants

private enum Constants {
    static var halfOfPointAlpha: CGFloat = 0.5
    static var veryLightAlpha: CGFloat = 0.2
   
    static let gifViewRadius: CGFloat = 8
    static let spacingStackView: CGFloat = 5
   
    static var appFontSize: CGFloat = 20
    
    static var textFieldCornerRadius: CGFloat = 8
    
    static var onePointBorderWidth: CGFloat = 1
    static var numberOfLinesTextView = 2
    
    static let fontSizeNavBarTitle: CGFloat = 28
    
    static let offsetTargetUIElements: ConstraintOffsetTarget = 8
    static let insetTargetUIElements: ConstraintInsetTarget = 8
    
    static let heightTextField = 30
    static let heightImageView = 2.0 / 3.0
    static let doubleMultiplier = 2
    static let offsetUIElements: CGFloat = 8
}

extension UIColor {
    static func appMainColor() -> UIColor {
        UIColor(red: 58 / 255,
                green: 163 / 255,
                blue: 144 / 255,
                alpha: 1)
    }
}
