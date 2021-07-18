//
//  CustomInputAccessoryView.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/17.
//

import UIKit

protocol CustomInputAccessoryViewDelegate : AnyObject {
  func inputView(_ inputView : CustomInputAccessoryView, wantsToSendMessage message : String)
}

class CustomInputAccessoryView : UIView {
  
  //MARK: - Properties
  
  weak var delegate : CustomInputAccessoryViewDelegate?
  
  private lazy var messageInputTextView : UITextView = {
    let tv = UITextView()
    tv.font = UIFont.systemFont(ofSize: 16)
    tv.isScrollEnabled = false
    tv.backgroundColor = .clear
    tv.textColor = .black
    return tv
  }()

  private lazy var sendButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Send", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.setTitleColor(.systemPurple, for: .normal)
    button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
    return button
  }()
  
  private let placeholderLabel : UILabel = {
    let label = UILabel()
    label.text = "Enter Message"
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .lightGray
    return label
  }()
  
  
  //MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return .zero
  }
  
  //MARK: - Functions
  
  private func configureUI() {
    autoresizingMask = .flexibleHeight
    backgroundColor = .white
    
    layer.shadowOpacity = 0.25
    layer.shadowRadius = 10
    layer.shadowOffset = .init(width: 0, height: -8)
    layer.shadowColor = UIColor.lightGray.cgColor
    
    [sendButton, messageInputTextView, placeholderLabel].forEach {
      addSubview($0)
    }
    
    sendButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(4)
      $0.right.equalToSuperview().offset(-8)
      $0.width.height.equalTo(50)
    }
    
    messageInputTextView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(12)
      $0.left.equalToSuperview().offset(4)
      $0.right.equalTo(sendButton.snp.left).offset(-8)
      $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-8)
    }
    
    placeholderLabel.snp.makeConstraints {
      $0.left.equalTo(messageInputTextView.snp.left).offset(4)
      $0.centerY.equalTo(messageInputTextView)
    }
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
  }
  
  func clearMessageText() {
    messageInputTextView.text = nil
    placeholderLabel.isHidden = false
  }
  //MARK: - objc func
  @objc func handleSendMessage() {
    guard let message = messageInputTextView.text else {return}
    delegate?.inputView(self, wantsToSendMessage: message)
  }
  
  @objc func handleTextInputChange(){
    placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
  }
}
