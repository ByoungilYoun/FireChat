//
//  MessageCell.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/18.
//

import UIKit

class MessageCell : UICollectionViewCell {
  
  //MARK: - Properties
  static let identifier = "MessageCell"
  
  var message : Message? {
    didSet {
      configure()
    }
  }
  
  var bubbleLeftAnchor : NSLayoutConstraint!
  var bubbleRightAnchor : NSLayoutConstraint!
  
  private let profileImageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  private let textView : UITextView = {
    let tv = UITextView()
    tv.backgroundColor = .clear
    tv.font = .systemFont(ofSize: 16)
    tv.isScrollEnabled = false
    tv.textColor = .white
    tv.isEditable = false
    return tv
  }()
  
  private let bubbleContainer : UIView = {
    let view = UIView()
    view.backgroundColor = .systemPurple
    return view
  }()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    backgroundColor = .clear
    [profileImageView, bubbleContainer].forEach {
      contentView.addSubview($0)
    }
    
    profileImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(8)
      $0.bottom.equalToSuperview().offset(4)
      $0.width.height.equalTo(32)
    }
    profileImageView.layer.cornerRadius = 32 / 2
    
    bubbleContainer.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.width.lessThanOrEqualTo(250)
    }
    
    bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
    bubbleLeftAnchor.isActive = false
    bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12)
    bubbleRightAnchor.isActive = false
    
    bubbleContainer.layer.cornerRadius = 12
    
    bubbleContainer.addSubview(textView)
    textView.snp.makeConstraints {
      $0.top.equalTo(bubbleContainer.snp.top).offset(4)
      $0.leading.equalTo(bubbleContainer.snp.leading).offset(12)
      $0.trailing.equalTo(bubbleContainer.snp.trailing).offset(-12)
      $0.bottom.equalTo(bubbleContainer.snp.bottom).offset(-4)
    }
  }
  
  func configure() {
    guard let message = message else {return}
    let viewModel = MessageViewModel(message: message)
    bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
    textView.textColor = viewModel.messageTextColor
    textView.text = message.text
    
    bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
    bubbleRightAnchor.isActive = viewModel.rightAnchorActive
    
    profileImageView.isHidden = viewModel.shouldHideProfileImage
    profileImageView.sd_setImage(with: viewModel.profileImageUrl)
  }
}
