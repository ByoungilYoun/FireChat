//
//  LoginController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/06.
//

import UIKit
import SnapKit

class LoginController : UIViewController {
  
  //MARK: - Properties
  private let iconImage : UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "bubble.right")
    iv.tintColor = .white
    return iv
  }()
  
  private lazy var emailContainerView : UIView = {
    let containerView = UIView()
    containerView.backgroundColor = .clear
    
    let iv = UIImageView()
    iv.image = UIImage(systemName: "envelope")
    iv.tintColor = .white
    
    containerView.addSubview(iv)
    iv.snp.makeConstraints {
      $0.centerY.equalTo(containerView)
      $0.leading.equalToSuperview().offset(8)
      $0.width.equalTo(24)
      $0.height.equalTo(24)
    }
    
    containerView.addSubview(emailTextField)
    emailTextField.snp.makeConstraints {
      $0.centerY.equalTo(containerView)
      $0.leading.equalTo(iv.snp.trailing).offset(8)
      $0.right.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    return containerView
  }()
  
  private lazy var passwordContainerView : UIView = {
    let containerView = UIView()
    containerView.backgroundColor = .clear
    
    let iv = UIImageView()
    iv.image = UIImage(systemName: "lock")
    iv.tintColor = .white
    
    containerView.addSubview(iv)
    iv.snp.makeConstraints {
      $0.centerY.equalTo(containerView)
      $0.leading.equalToSuperview().offset(8)
      $0.width.equalTo(24)
      $0.height.equalTo(24)
    }
    
    containerView.addSubview(passwordTextField)
    passwordTextField.snp.makeConstraints {
      $0.centerY.equalTo(containerView)
      $0.leading.equalTo(iv.snp.trailing).offset(8)
      $0.right.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    return containerView  }()
  
  private let loginButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Log In", for: .normal)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.backgroundColor = .systemRed
    return button
  }()
  
  private let emailTextField : UITextField = {
    let tf = UITextField()
    tf.placeholder = "Email"
    tf.textColor = .white
    return tf
  }()
  
  private let passwordTextField : UITextField = {
    let tf = UITextField()
    tf.placeholder = "Password"
    tf.textColor = .white
    tf.isSecureTextEntry = true
    return tf
  }()
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    configureGradientLayer()
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black // LargeNavigationTitle 을 쓰면 barStyle 을 black 을 줘도 안먹는다. 스위프트 에러
    
    view.addSubview(iconImage)
    
    iconImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
      $0.width.equalTo(120)
      $0.height.equalTo(120)
    }
    
    let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
    stack.axis = .vertical
    stack.spacing = 16
    
    emailContainerView.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
    passwordContainerView.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
    loginButton.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
    view.addSubview(stack)
    stack.snp.makeConstraints {
      $0.top.equalTo(iconImage.snp.bottom).offset(32)
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
    }
  }
  
  func configureGradientLayer() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
    gradient.locations = [0 , 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }
}
