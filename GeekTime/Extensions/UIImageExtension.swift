//
//  UIImageExtension.swift
//  GeekTime
//
//  Created by pkwans on 2022/2/26.
//

import Foundation
import UIKit

extension  UIImage  {
     /**
      *  重设图片大小
      */
     func  reSizeImage(reSize: CGSize )-> UIImage  {
         //UIGraphicsBeginImageContext(reSize);
         UIGraphicsBeginImageContextWithOptions (reSize, false , UIScreen .main.scale)
         self.draw(in:CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
         let  reSizeImage: UIImage  =  UIGraphicsGetImageFromCurrentImageContext()!
         UIGraphicsEndImageContext ();
         return  reSizeImage;
     }
     
     /**
      *  等比率缩放
      */
     func  scaleImage(scaleSize: CGFloat )-> UIImage  {
         let  reSize =  CGSize(width: self .size.width * scaleSize, height: self .size.height * scaleSize)
         return  reSizeImage(reSize: reSize)
     }
}
