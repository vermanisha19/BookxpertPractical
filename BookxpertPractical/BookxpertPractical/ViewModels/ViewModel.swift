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
    
    func saveUserDetails(user: User) {
        if let userEmail = user.email {
            let context = CoreDataManager.shared.context
            
            let fetchRequest = SignInUserDetails.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", userEmail)
            
            let userData: SignInUserDetails
            if let existingUser = try? context.fetch(fetchRequest).first {
                userData = existingUser
            } else {
                userData = SignInUserDetails(context: context)
                userData.email = user.email
            }
            
            userData.name = user.displayName
            userData.photoURL = user.photoURL?.absoluteString
            
            CoreDataManager.shared.saveContext()
        }
    }

}
