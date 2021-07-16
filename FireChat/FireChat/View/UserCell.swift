//
//  UserCell.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/14.
//

import UIKit
import SDWebImage

class UserCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "UserCell"
  
  var user : User? {
    didSet {
      configure()
    }
  }
  
  
  private let profileImageView : UIImageView = {
    let view = UIImageView()
    view.backgroundColor = .systemPurple
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    return view
  }()
  
  private let usernameLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .black
    label.text = "Spiderman"
    return label
  }()
  
  private let fullnameLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .lightGray
    label.textColor = .black
    label.text = "Peter Parker"
    return label
  }()
  //MARK: - init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    contentView.backgroundColor = .white
    
    let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
    stack.axis = .vertical
    stack.spacing = 2
    
    [profileImageView, stack].forEach {
      contentView.addSubview($0)
    }
    
    profileImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.height.width.equalTo(56)
      $0.leading.equalToSuperview().offset(12)
    }
    profileImageView.layer.cornerRadius = 56 / 2
    
    stack.snp.makeConstraints {
      $0.centerY.equalTo(profileImageView)
      $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
    }
  }
  
  func configure() {
    guard let user = user else {return}
    
    fullnameLabel.text = user.fullname
    usernameLabel.text = user.username
    
    guard let url = URL(string: user.profileImageUrl) else {return}
    profileImageView.sd_setImage(with: url)
  }
}
