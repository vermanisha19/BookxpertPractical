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
            userImage.setImageFromURL(stringImageUrl: currentUser.photoURL?.absoluteString ?? "")
        }
        
        deviceListTable.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        let nib = UINib(nibName: "DeviceListTableViewCell", bundle: .main)
        deviceListTable.register(nib, forCellReuseIdentifier: DeviceListTableViewCell.reuseIdentifier)
        
        let coreDataCount = viewModel.fetchDeviceInfoFromCoreData()
        if coreDataCount <= 0 {
            fetchDeviceData()
        } else {
            deviceListTable.reloadData()
        }
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
    
    @IBAction private func refreshData(_ sender: UIButton) {
        fetchDeviceData()
    }
    
    private func navigateToViewController() {
        let loginVC = UIStoryboard.main.get(ViewController.self)
        
        if let window = Device.window {
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
                _ = viewModel.fetchDeviceInfoFromCoreData()
                deviceListTable.reloadData()
            } catch {
                showToast(message: error.localizedDescription)
            }
        }
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeviceListTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? DeviceListTableViewCell else { return UITableViewCell() }
        cell.setDetails(with: viewModel.devices[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let editVC = UIStoryboard.main.get(EditDeviceDetailsViewController.self)
        if let editVC {
            editVC.deviceDetails = viewModel.devices[indexPath.row]
            editVC.updateDeviceDetails = { [weak self] in
                guard let self, let details = editVC.deviceDetails else { return }
                self.viewModel.updateDetails(with: details)
                viewModel.devices[indexPath.row] = details
                self.deviceListTable.reloadData()
            }
            navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteDetails(with: viewModel.devices[indexPath.row])
            viewModel.devices.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}
