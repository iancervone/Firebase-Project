


import UIKit
import FirebaseAuth


class SignUpVC: UIViewController {
    
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
  
  lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "SIGN UP"
        label.font = UIFont(name: "PingFang TC", size: 25)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor = .clear
        label.textAlignment = .center
//        label.layer.borderWidth = 2
//        label.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
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
          button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
          button.addTarget(self, action: #selector(trySignUp), for: .touchUpInside)
          button.isEnabled = true
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
        button.setTitleColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .normal)
        button.backgroundColor = .clear
//        button.layer.borderWidth = 2
//        button.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        button.addTarget(self, action: #selector(showLogIn), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()

  

    //MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupSubViews()
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }

    //MARK: Obj-C methods

    @objc func validateFields() {
    guard emailTextField.hasText, passwordTextField.hasText else {
        signUpButton.isEnabled = false
        return
    }
    signUpButton.isEnabled = true
}
  
  @objc func showLogIn() {
         let loginVC = LoginVC()
         print("button pressed")
         loginVC.modalPresentationStyle = .formSheet
         present(loginVC, animated: true, completion: nil)
     }

@objc func trySignUp() {
    guard let email = emailTextField.text, let password = passwordTextField.text else {
        showAlert(with: "Error", and: "Please fill out all fields.")
        return
    }

    guard email.isValidEmail else {
        showAlert(with: "Error", and: "Please enter a valid email")
        return
    }

    guard password.isValidPassword else {
        showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
        return
    }

    FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { [weak self] (result) in
        self?.handleCreateAccountResponse(with: result)
    }
}

    //MARK: Private methods
  
  private func showAlert(with title: String, and message: String) {
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
  }
  
  private func handleCreateAccountResponse(with result: Result<User, Error>) {
      DispatchQueue.main.async { [weak self] in
          switch result {
          case .success(let user):
              FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
                  self?.handleCreatedUserInFirestore(result: newResult)
              }
          case .failure(let error):
              self?.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
          }
      }
  }
  
  private func handleCreatedUserInFirestore(result: Result<(), Error>) {
      switch result {
      case .success:
          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
              else {
                  //MARK: TODO - handle could not swap root view controller
                  return
          }

          //MARK: TODO - refactor this logic into scene delegate
          //MARK: MAKE ANIMATION SLIDE FROM LEFT TO RIGHT
          UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                  window.rootViewController = TabBarVC()
          }, completion: nil)
      case .failure(let error):
          self.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
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
        let stackView = UIStackView(arrangedSubviews: [loginButton, signUpLabel])
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
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signUpButton])
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


extension SignUpVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
