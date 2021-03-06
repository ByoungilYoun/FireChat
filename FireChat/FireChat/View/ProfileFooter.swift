//
//  ProfileFooter.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/20.
//

import UIKit

protocol ProfileFooterDelegate : AnyObject {
  func handleLogout()
}

class ProfileFooter : UIView {
  
  //MARK: - Properties
  
  weak var delegate : ProfileFooterDelegate?
  
  private lazy var logoutButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Log out", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.backgroundColor = .systemPink
    button.layer.cornerRadius = 5
    button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
    return button
  }()
  
  //MARK: - init
  override init(frame : CGRect) {
    super.init(frame : frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    addSubview(logoutButton)
    
    logoutButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(32)
      make.trailing.equalToSuperview().offset(-32)
      make.centerY.equalToSuperview()
      make.height.equalTo(50)
    }
  }
  
  //MARK: - objc func
  @objc func handleLogout() {
    delegate?.handleLogout()
  }
}
