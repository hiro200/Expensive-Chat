//
//  ChatViewModel.swift
//  iOExChat
//
//  Created by 히로 on 2019/11/01.
//  Copyright © 2019 hiro. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



protocol ChatViewProtocol {
    
    
    
    var nickname : [String] {get}
    var chatMessages: [String] {get}
    var link: String {get}
    
    func Get_chatting()
    
    /*
    func Get_Total_Star()
    func Get_Spend_Star()
    
    func socketConnect()
    func socketDisconnect()
    */
    
    
}





public class ChatViewModel:ChatViewProtocol
{
    
    
    
    let url_chat_output =  "http://ec2-13-124-252-91.ap-northeast-2.compute.amazonaws.com/chat_output.php"
    
    var nickname: [String] = []
    var chatMessages: [String] = []
    var link:String  = ""
    
    
    
    func Get_chatting() {
        
         Alamofire.request(Common.url_chat_output, method:  .post, parameters: ["page":0], encoding: JSONEncoding.default, headers: nil).responseJSON {  response in

                   switch response.result {
                     case .success(let value):
                       let swiftyJsonVar = JSON(value)
                         //  var eachCellObject = swiftyJsonVar["data"] //data 라는 키값이 있는경우
                           // JSON 포맷의 서버 데이터를 eachCellObject라는 변수로 한번에 저장합니다.
                            
                           /* 예제 어떻게 사용하는제 소스
                           // 10개의 데이터를 불러오기 위해, 첫번째부터 앞서 선언한 어레이 데이터를 저장합니다.
                           for i in 0 ... 9 {
                               let imageURL:String? = eachCellObject[i]["imageURL"].string
                               self.profileURL.append(imageURL:String!)
                                   self.nameList.append(eachCellObject[i]["name"].string!)
                           }
                           */

                       
                           print("Response ===> \(value)")

                       
                           for i in 0...(swiftyJsonVar.count-1) {
                              // self.nicknameList.append(swiftyJsonVar[i]["names"].stringValue)
                              // self.msgList.append(swiftyJsonVar[i]["msg"].stringValue)
                               // 챗메세지 배열변수의 끝에다 메세지 추가
                            self.chatMessages.append(swiftyJsonVar[i]["msg"].stringValue)
                           }
                           
                           print("MSG ===> \(swiftyJsonVar[0]["msg"].stringValue)")

                       
                        let view = ViewController()
                       view.collectionView!.reloadData()
                       
                       
                     case .failure(let error): break
                         // error handling
                     }

            }

    
    /*
     func AsynHttp(URL: String,  parameter:  [String:Any], completionHandler : @escaping ( JSON ) -> Void)  {
            
            
          //  var Response : JSON = []
                
            Alamofire.request(URL, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
               
                switch response.result {
                case .success(let value):
                    
                  print("Response ===> \(JSON(value))")
                  
                guard let nsDic = value as? NSDictionary else {return}
                 
                  let json = JSON(value)
                  
                  completionHandler(json)
                    
                    
                
               // var jsonData = (value as? [String: Any])!
               // let jsonData = JSON(value)
                
                
              //  Response = jsonData.arrayObject as! [String]
                
    //            if let JSON = value as? [String: Any] {
    //
    //
    //            }
                   
                    
                case .failure(let error): break
                    // error handling
                    print(error.localizedDescription)
                }
                
                
                
            }
            
            */
            
    }
    
}
            




