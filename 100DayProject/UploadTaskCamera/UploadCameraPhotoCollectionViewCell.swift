//
//  UploadCameraPhotoCollectionViewCell.swift
//  100DayProject
//
//  Created by 공지원 on 29/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//

import UIKit

class UploadCameraPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }
    
}
