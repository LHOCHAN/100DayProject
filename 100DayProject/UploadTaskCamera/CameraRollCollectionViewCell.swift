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
    @IBOutlet weak var numOfSelectedLabel: UILabel!
    
    var didSelected = false
    
    //Performs any clean up necessary to prepare the view for use again
    override func prepareForReuse() {
        didSelected = false
        backgroundColor = .clear
        edgeView.layer.borderWidth = 0.0
        numOfSelectedLabel.text = ""
        numOfSelectedLabel.backgroundColor = .clear
    }
}
