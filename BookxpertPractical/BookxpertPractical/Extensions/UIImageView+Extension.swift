//
//  UIImageView.swift
//  BookxpertPractical
//
//  Created by Nisha on 13/04/25.
//


import UIKit

extension UIImageView{

func setImageFromURl(stringImageUrl url: String){

      if let url = NSURL(string: url) {
         if let data = NSData(contentsOf: url as URL) {
            self.image = UIImage(data: data as Data)
         }
      }
   }
}
