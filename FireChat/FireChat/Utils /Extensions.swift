//
//  Extensions.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/09.
//

import UIKit
import JGProgressHUD

extension UIViewController {
  
  static let hud = JGProgressHUD(style: .dark)
  
  func configureGradientLayer() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
    gradient.locations = [0 , 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }
  
  func showLoader(_ show : Bool, withText text : String? = "Loading") {
    view.endEditing(true)
    UIViewController.hud.textLabel.text = text
    
    if show {
      UIViewController.hud.show(in: view)
    } else {
      UIViewController.hud.dismiss()
    }
  }
  
  func configureNavigationBar(withTitle title : String, prefersLargeTitles : Bool) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white] // Message 글자의 textColor
    appearance.backgroundColor = .systemPurple
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    navigationItem.title = title
    navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
  }
}
