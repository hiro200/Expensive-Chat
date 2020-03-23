//
//  ViewController.swift
//  iOExChat
//
//  Created by 히로 on 2019/10/22.
//  Copyright © 2019 hiro. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON
import Alamofire
//import RxSwift
//import RxCocoa

protocol  ChatViewControllerProtocol {
    var viewModel : ChatViewModel {get set}
    
}


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextViewDelegate, ChatViewControllerProtocol {
   
    var viewModel = ChatViewModel()
    
    var pagingNum = 1
    
    
//    var disposeBag = DisposeBag()
 
    
    
    @IBOutlet weak var textInput: UITextView!
    @IBOutlet weak var sendBt: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
  
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // get 형식으로 받은 이미지 파일 주소 
        /*
         let url = "https://s3.ap-northeast-2.amazonaws.com/bucketplace-coding-test/cards/page_1.json"
        
        
        let jsonData = JSON(data)
        
        let imgUrl = URL(string: jsonData[0]["imge_url"].stringValue)
        */
     
    
        
        initChat()
        
      //  self.viewModel.Get_chatting()
        
        
        socket.connect()
     
        respondMessage()
    
        textInput.layer.cornerRadius = 15
        sendBt.layer.cornerRadius = 15
    
        
        
        // Do any additional setup after loading the view.
    
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                  
                    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                   
                    layout.estimatedItemSize = CGSize(width: 300, height: 60) // your average cell size
                 
                   //컬렉션 셀을 xib 오브젝트로 등록해주는 것
                    collectionView.register(UINib(nibName: "ChatCell", bundle: nil), forCellWithReuseIdentifier: "ChatCell")
                   
               }
        
        
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
             
        
        
        
    }


   
    
    func initChat() {
        
        // Simulate Aysnchronous data access
        // 메인스레드가 아닌 스레드 비동기
        /*
        DispatchQueue.global().async {
            completionHandler(self.items)
        }
        
         //이렇게 사용하면 효율적 백그라운드에서 돌아가니 시간 오래걸리는 다운같은거
         DispatchQueue.global(qos: .background).async {
                     //code
                  
        }
         
         
         //메인스레드로 비동기
         DispatchQueue.main.async {
             //code
         }

        
 
 */
        
        var temp:[String:Int] = ["page":pagingNum]
        //뷰컨트롤러에서 뷰모델의 함수나 변수를 가져와서 패턴을 구현하면 MVVM 패턴 구현
        
        Alamofire.request(Common.url_chat_output, method:  .post, parameters: temp, encoding: JSONEncoding.default, headers: nil).responseJSON {  response in

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

                
                //이런식으로 코드짜야 빈값이 넘어올때 오류를 피할수 있음
                    for i in stride(from: 0, to: swiftyJsonVar.count, by: 1)  {
                       // self.nicknameList.append(swiftyJsonVar[i]["names"].stringValue)
                       // self.msgList.append(swiftyJsonVar[i]["msg"].stringValue)
                        // 챗메세지 배열변수의 끝에다 메세지 추가
                   
                        let decrypString = Common.descrypt(string: swiftyJsonVar[i]["msg"].stringValue)
                        
                        self.viewModel.chatMessages.append(decrypString)
                    }
                    
                    print("MSG ===> \(swiftyJsonVar[0]["msg"].stringValue)")

                

                    self.collectionView.reloadData()
                
                
              case .failure(let error): break
                  // error handling
              }

        }

    
    }
   

    
    //---------------------------------------------
    override  func viewWillAppear(_ animated: Bool) {
        
     //   viewModel.initChat()
        
     //   self.collectionView.reloadData()
        
        super.viewWillAppear(animated)
       
        
    }
    
    override  func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        
    }
          
    
 //---------------------------------------------------------------------------------------------------------------------------------------------
    override  func viewWillDisappear(_ animated: Bool) {
           
           super.viewWillDisappear(animated)
           socket.disconnect()
           dismissKeyboard()
       }
    
    override  func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
              
    }
    
    
 //-------------------------------------------------------------------------
 //-------------------------------------------------------------------------
    
    /*
    func collectShow() {
        
        let items = Observable.just(
            (1...5).map { "\($0)" }
        )
        
        
        items.asObservable()
             .bind(to: collectionView.rx.items(cellIdentifier: "ChatCell", cellType: UICollectionViewCell.self)) { (row, element, cell) in
            cell.nickname?.text = element
        }
        .disposed(by: disposeBag)
    }
    */
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let cellHeight = 60 as CGFloat
        let cellPadding = 10 as CGFloat

        
        let index = Int(targetContentOffset.pointee.y /
                     view.frame.height)
        
        print("Index == \(index)")
        
        if index == 0 {
            pagingNum += 1
            initChat()
        }
        
