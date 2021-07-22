//
//  ChatController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/16.
//

import UIKit

class ChatController : UICollectionViewController {
  
  //MARK: - Properties
  private let user : User
  private var messages = [Message]()
  var fromCurrentUser = false
  
  private lazy var customInputView : CustomInputAccessoryView = {
    let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
    iv.delegate = self
    return iv
  }()
  
  //MARK: - Lifecycle
  init(user: User) {
    self.user = user
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    super.init(collectionViewLayout: layout)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    fetchMessages()
  }
  
  override var inputAccessoryView: UIView? {
    get {
      return customInputView
    }
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    collectionView.backgroundColor = .white
    configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
    collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.identifier)
    collectionView.alwaysBounceVertical = true
    collectionView.keyboardDismissMode = .interactive // 아래로 스크롤 하면 키보드가 내려간다. 상호작용
  }
  
  func fetchMessages() {
    showLoader(true)
    Service.fetchMessages(forUser: user) { messages in
      self.showLoader(false)
      self.messages = messages
      self.collectionView.reloadData()
      
      self.collectionView.scrollToItem(at: [0,self.messages.count - 1], at: .bottom, animated: true)
    }
  }
}

  //MARK: - UICollectionViewDataSource
extension ChatController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
    cell.message = messages[indexPath.row]
    cell.message?.user = user
    return cell
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension ChatController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 16, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50) //dummy height 를 준다.
    let estimatedSizeCell = MessageCell(frame: frame)
    
    estimatedSizeCell.message = messages[indexPath.row]
    estimatedSizeCell.layoutIfNeeded()
    
    let targetSize = CGSize(width: view.frame.width, height: 1000)
    let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
    
    return .init(width: view.frame.width, height: estimatedSize.height)
  }
}

extension ChatController : CustomInputAccessoryViewDelegate {
  func inputView(_ inputView: CustomInputAccessoryView, wantsToSendMessage message: String) {
    Service.uploadMessage(message, to: user) { error in
      if let error = error {
        print("Debug : Failed to upload message with error : \(error.localizedDescription)")
        return
      }
      inputView.clearMessageText()
    }
  }
}
