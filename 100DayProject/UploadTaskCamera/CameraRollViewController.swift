//
//  CameraRollViewController.swift
//  100DayProject
//
//  Created by 공지원 on 10/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//

import UIKit
import Photos

class CameraRollViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK : - Property
    private let minimumLineSpacingForSectionAt: CGFloat = 7.0
    private let minimumInteritemSpacingForSectionAt: CGFloat = 7.0
    private let numOfItemsForRow = 3
    
//    private lazy var imagePicker: UIImagePickerController = {
//       let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .camera
//        return imagePicker
//    }()
    
    //private var fetchResult: PHFetchResult<PHAsset>?
    //private lazy var imageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /*
     카메라롤의 fetchResult 얻기
    func getCameraRollImages() {
        guard let cameraRoll = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil).firstObject else { return }
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        fetchResult = PHAsset.fetchAssets(in: cameraRoll, options: fetchOption)
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CameraRollCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.row == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.07500000298, green: 0.7609999776, blue: 0.7179999948, alpha: 1)
            cell.cameraRollImageView.image = #imageLiteral(resourceName: "cameraWhite64")
        }
        else {
            cell.cameraRollImageView.image = #imageLiteral(resourceName: "image")
        }
        
        return cell
    }
    
    //Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 { //카메라 이미지를 선택했다면
            let imagePicker = UIImagePickerController()
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
            }
            imagePicker.delegate = self
            //기기에 카메라가 있으면 사진을 찍는다.
            present(imagePicker, animated: true, completion: nil)
        }
        
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? CameraRollCollectionViewCell {
//            if selectedCell.hasSelected {
//                //selectedCell.edgeView.layer.borderWidth = 0.0
//            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacingForRow = minimumInteritemSpacingForSectionAt * 2
        let itemSize = (collectionView.frame.size.width - spacingForRow) / CGFloat(numOfItemsForRow)
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacingForSectionAt
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacingForSectionAt
    }
}
