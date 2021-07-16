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
    print("Debug : \(user.username)")
  }
  
  
  //MARK: - Functions
  private func configureUI() {
    collectionView.backgroundColor = .white
  }
}
