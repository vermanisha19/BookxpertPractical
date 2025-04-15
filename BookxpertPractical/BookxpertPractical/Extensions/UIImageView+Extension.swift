//
//  UIImageView.swift
//  BookxpertPractical
//
//  Created by Nisha on 13/04/25.
//


import UIKit
import Alamofire

extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
        AF.request(url).responseData { response in
            if let data = response.value {
                self.image = UIImage(data: data)
            }
        }
    }
}
