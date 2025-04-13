//
//  HomeViewController.swift
//  BookxpertPractical
//
//  Created by Nisha on 13/04/25.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if let currentUser = Auth.auth().currentUser {
            self.nameLbl.text = currentUser.displayName
            self.emailLbl.text = currentUser.email
            self.userImage.setImageFromURl(stringImageUrl: currentUser.photoURL?.absoluteString ?? "")
        }
    }
    
    @IBAction func tappedOnLogoutBtn(_ sender: Any) {
        do {
            GIDSignIn.sharedInstance.signOut()
            try Auth.auth().signOut()
            navigateToViewController()
        } catch let signOutError as NSError {
            showToast(message: "Error signing out")
            print("Error signing out: %@", signOutError)
        }
    }
    
    func navigateToViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController")
        
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows.first {
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: nil,
                              completion: nil)
        }
    }
    
}
