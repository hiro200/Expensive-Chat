//
//  ChatData.swift
//  iOExChat
//
//  Created by 히로 on 2020/01/19.
//  Copyright © 2020 hiro. All rights reserved.
//

import Foundation
import ObjectMapper


class ChatData: Mappable {
    required init?(map: Map) {
        self.nickname = "a"
        self.msg = "a"
        self.link = "a"
    }
    
    
    var nickname: String
    var msg: String
    var link: String
    
    func mapping(map: Map) {
        nickname <- map["nick"]
        msg <- map["msg"]
        link <- map["link"]
    }
    
}


