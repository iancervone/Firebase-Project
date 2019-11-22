//
//  LoginVC.swift
//  Firebase-Project
//
//  Created by Ian Cervone on 11/22/19.
//  Copyright © 2019 Ian Cervone. All rights reserved.
//


import UIKit

class LoginVC: UIViewController {
    
    //MARK: VIEWS
    
    lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "NotInstagram"
        label.font = UIFont(name: "PingFang TC", size: 50)
        label.textColor = .blue
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email"
        textField.font = UIFont(name: "PingFang TC", size: 20)
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        textField.textColor = .white
        textField.autocorrectionType = .no
//        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
//
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.font = UIFont(name: "PingFang TC", size: 20)
        textField.backgroundColor = .white
//        textField.borderStyle = .bezel
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
//        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
//
//    lazy var loginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Login", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 14)
//        button.backgroundColor = UIColor(red: 255/255, green: 67/255, blue: 0/255, alpha: 1)
//        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(tryLogin), for: .touchUpInside)
//        button.isEnabled = false
//        return button
//    }()
//
//    lazy var createAccountButton: UIButton = {
//        let button = UIButton(type: .system)
//        let attributedTitle = NSMutableAttributedString(string: "Dont have an account?  ",
//                                                        attributes: [
//                                                            NSAttributedString.Key.font: UIFont(name: "Verdana", size: 14)!,
//                                                            NSAttributedString.Key.foregroundColor: UIColor.white])
//        attributedTitle.append(NSAttributedString(string: "Sign Up",
//                                                  attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana-Bold", size: 14)!,
//                                                               NSAttributedString.Key.foregroundColor:  UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
//        button.setAttributedTitle(attributedTitle, for: .normal)
//        button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
//        return button
//    }()
//
    //MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .darkGray
        setupSubViews()
    }

//    //MARK: Obj-C methods
//
//    @objc func validateFields() {
//        guard emailTextField.hasText, passwordTextField.hasText else {
//            loginButton.backgroundColor = UIColor(red: 255/255, green: 67/255, blue: 0/255, alpha: 0.5)
//            loginButton.isEnabled = false
//            return
//        }
//        loginButton.isEnabled = true
//        loginButton.backgroundColor = UIColor(red: 255/255, green: 67/255, blue: 0/255, alpha: 1)
//    }
//
//    @objc func showSignUp() {
//        let signupVC = SignUpViewController()
//        signupVC.modalPresentationStyle = .formSheet
//        present(signupVC, animated: true, completion: nil)
//    }
//
//    @objc func tryLogin() {
//        guard let email = emailTextField.text, let password = passwordTextField.text else {
//            showAlert(with: "Error", and: "Please fill out all fields.")
//            return
//        }
//
//        //MARK: TODO - remove whitespace (if any) from email/password
//
//        guard email.isValidEmail else {
//            showAlert(with: "Error", and: "Please enter a valid email")
//            return
//        }
//
//        guard password.isValidPassword else {
//            showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
//            return
//        }
//
//        FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
//            self.handleLoginResponse(with: result)
//        }
//    }
//
//    //MARK: Private methods
//
//    private func showAlert(with title: String, and message: String) {
//        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        present(alertVC, animated: true, completion: nil)
//    }
//
//    private func handleLoginResponse(with result: Result<(), Error>) {
//        switch result {
//        case .failure(let error):
//            showAlert(with: "Error", and: "Could not log in. Error: \(error)")
//        case .success:
//
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
//                else {
//                    //MARK: TODO - handle could not swap root view controller
//                    return
//            }
//
//            //MARK: TODO - refactor this logic into scene delegate
//            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
//                if FirebaseAuthService.manager.currentUser?.photoURL != nil {
//                    window.rootViewController = RedditTabBarViewController()
//                } else {
//                    window.rootViewController = {
//                        let profileSetupVC = ProfileEditViewController()
//                        profileSetupVC.settingFromLogin = true
//                        return profileSetupVC
//                    }()
//                }
//            }, completion: nil)
//        }
//    }
    
    //MARK: UI Setup
    
    private func setupSubViews() {
        companyNameLabelConstraints()
        emailTextFieldConstraints()
        passwordTextFieldConstraints()
//        setupCreateAccountButton()
//        setupLoginStackView()
    }
    
    private func companyNameLabelConstraints() {
        view.addSubview(companyNameLabel)
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          companyNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
          companyNameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
          companyNameLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
          companyNameLabel.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
  
    private func emailTextFieldConstraints() {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          emailTextField.heightAnchor.constraint(equalToConstant: 50),
          emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
          emailTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
          ])
      }
  
  private func passwordTextFieldConstraints() {
      view.addSubview(passwordTextField)
      passwordTextField.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
        passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
        passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
        passwordTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
//
//        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField,loginButton])
//        stackView.axis = .vertical
//        stackView.spacing = 15
//        stackView.distribution = .fillEqually
//        self.view.addSubview(stackView)
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            stackView.bottomAnchor.constraint(equalTo: createAccountButton.topAnchor, constant: -50),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            stackView.heightAnchor.constraint(equalToConstant: 130)])
    
//
//    private func setupCreateAccountButton() {
//        view.addSubview(createAccountButton)
//
//        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            createAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            createAccountButton.heightAnchor.constraint(equalToConstant: 50)])
//    }
}
