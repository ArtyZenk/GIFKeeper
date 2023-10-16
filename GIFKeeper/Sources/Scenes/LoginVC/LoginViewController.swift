//
//  LoginViewController.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 13.10.2023.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - UI

    private lazy var loginTextField: UITextField = {
        let email = UITextField()
        email.placeholder = Constants.emailTFPlaceholder
        email.borderStyle = .roundedRect
        email.backgroundColor = .systemGray6
        email.textContentType = .emailAddress
        email.clearButtonMode = .whileEditing
        email.autocapitalizationType = .none
        email.returnKeyType = .next
        email.delegate = self
        return email
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = Constants.passwordTFPlaceholder
        password.borderStyle = .roundedRect
        password.backgroundColor = .systemGray6
        password.textContentType = .password
        password.isSecureTextEntry = true
        password.rightViewMode = .whileEditing
        password.rightView = showPasswordButton
        password.returnKeyType = .done
        password.enablesReturnKeyAutomatically = true
        password.delegate = self
        return password
    }()
    
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0,y: 0,
                              width: Constants.showPasswordButtonWidth,
                              height: Constants.showPasswordButtonHeight)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return button
    }()
    
    private let loginStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.loginStackSpacing
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.loginButtonTitle, for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = Constants.loginButtonCornerRadius
        button.tintColor = .white
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgotButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.forgotButtonTitle, for: .normal)
        button.tintColor = .systemOrange
        button.addTarget(self, action: #selector(forgotButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupView()
        setupNavigationBar()
    }
    
    // MARK: - Private methods
    
    @objc private func loginButtonPressed() {
        guard
            let login = loginTextField.text,
            let password = passwordTextField.text
        else { return }
        
        if Array(login).contains(["@", "."]) && password.count >= 8 {
            showAlert(title: "Welcome", message: "Aboba")
        } else {
            showAlert(title: "Error", message: "Login or password is not correct")
        }
    }
    
    @objc private func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
        
        if passwordTextField.isSecureTextEntry {
            showPasswordButton.setImage(UIImage(systemName: Constants.showPasswordButtonImage), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(systemName: Constants.showPasswordButtonSelectedImage), for: .normal)
        }
    }
    
    @objc private func forgotButtonPressed() {
        showAlert(title: "Oops", message: "Your password is Aboba", textField: passwordTextField)
    }
}

// MARK: - Setup hierarchy

private extension LoginViewController {
    func setupHierarchy() {
        loginStack.addArrangedSubview(loginTextField)
        loginStack.addArrangedSubview(passwordTextField)
        
        buttonStack.addArrangedSubview(loginButton)
        buttonStack.addArrangedSubview(forgotButton)
        
        view.addSubview(loginStack)
        view.addSubview(buttonStack)
    }
}

// MARK: - Setup layout

private extension LoginViewController {
    func setupLayout() {
        loginTextField.snp.makeConstraints { $0.height.equalTo(Constants.emailTextFieldHeight) }
        passwordTextField.snp.makeConstraints { $0.height.equalTo(Constants.passwordTextFieldHeight) }
        loginButton.snp.makeConstraints { $0.height.equalTo(Constants.loginButtonHeight) }
        
        loginStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.loginStackTopConstrain)
            $0.left.equalTo(Constants.loginStackLeftConstrain)
            $0.right.equalTo(Constants.loginStackRightConstrain)
        }
        
        buttonStack.snp.makeConstraints {
            $0.centerY.equalTo(view)
            $0.left.equalTo(Constants.buttonStackLeftConstrain)
            $0.right.equalTo(Constants.buttonStackRightConstrain)
        }
    }
}

// MARK: - Setup view

private extension LoginViewController {
    func setupView() {
        view.backgroundColor = .white
    }
}
    
// MARK: - Setup navigationbar

private extension LoginViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.navigationTitle
    }
}

// MARK: - Alert methods

private extension LoginViewController {
    func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in textField?.text = "" }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        }
        
        return true
    }
}

// MARK: - Constants

private enum Constants {
        static let emailTFPlaceholder = "Email"
        static let passwordTFPlaceholder = "Password"
        
        static let showPasswordButtonWidth: CGFloat = 30
        static let showPasswordButtonHeight: CGFloat = 30
        
        static let loginStackSpacing: CGFloat = 16
        
        static let loginButtonCornerRadius: CGFloat = 15
        
        static let showPasswordButtonImage = "eye"
        static let showPasswordButtonSelectedImage = "eye.slash"
        
        static let loginButtonTitle = "Log in"
        static let forgotButtonTitle = "Forgot your password"
        
        static let emailTextFieldHeight: CGFloat = 40
        static let passwordTextFieldHeight: CGFloat = 40
        static let loginButtonHeight: CGFloat = 40
        
        static let loginStackTopConstrain: CGFloat = 30
        static let loginStackLeftConstrain: CGFloat = 16
        static let loginStackRightConstrain: CGFloat = -16
        
        static let buttonStackLeftConstrain: CGFloat = 16
        static let buttonStackRightConstrain: CGFloat = -16
        
        static let navigationTitle = "Log in"
    }
