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
    @IBOutlet private weak var deviceListTable: UITableView!
    
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        if let currentUser = Auth.auth().currentUser {
            nameLbl.text = currentUser.displayName
            emailLbl.text = currentUser.email
            userImage.setImageFromURl(stringImageUrl: currentUser.photoURL?.absoluteString ?? "")
        }
        
        deviceListTable.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        let nib = UINib(nibName: "DeviceListTableViewCell", bundle: .main)
        deviceListTable.register(nib, forCellReuseIdentifier: DeviceListTableViewCell.reuseIdentifier)
        fetchDeviceData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.clipsToBounds = true
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
    
    private func fetchDeviceData() {
        Task {
            do {
                try await viewModel.fetchDeviceData()
                viewModel.fetchDeviceInfoFromCoreData()
                deviceListTable.reloadData()
            } catch {
                showToast(message: error.localizedDescription)
            }
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeviceListTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? DeviceListTableViewCell else { return UITableViewCell() }
        cell.setDetails(with: viewModel.devices[indexPath.row])
        return cell
    }
    
}
