//
//  UiStoryboards+Extension.swift
//  BookxpertPractical
//
//  Created by MACM13 on 14/04/25.
//


import UIKit

extension UIStoryboard {
    
    static var main: UIStoryboard = {
        let storyboard = UIStoryboard.storyboard(name: "Main")
        return storyboard
    }()
    
    class func storyboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
    
    public func get<T:UIViewController>(_ identifier: T.Type) -> T? {
        let storyboardID = String(describing: identifier)
        
        guard let viewController = instantiateViewController(withIdentifier: storyboardID) as? T else {
            return nil
        }
        
        return viewController
    }
}
