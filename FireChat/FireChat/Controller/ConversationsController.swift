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
  
  private var conversations = [Conversation]()
  
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
    fetchConverations()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
  }
  
  //MARK: - Functions
  private func configurUI() {
    view.backgroundColor = .white
    authenticateUser()
    configureTableView()
  }
  
  private func configureTableView() {
    let image = UIImage(systemName: "person.circle.fill")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
    
    tableView.backgroundColor = .white
    tableView.rowHeight = 80
    tableView.register(ConversationCell.self, forCellReuseIdentifier: ConversationCell.identifier)
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
  
  func showChatController(forUser user : User) {
    let controller = ChatController(user: user)
    navigationController?.pushViewController(controller, animated: true)
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
  
  func fetchConverations() {
    Service.fetchConversations { conversations in
      self.conversations = conversations
      self.tableView.reloadData()
    }
  }
  
  //MARK: - Selectors
  @objc func showProfile() {
    let controller = ProfileController(style: .insetGrouped)
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .fullScreen
    present(nav, animated: true, completion: nil)
  }
  
  @objc func shopNewMessage(){
    let controller = NewMessageController()
    controller.delegate = self
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .fullScreen
    present(nav, animated: true, completion: nil)
  }
}

  //MARK: - UITableViewDataSource
extension ConversationsController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return conversations.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.identifier, for: indexPath) as! ConversationCell
    cell.selectionStyle = .none
    cell.conversation = conversations[indexPath.row]
    return cell
  }
}

  //MARK: - UITableViewDelegate
extension ConversationsController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = conversations[indexPath.row].user
    showChatController(forUser: user)
  }
}

  //MARK: - NewMessageControllerDelegate
extension ConversationsController : NewMessageControllerDelegate {
  func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
    controller.dismiss(animated: true, completion: nil)
    showChatController(forUser: user)
  }
}
