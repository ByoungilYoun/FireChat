//
//  ConversationCell.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/18.
//

import UIKit

class ConversationCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "ConversationCell"
  
  var conversation : Conversation? {
    didSet {
      configure()
    }
  }
  
  let profileImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  let timestampLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .darkGray
    label.text = "2h"
    return label
  }()
  
  let usernameLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .black
    return label
  }()
  
  let messageTextLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 14)
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
    backgroundColor = .white
    
    addSubview(profileImageView)
    profileImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(12)
      $0.width.height.equalTo(50)
      $0.centerY.equalToSuperview()
    }
    profileImageView.layer.cornerRadius = 50 / 2
    
    let stack = UIStackView(arrangedSubviews: [usernameLabel, messageTextLabel])
    stack.axis = .vertical
    stack.spacing = 4
    addSubview(stack)
    
    stack.snp.makeConstraints {
      $0.centerY.equalTo(profileImageView)
      $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
      $0.trailing.equalToSuperview().offset(-16)
    }
    
    addSubview(timestampLabel)
    timestampLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-12)
    }
  }
  
  func configure() {
    guard let conversation = conversation else {return}
    let viewModel = ConversationViewModel(conversation: conversation)
  
    usernameLabel.text = conversation.user.username
    messageTextLabel.text = conversation.message.text
    
    timestampLabel.text = viewModel.timestamp
    profileImageView.sd_setImage(with: viewModel.profileImageUrl)
  }
}
