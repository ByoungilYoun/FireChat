//
//  LoginViewModel.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/10.
//

import Foundation

struct LoginViewModel {
  var email : String?
  var password : String?
  
  var formIsValid : Bool {
    return email?.isEmpty == false  && password?.isEmpty == false
  }
}
