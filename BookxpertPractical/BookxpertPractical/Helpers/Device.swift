//
//  Device.swift
//  BookxpertPractical
//
//  Created by Nisha on 13/04/25.
//

import UIKit

class Device {
    
    static var window: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows.first
    }
    
}
