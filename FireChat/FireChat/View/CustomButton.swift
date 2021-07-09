//
//  CustomButton.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/09.
//

import UIKit

class CustomButton : UIButton {
  
  init(title : String) {
    super.init(frame: .zero)
    
    setTitle(title, for: .normal)
    layer.cornerRadius = 5
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    setTitleColor(.white, for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

