//
//  ViewModel.swift
//  BookxpertPractical
//
//  Created by Nisha on 13/04/25.
//

import Foundation
import CoreData
import FirebaseAuth

class ViewModel {
    
    func saveUserToCoreData(user: User) {
        let newUser = SignInUserDetails(context: CoreDataManager.shared.context)
        newUser.email = user.email
        newUser.name = user.displayName
        newUser.photoURL = user.photoURL?.absoluteString
        CoreDataManager.shared.saveContext()
    }
    
}
