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
    configureNavigationBar()
  }
  
  // 네비게이션 속성
  private func configureNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white] // Message 글자의 textColor
    appearance.backgroundColor = .systemPurple
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    navigationItem.title = "Messages"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    
    let image = UIImage(systemName: "person.circle.fill")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
  }
  
  //MARK: - Selectors
  @objc func showProfile() {
    print("1234")
  }
  
}
