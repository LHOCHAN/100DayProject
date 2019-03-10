//
//  CameraRollCollectionViewCell.swift
//  100DayProject
//
//  Created by 공지원 on 10/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//

import UIKit

class CameraRollCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cameraRollImageView: UIImageView!
    @IBOutlet weak var edgeView: UIView!
    
    //var hasSelected = false
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                edgeView.layer.borderWidth = 10.0
                edgeView.layer.borderColor = #colorLiteral(red: 0.07500000298, green: 0.7609999776, blue: 0.7179999948, alpha: 1)
                //hasSelected = true
            }
            else {
                //edgeView.layer.borderWidth = 0.0
            }
        }
    }
}
