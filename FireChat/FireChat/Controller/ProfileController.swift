//
//  ProfileController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/19.
//

import UIKit
import Firebase

protocol ProfileControllerDelegate : AnyObject {
  func handleLogout()
}

class ProfileController : UITableViewController {
  
  //MARK: - Properties
  
  weak var delegate : ProfileControllerDelegate?
  
  private var user : User? {
    didSet {
      headerView.user = user
    }
  }
  
  private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
  
  private let footerView = ProfileFooter()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    fetchUser()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
  }
  
  //MARK: - Functions
  private func configureUI() {
    tableView.backgroundColor = .white
    
    tableView.tableHeaderView = headerView
    headerView.delegate = self
    tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
    tableView.rowHeight = 64
    tableView.contentInsetAdjustmentBehavior = .never // 테이블뷰 헤더 위에 status bar 위까지 덮어쓰도록 하는 메소드
    tableView.backgroundColor = .systemGroupedBackground
    
    footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
    footerView.delegate = self
    tableView.tableFooterView = footerView
  }
  
  func fetchUser() {
    guard let uid = Auth.auth().currentUser?.uid else {return}
    Service.fetchUser(withUid: uid) { user in
      self.user = user
    }
  }
}

  //MARK: - UITableviewDataSource
extension ProfileController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ProfileViewModel.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
    cell.backgroundColor = .white
    cell.selectionStyle = .none
    let viewModel = ProfileViewModel(rawValue: indexPath.row)
    cell.viewModel = viewModel
    cell.accessoryType = .disclosureIndicator // row 옆에 '>' 버튼모양 자동으로 생성되도록 하는 제공되는 기능
    return cell
  }
}

 //MARK: - UITableviewDelegate
extension ProfileController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let viewModel = ProfileViewModel(rawValue: indexPath.row) else {return}
    
    switch viewModel {
    case .accountInfo: print("Debug : Go to account page")
    case .settings : print("Debug : Go to settings page")
  }
}
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
}

  //MARK: - ProfileHeaderDelegate
extension ProfileController : ProfileHeaderDelegate {
  func dismissController() {
    dismiss(animated: true, completion: nil)
  }
}

  //MARK: - ProfileFooterDelegate
extension ProfileController : ProfileFooterDelegate {
  func handleLogout() {
    let alert = UIAlertController(title: nil, message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
      self.dismiss(animated: true) {
        self.delegate?.handleLogout()
      }
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}
