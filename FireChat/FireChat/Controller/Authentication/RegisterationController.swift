//
//  RegisterationController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/06.
//

import UIKit

class RegistrationController : UIViewController {
  
  //MARK: - Properties
  
  private let plusPhotoButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    return button
  }()
  
  private lazy var emailContainerView : InputContainerView = {
    let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
    return containerView
  }()
  
  private lazy var fullNameContainerView : InputContainerView = {
    let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextField)
    return containerView
  }()
  
  private lazy var userNameContainerView : InputContainerView = {
    let containerView = InputContainerView(image:  #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField)
    return containerView
  }()
  
  private lazy var passwordContainerView : InputContainerView = {
    let containerView = InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
    return containerView
  }()
  
  private let emailTextField = CustomTextField(placeholder: "Email")
  private let fullnameTextField = CustomTextField(placeholder: "Full Name")
  private let usernameTextField = CustomTextField(placeholder: "Username")
  
  private let passwordTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "Password")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let signupButton : CustomButton = {
    let button = CustomButton(title: "Sign Up")
    return button
  }()
  
  private let alreadyHaveAccountButton : UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor : UIColor.white])
    attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.font : UIFont.boldSystemFont(ofSize: 16), .foregroundColor : UIColor.white]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    return button
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  func configureUI() {
    configureGradientLayer()

    let stack = UIStackView(arrangedSubviews: [emailContainerView, fullNameContainerView, userNameContainerView, passwordContainerView, signupButton])
    stack.axis = .vertical
    stack.spacing = 16
    
    [plusPhotoButton, stack, alreadyHaveAccountButton].forEach {
      view.addSubview($0)
    }
    
    plusPhotoButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
      $0.width.equalTo(200)
      $0.height.equalTo(200)
    }
    
    signupButton.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
    stack.snp.makeConstraints {
      $0.top.equalTo(plusPhotoButton.snp.bottom).offset(25)
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
    }
    
    alreadyHaveAccountButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  //MARK: - Selectors
  @objc func handleSelectPhoto() {
    print("Select photo here...")
  }
  
  @objc func handleShowLogin() {
    navigationController?.popViewController(animated: true)
  }
}

