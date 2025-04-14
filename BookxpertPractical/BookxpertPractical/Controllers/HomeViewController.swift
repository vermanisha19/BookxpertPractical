//
//  HomeViewController.swift
//  BookxpertPractical
//
//  Created by Nisha on 13/04/25.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import PDFKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var emailLbl: UILabel!
    
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
    
    @IBAction private func tappedOnLogoutBtn(_ sender: Any) {
        do {
            GIDSignIn.sharedInstance.signOut()
            try Auth.auth().signOut()
            navigateToViewController()
        } catch let signOutError as NSError {
            showToast(message: "Error signing out")
            print("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction private func openPDFVIew(_ sender: UIButton) {
        let pdfURL = "https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf"
        if let pdfVC = UIStoryboard.main.get(PDFDocumentViewController.self),
           let url = URL(string: pdfURL) {
            pdfVC.modalPresentationStyle = .fullScreen
            pdfVC.pdfURL = url
            self.present(pdfVC, animated: true, completion: nil)
        }
    }
    
    @IBAction private func showImageList(_ sender: UIButton) {
        if let imageListVC = UIStoryboard.main.get(ImageListViewController.self) {
            self.navigationController?.pushViewController(imageListVC, animated: true)
        }
    }
    
    private func navigateToViewController() {
        let loginVC = UIStoryboard.main.get(ViewController.self)
        
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
