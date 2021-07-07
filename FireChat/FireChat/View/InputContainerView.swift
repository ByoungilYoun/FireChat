//
//  InputContainerView.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/08.
//

import UIKit

class InputContainerView : UIView {

  init(image : UIImage? , textField : UITextField) {
    super.init(frame: .zero)
    
    self.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
    let iv = UIImageView()
    iv.image = image
    iv.tintColor = .white
    iv.alpha = 0.87
    
    addSubview(iv)
    iv.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(8)
      $0.width.equalTo(24)
      $0.height.equalTo(24)
    }
    
    addSubview(textField)
    textField.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(iv.snp.trailing).offset(8)
      $0.right.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    
    let dividerView = UIView()
    dividerView.backgroundColor = .white
    addSubview(dividerView)
    dividerView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(8)
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.height.equalTo(0.75)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
