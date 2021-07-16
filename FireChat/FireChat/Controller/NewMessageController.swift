//
//  NewMessageController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/14.
//

import UIKit

protocol NewMessageControllerDelegate : AnyObject {
  func controller(_ controller : NewMessageController , wantsToStartChatWith user : User)
}

class NewMessageController : UITableViewController {
  
  //MARK: - Properties
  
  private var users = [User]()
  
  weak var delegate : NewMessageControllerDelegate?
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    fetchUsers()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
    
    tableView.tableFooterView = UIView()
    tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
    tableView.rowHeight = 80
  }
  
  func fetchUsers() {
    Service.fetchUsers { users in
      self.users = users
      self.tableView.reloadData()
    }
  }
  
  //MARK: - @objc func
  @objc func handleDismissal() {
    dismiss(animated: true, completion: nil)
  }
}

  //MARK: - UITableViewDataSource
extension NewMessageController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
    cell.user = users[indexPath.row]
    return cell
  }
}

  //MARK: - UITableViewDelegate
extension NewMessageController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.controller(self, wantsToStartChatWith: users[indexPath.row])
  }
}
