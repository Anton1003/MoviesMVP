//
//  ImageCollectionCell.swift
//  Movies
//
//  Created by User on 10.05.2021.
//

import UIKit

final class ImageCollectionCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!

    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
