//
//  Service.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/15.
//

import Foundation
import Firebase

struct Service {
  static func fetchUsers(completion : @escaping ([User]) -> Void) {
    var users = [User]()
    Firestore.firestore().collection("users").getDocuments { snapshot, error in
      snapshot?.documents.forEach({ document in
        let dictionary = document.data()
        let user = User(dictionary: dictionary)
        users.append(user)
        completion(users)
      })
    }
  }
}