//        var page = (scrollView.contentOffset.y - cellHeight / 2) / (cellHeight + cellPadding) + 1

//        if (velocity.y > 0) { page += 1 }
//        if (velocity.y < 0) { page -= 1 }
//
//        page = max(page,0)
//
//        if page > 3 {
//            pagingNum += 1
//            initChat()
//        }
//
//        print("PAGE == \(page)")
//        targetContentOffset.pointee.y = page * (cellHeight + cellPadding)
    }
    
    
    
    
    
    
      // 보여지는 셀의 갯수
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
        //    return ChatModel.chatMessages.count
        
        return viewModel.chatMessages.count
        
       }
       
    /*
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               guard let data = data else { return UITableViewCell() }
               let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
               cell.textLabel?.text = data[indexPath.row].name
               return cell
           }
    */
    
    
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
       
        
        //셀의 id 를 넣어주고 재사용할 셀을 설정해줌
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCell", for: indexPath) as! ChatCell
                  
        
            
                // 인덱스 줄을 이용하여 내용을 넣어줌
               //   let currentChatMessage = chatMessages[indexPath.row]
                 
                
                //  cell.comment.text = currentChatMessage
               //   cell.comment.preferredMaxLayoutWidth = 70
               //   cell.comment.frame = cell.contentView.frame
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////// 임시로 확인해보는 소스//////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
      //  cell.nickName.text = jsonData[indexPath.row].
        
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
         ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////// 이부분이 원래 사용하던 소스 ////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                   // let currentChatMessage = "Hooah"
                  //  cell.nickName.text = viewModel.nickname[indexPath.row]
             
        cell.message.text = viewModel.chatMessages[indexPath.row]
              
        
              //    print("SizeWidth == \(cell.nickName.frame.width)")
              //    print("SizeHeight == \(cell.nickName.frame.height)")
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////// 이부분이 원래 사용하던 소스 ////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  
                  
              return  cell
       }

    
    //---------------------------------------------------------------------------------------------------------------------------------------------
       @IBAction func buttonInputSend(_ sender: Any) {
           
           if (textInput.text.count != 0) {
               socket.on(clientEvent: .connect) {data, ack in
                   print("socket connected")
               }
               
                  
               actionSendMessage(textInput.text)
               dismissKeyboard()
               textInput.text = nil
               
            
           }
       }
    
    
    
    
        func actionSendMessage(_ text: String) {
           
            let json = ["id":"os","name":"Hyun","messsage":text,"link":"hacat"]
            socket.emit("clientMessage", json)
           
             
       }
       
    
    
    
       func respondMessage() {
           
               socket.on("serverMessage") { data, ack in
           
                
                let temp:[String: Any] = data[0] as! Dictionary
                let json: JSON = JSON(temp)
              
                let model = ChatModel()
               
                model.msg = json["message"].stringValue
                // 챗메세지 배열변수의 끝에다 메세지 추가
                //   self.viewModel.chatMessages.append(ChatModel.msg)
               // 챗메세지 배열변수의 앞에다가 메세지 추가
                self.viewModel.chatMessages.insert(model.msg!, at: 0)
                
                
               
                print("Temp Info \(temp)")
                print("Msg Info \(json["message"].stringValue)")
               print("Data Info \(data)")
                
               self.collectionView.reloadData()
                
           }
           
       }
     
    
    // MARK: - Keyboard methods
       //---------------------------------------------------------------------------------------------------------------------------------------------
       @objc func keyboardShow(_ notification: Notification?) {
           
           if let info = notification?.userInfo {
               if (info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) != nil {
                   let duration = TimeInterval(info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)
                   UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
                  //     self.view.center = CGPoint(x: self.view.center.x ,  y: self.view.center.y - keyboard.size.height + self.view.safeAreaInsets.bottom)
                   })
               }
           }
           UIMenuController.shared.menuItems = nil
       }
       
       
       
       
       //---------------------------------------------------------------------------------------------------------------------------------------------
       @objc func keyboardHide(_ notification: Notification?) {
           
           if let info = notification?.userInfo {
               let duration = TimeInterval(info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)
               UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
               //    self.view.center = CGPoint(x: self.view.center.x ,  y: self.view.center.y )
               })
           }
       }
       
       
       
       //---------------------------------------------------------------------------------------------------------------------------------------------
       func dismissKeyboard() {
           
           view.endEditing(true)
       }
    
    
    /*
       @objc func send() {
            self.textView?.text = nil
            if let constraint: NSLayoutConstraint = self.constraint {
                self.textView?.removeConstraint(constraint)
            }
            self.toolbar.setNeedsLayout()
        }
       */
}

