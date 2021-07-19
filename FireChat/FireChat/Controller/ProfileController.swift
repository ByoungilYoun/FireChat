//
//  ProfileController.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/19.
//

import UIKit

class ProfileController : UITableViewController {
  
  //MARK: - Properties
  
  private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
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
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.tableFooterView = UIView()
    tableView.contentInsetAdjustmentBehavior = .never // 테이블뷰 헤더 위에 status bar 위까지 덮어쓰도록 하는 메소드
  }
  
  //MARK: - @objc func
}

extension ProfileController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }
}

