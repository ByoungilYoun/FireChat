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
  
  private lazy var customInputView : CustomInputAccessoryView = {
    let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
    return iv
  }()
  
  //MARK: - Lifecycle
  init(user: User) {
    self.user = user
    super.init(collectionViewLayout: UICollectionViewLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
  //MARK: - Functions
  private func configureUI() {
    collectionView.backgroundColor = .white
    configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
  }
}
