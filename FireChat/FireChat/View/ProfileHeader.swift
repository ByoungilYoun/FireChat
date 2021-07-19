//
//  ProfileHeader.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/19.
//

import UIKit

protocol ProfileHeaderDelegate : AnyObject {
  func dismissController()
}

class ProfileHeader : UIView {
  
  //MARK: - Properties
  weak var delegate : ProfileHeaderDelegate?
  
  var user : User? {
    didSet {
      populateUserData()
    }
  }
  
  private let dismissButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "xmark"), for: .normal)
    button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
    button.tintColor = .white
    button.imageView?.snp.makeConstraints {
      $0.width.height.equalTo(22)
    }
    return button
  }()
  
  private let profileImageView : UIImageView = {
    let iv = UIImageView()
    iv.clipsToBounds = true
    iv.contentMode = .scaleAspectFill
    iv.layer.borderColor = UIColor.white.cgColor
    iv.layer.borderWidth = 4.0
    return iv
  }()
  
  private let fullnameLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textColor = .white
    label.textAlignment = .center
    label.text = "Eddie Brock"
    return label
  }()
  
  private let usernameLabel : UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .center
    label.text = "@venom"
    return label
  }()
  
  //MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemPink
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  func configureGradientLayer() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
    gradient.locations = [0, 1]
    layer.addSublayer(gradient)
    gradient.frame = bounds
  }
  
  func configureUI() {
    configureGradientLayer()
    let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
    stack.axis = .vertical
    stack.spacing = 4
    
    [profileImageView, stack, dismissButton].forEach {
      addSubview($0)
    }
    
    profileImageView.snp.makeConstraints {
      $0.width.height.equalTo(200)
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(96)
    }
    
    profileImageView.layer.cornerRadius = 200 / 2
    
    stack.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileImageView.snp.bottom).offset(16)
    }
    
    dismissButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(44)
      $0.leading.equalToSuperview().offset(12)
      $0.width.height.equalTo(48)
    }
  }
  
  func populateUserData() {
    guard let user = user else {return}
  
    fullnameLabel.text = user.fullname
    usernameLabel.text = "@" + user.username
    
    guard let url = URL(string: user.profileImageUrl) else {return}
    profileImageView.sd_setImage(with: url)
  }
  
  //MARK: - @objc func
  @objc func handleDismissal() {
    delegate?.dismissController()
  }
}
