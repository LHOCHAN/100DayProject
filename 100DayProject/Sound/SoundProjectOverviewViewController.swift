//
//  SoundProjectOverviewViewController.swift
//  100DayProject
//
//  Created by 이호찬 on 29/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//

import UIKit

class SoundProjectOverviewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "SoundOverviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SoundOverviewCollectionViewCell")
        
        tabView.layer.shadowColor = UIColor.black.cgColor
        tabView.layer.shadowOpacity = 0.1
        tabView.layer.shadowPath = UIBezierPath(rect: tabView.bounds).cgPath
        tabView.layer.shadowOffset = .zero
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SoundProjectOverviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SoundOverviewCollectionViewCell", for: indexPath) as? SoundOverviewCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.register(UINib(nibName: "ProjectOverviewCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: "ProjectOverviewCollectionReusableView")
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProjectOverviewCollectionReusableView", for: indexPath) as? ProjectOverviewCollectionReusableView else { return UICollectionReusableView() }
        
        header.titleLabel.text = "dsafsdfdsafsdfdsafsdfdsafsdfdsafsdfdsafsdfdsafsdfdsafsdfdsafsdf"
        header.subtitleLabel.text = "adfksafkjsdklfjklsdjflkjslkdfjslkdsfsdfdsfsdadfksafk"
        
//        header.setNeedsUpdateConstraints()
//        header.updateConstraintsIfNeeded()
//
//        header.setNeedsLayout()
//        header.layoutIfNeeded()

  
    
        return header
    }

}

extension SoundProjectOverviewViewController: UICollectionViewDelegate {

}

extension SoundProjectOverviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        guard let header = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: section)) as? ProjectOverviewCollectionReusableView else { return .zero }
//
//        header.setNeedsUpdateConstraints()
//        header.updateConstraintsIfNeeded()
//
//        header.setNeedsLayout()
//        header.layoutIfNeeded()
//
//        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//
//        return CGSize(width: view.frame.width, height: size.height)
        
        let titlelabel: UILabel = UILabel(frame: CGRect(x: 16, y: 0, width: collectionView.frame.width - 32, height: CGFloat.greatestFiniteMagnitude))
        titlelabel.numberOfLines = 0
        titlelabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titlelabel.font = UIFont(name: "Lato-Bold", size: 33.0)
        titlelabel.text = "dsafsdfdsafsdfdsafsdfdsafsdfdsafsdfdsafsdfdsafsdfdsafsdfdsafsdf"
        titlelabel.sizeToFit()
        
        let subtitlelabel: UILabel = UILabel(frame: CGRect(x: 16, y: 0, width: collectionView.frame.width - 32, height: CGFloat.greatestFiniteMagnitude))
        subtitlelabel.numberOfLines = 0
        subtitlelabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        subtitlelabel.font = UIFont(name: "Lato-Regular", size: 16.0)
        subtitlelabel.text = "adfksafkjsdklfjklsdjflkjslkdfjslkdsfsdfdsfsdadfksafk"
        subtitlelabel.sizeToFit()
        
        return CGSize(width: collectionView.frame.width, height: titlelabel.frame.height + subtitlelabel.frame.height + 61)
    }
    
    
}
