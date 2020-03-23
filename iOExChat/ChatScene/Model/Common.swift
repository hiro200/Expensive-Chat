//
//  Common.swift
//  iOExChat
//
//  Created by 히로 on 2019/11/01.
//  Copyright © 2019 hiro. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RxAlamofire
import RxSwift
import ObjectMapper
import CryptoSwift

class Common {
 //   static public var spendMoney:String = ""
 //   static public var TotalMoney:String = ""
    static public var Response = [String]()
    
    
   
    
    static func encrypt(string: String) -> String {
           
        let result:String = try! string.encryptToBase64(cipher: AES(key:KEY_256, iv:KEY_128))!
           
           return result
       }
       
   
   static func descrypt(string:String) -> String {
       
       let result:String = try! string.decryptBase64ToString(cipher: AES(key:KEY_256, iv:KEY_128))
       
       return result
       
   }
      

    
//    private let endPoint: String
//    private let scheduler: ConcurrentDispatchQueueScheduler
//
//
//    init(_ endPoint: String) {
//        self.endPoint = endPoint
//        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
//    }
//
//
//    func getRequest(_ path: String) -> Observable<T> {
//        let absolutePath = "\(endPoint)/\(path)"
//        let urlValidString = absolutePath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
//        print(urlValidString ?? "urlValidString = nil ! ")
//        return RxAlamofire
//            .json(.get, urlValidString!)
//            .debug()
//            .observeOn(scheduler)
//            .map({ json -> T in
//                let jsonData: [String : Any] = json as! [String : Any] // swiftlint:disable:this force_cast
//                return try Mapper<T>().map(JSON: jsonData)
//            })
//    }
//
//
//    func postRequest(_ path: String, parameters: [String: Any]) -> Observable<T> {
//        let absolutePath = "\(endPoint)/\(path)"
//        return RxAlamofire
//            .request(.post, absolutePath, parameters: parameters)
//            .debug()
//            .observeOn(scheduler)
//            .map({ json -> T in
//                return try Mapper<T>().map(JSONObject: json)
//            })
//    }
//
    
    
    
//    static public func AsynHttp(URL: String) -> Any? {
//
//        var Response:Any?
//        Alamofire.request(URL, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
//
//            switch response.result {
//                case .success:
//                    Response = response.data
//                    print(response.result)
//                case .failure(let error):
//                    print(error)
//            }
//
//        }
//
//        return Response
//    }
//
    
//    static public func AsynHttp(URL: String,  parameter:  [String:Any], handler: @escaping (NSDictionary) -> Void)  {
        
    
   
    
    
}
