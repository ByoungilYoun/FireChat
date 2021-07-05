//
//  ConversationsController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/06.
//

import UIKit

class ConversationsController : UIViewController {
  
  //MARK: - Properties
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configurUI()
  }
  
  //MARK: - Functions
  private func configurUI() {
    view.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Messages"
    
    let image = UIImage(systemName: "person.circle.fill")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
  }
  
  //MARK: - Selectors
  @objc func showProfile() {
    print("1234")
  }
  
}
