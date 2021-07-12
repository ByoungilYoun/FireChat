//
//  LoginController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/06.
//

import UIKit
import SnapKit
import Firebase

protocol AuthenticationControllerProtocol {
  func checkFormStatus()
}

class LoginController : UIViewController {
  
  //MARK: - Properties
  private var viewModel = LoginViewModel()
  
  private let iconImage : UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "bubble.right")
    iv.tintColor = .white
    return iv
  }()
  
  private lazy var emailContainerView : InputContainerView = {
    let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
    return containerView
  }()
  
  private lazy var passwordContainerView : InputContainerView = {
    let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
    return containerView
  }()

  private let loginButton : CustomButton = {
    let button = CustomButton(title: "Log In")
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    return button
  }()
  
  private let emailTextField = CustomTextField(placeholder: "Email")
  
  private let passwordTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "Password")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let dontHaveAccountButton : UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor : UIColor.white])
    attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.font : UIFont.boldSystemFont(ofSize: 16), .foregroundColor : UIColor.white]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    return button
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Keyboard endEditing
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  //MARK: - Functions
  private func configureUI() {
    configureGradientLayer()
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black // LargeNavigationTitle 을 쓰면 barStyle 을 black 을 줘도 안먹는다. 스위프트 에러
    let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
    stack.axis = .vertical
    stack.spacing = 16
    
    [iconImage, stack, dontHaveAccountButton].forEach {
      view.addSubview($0)
    }
    
    iconImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
      $0.width.equalTo(120)
      $0.height.equalTo(120)
    }
    
    loginButton.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
    stack.snp.makeConstraints {
      $0.top.equalTo(iconImage.snp.bottom).offset(32)
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
    }
    
    dontHaveAccountButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
  
  //MARK: - Selectors
  @objc func handleLogin() {
    guard let email = emailTextField.text else {return}
    guard let password = passwordTextField.text else {return}
    AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
      if let error = error {
        print("Debug : Failed to log in with error : \(error.localizedDescription)")
        return
      }
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @objc func handleShowSignUp() {
    let controller = RegistrationController()
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func textDidChange(sender : UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else {
      viewModel.password = sender.text
    }
    checkFormStatus()
  }
}

  //MARK: - AuthenticationControllerProtocol
extension LoginController : AuthenticationControllerProtocol {
  func checkFormStatus() {
    if viewModel.formIsValid {
      loginButton.isEnabled = true
      loginButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    } else {
      loginButton.isEnabled = false
      loginButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    }
  }
}
