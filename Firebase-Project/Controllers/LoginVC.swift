


import UIKit
import FirebaseAuth


class LoginVC: UIViewController {
    
//MARK: VIEWS
    
    lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "NotInstagram"
        label.font = UIFont(name: "PingFang TC", size: 50)
        label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
  
  lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "LOGIN"
        label.font = UIFont(name: "PingFang TC", size: 25)
        label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
  }()
  
    lazy var signUpButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("SIGN UP", for: .normal)
          button.setTitleColor(.white, for: .normal)
      button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
          button.titleLabel?.font = UIFont(name: "PingFang TC", size: 25)
          button.backgroundColor = .clear
          button.layer.borderWidth = 2
          button.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
          button.isEnabled = true
          button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
          return button
      }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Enter Email"
        textField.font = UIFont(name: "PingFang TC", size: 20)
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        textField.textColor = .white
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Enter Password"
        textField.font = UIFont(name: "PingFang TC", size: 20)
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 2
        textField.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        textField.textColor = .white
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()

  
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFang TC", size: 25)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.addTarget(self, action: #selector(tryLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
  

//MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupSubViews()
    }

//MARK: Obj-C methods

    @objc func validateFields() {
        guard emailTextField.hasText, passwordTextField.hasText else {
            loginButton.isEnabled = false
            return
        }
        loginButton.isEnabled = true
        loginButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }

    @objc func showSignUp() {
        let signupVC = SignUpVC()
        print("button pressed")
        signupVC.modalPresentationStyle = .formSheet
        present(signupVC, animated: true, completion: nil)
    }

    @objc func tryLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(with: "Error", and: "Please fill out all fields.")
            return
        }

//MARK: - remove whitespace (if any) from email/password
  
        guard email.isValidEmail else {
            showAlert(with: "Error", and: "Please enter a valid email")
            return
        }

        guard password.isValidPassword else {
            showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
            return
        }

        FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
            self.handleLoginResponse(with: result)
        }
    }

//MARK: Private methods

    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

    private func handleLoginResponse(with result: Result<(), Error>) {
        switch result {
        case .failure(let error):
            showAlert(with: "Error", and: "Could not log in. Error: \(error)")
        case .success:

            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    //MARK: TODO - handle could not swap root view controller
                    return
            }

            //MARK: TODO - refactor this logic into scene delegate
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                if FirebaseAuthService.manager.currentUser?.photoURL != nil {
                    window.rootViewController = TabBarVC()
                } else {
                    window.rootViewController = {
                        let profileSetupVC = EditProfileVC()
                        profileSetupVC.settingFromLogin = true
                        return profileSetupVC
                    }()
                }
            }, completion: nil)
        }
    }
    
//MARK: UI Setup
    
    private func setupSubViews() {
      companyNameLabelSetup()
      loginSignUpStackViewSetUp()
      emailPasswordStackViewSetUp()
    }
    
  
    private func companyNameLabelSetup() {
        view.addSubview(companyNameLabel)
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          companyNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
          companyNameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
          companyNameLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
          companyNameLabel.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
  
  
  private func loginSignUpStackViewSetUp() {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, signUpButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        self.view.addSubview(stackView)
    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -240),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
      }
  
  
    private func emailPasswordStackViewSetUp() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        self.view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 180)
        ])
      }

}

