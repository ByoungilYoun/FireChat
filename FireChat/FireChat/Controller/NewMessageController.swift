//
//  NewMessageController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/14.
//

import UIKit

class NewMessageController : UITableViewController {
  
  //MARK: - Properties
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .systemPink
  }
}
