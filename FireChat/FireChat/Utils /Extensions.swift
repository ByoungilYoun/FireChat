//
//  Extensions.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/09.
//

import UIKit

extension UIViewController {
  func configureGradientLayer() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
    gradient.locations = [0 , 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }
}
