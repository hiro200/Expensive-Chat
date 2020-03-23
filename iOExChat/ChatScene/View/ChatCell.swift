//
//  ChatCell.swift
//  iOExChat
//
//  Created by 히로 on 2019/11/02.
//  Copyright © 2019 hiro. All rights reserved.
//

import Foundation
import UIKit


class ChatCell: UICollectionViewCell  {
    
    @IBOutlet weak var nickName: UILabel!
    
    
    
    @IBOutlet weak var message: UILabel!
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
           
           let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
           
        // 레이블의 가로의 한계치를 정해줌
          message.preferredMaxLayoutWidth = 300
         //레이블 코너 둥글게
          message.layer.cornerRadius = 10
        //레이블 뷰를 코너 둥글게 하는거에 인식하게
          message.layer.masksToBounds = true
        
         //  let targetSize = CGSize(width: 0, height: 0)
           
           let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
           
           let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)
           
           autoLayoutAttributes.frame = autoLayoutFrame
           
           return autoLayoutAttributes
       }
       
    
    
}
