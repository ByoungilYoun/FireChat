//
//  ConversationViewModel.swift
//  FireChat
//
//  Created by 윤병일 on 2021/07/18.
//

import Foundation

struct ConversationViewModel {
  
  private let conversation : Conversation
  
  var profileImageUrl : URL? {
    return URL(string: conversation.user.profileImageUrl)
  }
  
  var timestamp : String {
    let date = conversation.message.timeStamp.dateValue()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
    return dateFormatter.string(from: date)
  }
  
  init(conversation : Conversation) {
    self.conversation = conversation
  }
}
