//
//  ImageListCollectionViewCell.swift
//  BookxpertPractical
//
//  Created by MACM13 on 14/04/25.
//

import UIKit

class ImageListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    func setImage(with image: UIImage) {
        imageView.image = image
    }
}
