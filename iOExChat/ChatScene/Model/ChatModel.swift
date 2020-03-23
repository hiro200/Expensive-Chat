//
//  ChatModel.swift
//  iOExChat
//
//  Created by 히로 on 2019/11/05.
//  Copyright © 2019 hiro. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import SocketIO


let manager = SocketManager(socketURL: URL(string: "https://www.thehooah.net")!, config: [.log(true), .compress])
let socket = manager.defaultSocket

/*
 //Json 샘플
 {
 "contents" : [
        {
            "nick" : "zedd",
            "msg" : "hellow"
            "link" : "youtube"
        },
        {
                   "nick" : "alan",
                   "msg" : "hellow"
                   "link" : "youtube"
         }
    ]
 }
 
 
class Contents: Decodable {

    var contents: [ChatModel]

}

 
class ChatModel: Codable {
    var names:String?
    var msg:String?
    var link:String?
}
*/




class ChatModel: Decodable {
    
  //  static var chatMessages: [String] = []
    var nick:String?
    var msg:String?
    var link:String?
    
    /*
    init(nick: String, msg: String, link: String) {
        self.nick = nick
        self.msg = msg
        self.link = link
    }
     */
}

