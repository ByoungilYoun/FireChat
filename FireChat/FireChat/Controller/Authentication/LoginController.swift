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
  
  private let emailContainerView : UIView = {
    let view = UIView()
    view.backgroundColor = .cyan
    return view
  }()
  
  private let passwordContainerView : UIView = {
    let view = UIView()
    view.backgroundColor = .yellow
    return view
  }()
  
  private let loginButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Log In", for: .normal)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.backgroundColor = .systemRed
    return button
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
