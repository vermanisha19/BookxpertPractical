//
//  ViewController.swift
//  BookxpertPractical
//
//  Created by Nisha on 13/04/25.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet private weak var signInButton: GIDSignInButton!
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func signInWithGoogle(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard let self else { return }
            if let error {
                self.showToast(message: error.localizedDescription)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                self.showToast(message: "Something went wrong")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error {
                    self.showToast(message: error.localizedDescription)
                    return
                }
                
                if let user = authResult?.user {
                    print("Firebase Sign-In success: \(user.displayName ?? "")")
                    self.navigateToHome()
                    self.showToast(message: "Successfully Signed In")
                    self.viewModel.saveUserDetails(user: user)
                }
            }
        }
    }
    
    private func navigateToHome() {
        guard let homeVC = UIStoryboard.main.get(HomeViewController.self) else { return }
        let navVC = UINavigationController(rootViewController: homeVC)
        
        if let window = Device.window {
            window.rootViewController = navVC
            window.makeKeyAndVisible()
            
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromRight,
                              animations: nil,
                              completion: nil)
        }
    }
}
