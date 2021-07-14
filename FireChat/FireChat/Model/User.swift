//
//  User.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/15.
//

import Foundation

struct User {
  let uid : String
  let profileImageUrl : String
  let username : String
  let fullname : String
  let email : String
  
  init(dictionary : [String : Any]) {
    self.uid = dictionary["uid"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    self.username = dictionary["username"] as? String ?? ""
    self.fullname = dictionary["fullname"] as? String ?? ""
    self.email = dictionary["email"] as? String ?? ""
  }
}
