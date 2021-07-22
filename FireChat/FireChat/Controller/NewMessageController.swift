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
  
  private let searchController = UISearchController(searchResultsController: nil)
  
  private var filteredUsers = [User]()
  
  private var inSearchMode : Bool {
    return searchController.isActive && !searchController.searchBar.text!.isEmpty
  }
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    fetchUsers()
    configureSearchController()
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
    showLoader(true)
    Service.fetchUsers { users in
      self.showLoader(false)
      self.users = users
      self.tableView.reloadData()
    }
  }
  
  func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.searchBar.showsCancelButton = false
    navigationItem.searchController = searchController
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Search for a user"
    definesPresentationContext = false
    
    if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
      textField.textColor = .systemPurple
      textField.backgroundColor = .white
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
    return inSearchMode ? filteredUsers.count : users.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
    cell.user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
    return cell
  }
}

  //MARK: - UITableViewDelegate
extension NewMessageController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
    delegate?.controller(self, wantsToStartChatWith: user)
  }
}

  //MARK: - UISearchResultsUpdating
extension NewMessageController : UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text?.lowercased() else {return}
    
    filteredUsers = users.filter({ user -> Bool in
      return user.username.contains(searchText) || user.fullname.contains(searchText)
    })
    self.tableView.reloadData()
  }
}
