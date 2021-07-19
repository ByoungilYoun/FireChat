//
//  ProfileCell.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/20.
//

import UIKit

class ProfileCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "ProfileCell"
  
  var viewModel : ProfileViewModel? {
    didSet {
      configure()
    }
  }
  
  private lazy var iconView : UIView = {
    let view = UIView()
    
    view.addSubview(iconImage)
    iconImage.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
    view.backgroundColor = .systemPurple
    view.snp.makeConstraints {
      $0.height.width.equalTo(40)
    }
    view.layer.cornerRadius = 40 / 2
    return view
  }()
  
  private let iconImage : UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    view.snp.makeConstraints {
      $0.width.height.equalTo(28)
    }
    view.tintColor = .white
    return view
  }()
  
  private let titleLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .black
    return label
  }()
  
  //MARK: - init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Function
  private func configureUI() {
    let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
    stack.spacing = 8
    stack.axis = .horizontal
    addSubview(stack)
    
    stack.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(12)
    }
  }
  
  func configure() {
    guard let viewModel = viewModel else {return}
    
    iconImage.image = UIImage(systemName: viewModel.iconImageName)
    titleLabel.text = viewModel.description
  }
}
