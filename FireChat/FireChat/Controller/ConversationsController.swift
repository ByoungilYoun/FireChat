//
//  ConversationsController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/06.
//

import UIKit
import Firebase

class ConversationsController : UIViewController {
  
  //MARK: - Properties
  private let tableView = UITableView()
  
  private let newMessageButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.backgroundColor = .systemPurple
    button.tintColor = .white
    button.imageView?.snp.makeConstraints {
      $0.height.equalTo(24)
      $0.width.equalTo(24)
    }
    button.addTarget(self, action: #selector(shopNewMessage), for: .touchUpInside)
    return button
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configurUI()
  }
  
  //MARK: - Functions
  private func configurUI() {
    view.backgroundColor = .white
    authenticateUser()
    configureNavigationBar()
    configureTableView()
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
  
  private func configureTableView() {
    tableView.backgroundColor = .white
    tableView.rowHeight = 80
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    tableView.frame = view.frame
    
    view.addSubview(newMessageButton)
    newMessageButton.snp.makeConstraints {
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
      $0.trailing.equalToSuperview().offset(-24)
      $0.height.equalTo(56)
      $0.width.equalTo(56)
    }
    newMessageButton.layer.cornerRadius = 56 / 2
  }
  
  func presentLoginScreen() {
    DispatchQueue.main.async {
      let controller = LoginController()
      let nav = UINavigationController(rootViewController: controller)
      nav.modalPresentationStyle = .fullScreen
      self.present(nav, animated: true, completion: nil)
    }
  }
  //MARK: - API
  
  func authenticateUser() {
    if Auth.auth().currentUser?.uid == nil {
      presentLoginScreen()
    } else {
      print("Debug : User id is \(String(describing: Auth.auth().currentUser?.uid))")
    }
  }
  
  func logout() {
    do {
      try Auth.auth().signOut()
      presentLoginScreen()
    } catch {
      print("Debug : Error signing out...")
    }
  }
  
  //MARK: - Selectors
  @objc func showProfile() {
    logout()
  }
  
  @objc func shopNewMessage(){
    let controller = NewMessageController()
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .fullScreen
    present(nav, animated: true, completion: nil)
  }
}

  //MARK: - UITableViewDataSource
extension ConversationsController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .white
    cell.textLabel?.text = "Test Cell"
    cell.textLabel?.textColor = .black
    return cell
  }
}

  //MARK: - UITableViewDelegate
extension ConversationsController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
  }
}
