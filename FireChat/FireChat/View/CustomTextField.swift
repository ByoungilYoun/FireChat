//
//  CustomTextField.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/08.
//

import UIKit

class CustomTextField : UITextField {
  
  //MARK: - init
  init(placeholder : String) {
    super.init(frame: .zero)
    
    borderStyle = .none
    font = UIFont.systemFont(ofSize: 16)
    textColor = .white
    keyboardAppearance = .dark
    attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor.white])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
