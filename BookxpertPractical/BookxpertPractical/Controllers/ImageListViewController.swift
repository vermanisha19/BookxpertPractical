//
//  ImageListViewController.swift
//  BookxpertPractical
//
//  Created by MACM13 on 14/04/25.
//

import UIKit

class ImageListViewController: UIViewController {
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var imageCollection: UICollectionView!
    private var viewModel = ImageListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func captureImage(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showImagePicker(with: .camera)
        } else {
            showToast(message: "Camera is not available")
        }
    }
    
    @IBAction private func openPhotoLibrary(_ sender: UIButton) {
        showImagePicker(with: .photoLibrary)
    }
    
    @IBAction private func tapOnBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func showImagePicker(with sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource
extension ImageListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.selectedImages.count
        if count > 0 {
            msgLabel.text = "Selected Image List"
        } else {
            msgLabel.text = "Please Select image from above options"
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.reuseIdentifier, for: indexPath) as? ImageListCollectionViewCell {
            cell.setImage(with: viewModel.selectedImages[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 10
        let totalSpacing = (2 - 1) * interItemSpacing
        let itemWidth = (collectionView.bounds.width - totalSpacing) / 2
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
}

//MARK: - UIImagePickerControllerDelegate
extension ImageListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            viewModel.selectedImages.append(pickedImage)
        }
        dismissImagePicker()
        imageCollection.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissImagePicker()
    }
    
    private func dismissImagePicker() {
        dismiss(animated: true, completion: nil)
    }
}
