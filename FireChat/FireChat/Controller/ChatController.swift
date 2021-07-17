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
    return cell
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension ChatController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 16, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.size.width, height: 50)
  }
}

extension ChatController : CustomInputAccessoryViewDelegate {
  func inputView(_ inputView: CustomInputAccessoryView, wantsToSendMessage message: String) {
    inputView.messageInputTextView.text = nil
    
    fromCurrentUser.toggle()
    let message = Message(text: message, isFromCurrentUser: fromCurrentUser)
    messages.append(message)
    collectionView.reloadData()
  }
}
