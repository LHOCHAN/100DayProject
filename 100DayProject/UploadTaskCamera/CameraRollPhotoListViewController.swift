//
//  CameraRollPhotoListViewController.swift
//  100DayProject
//
//  Created by 공지원 on 28/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//

import UIKit
import Photos

class CameraRollPhotoListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellIdentifier = "collectionViewCell"
    private let cellSpacing: CGFloat = 7
    private let numOfItemsForRow: CGFloat = 3
    
    private var fetchResult: PHFetchResult<PHAsset>?
    private let imageManager = PHCachingImageManager()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        return imagePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        
        setUpCollectionView()
        
        requestAuthorization()
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = (view.frame.size.width - cellSpacing * 2) / numOfItemsForRow
            layout.itemSize = CGSize(width: width, height: width)
        }
    }
    
    private func requestAuthorization() {
        //현재 사진첩 접근 허용 상태를 얻는다.
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized: //이미 접근이 허용되어 있으면
            print("authorized")
            requestCameraRoll() //카메라롤 사진 정보들을 fetch해오고
            DispatchQueue.main.async {
                self.collectionView.reloadData() //컬렉션뷰를 다시 새로 그려라
            }
        case .denied:
            print("denied")
        case .notDetermined:
            print("notDetermined")
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    print("authorized")
                    self.requestCameraRoll()
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .denied:
                    print("denied")
                default: break
                }
            }
        case .restricted:
            print("restricted")
        default:
            break
        }
    }
    
    //카메라롤의 사진들의 메타데이터를 가져온다.
    private func requestCameraRoll() {
        
        //A fetch result that contains the requested PHAssetCollection objects
        let cameraRollFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        //The first object in the fetch result.
        guard let cameraRoll = cameraRollFetchResult.firstObject else {
            return
        }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        //cameraRoll이라는 PHAssetCollection에서 PHAsset들 정보를 fetch한다.
        self.fetchResult = PHAsset.fetchAssets(in: cameraRoll, options: fetchOptions)
    }
    
    //MARK : - IBAction
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        print("doneButtonDidTap")
        dismiss(animated: true) {
            //if 선택한 사진 2장이상이면?
            //else if 선택한 사진이 1장이면
            //else if 선택한 사진이 없다면?
        }
    }
}

//MARK: - CollectionView Data Source
extension CameraRollPhotoListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult?.count ?? 0 //fetchResult가 nil이면 0을 사용하겠다.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //MARK: - 질문1.else 처리 어떻게 하는지
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CameraRollCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let asset = fetchResult?.object(at: indexPath.row) else { return UICollectionViewCell()
            
        }
        
        DispatchQueue.global().async {
            self.imageManager.requestImage(for: asset, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { (image, _) in
                DispatchQueue.main.async {
                    if indexPath.row == 0 {
                        cell.cameraRollImageView.image = #imageLiteral(resourceName: "cameraDisabled")
                        cell.backgroundColor = #colorLiteral(red: 0.07500000298, green: 0.7609999776, blue: 0.7179999948, alpha: 1)
                    }
                    else {
                        cell.cameraRollImageView.image = image
                    }
                }
            })
        }
        
        return cell
    }
}

//MARK: - CollectionView Delegate
extension CameraRollPhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? CameraRollCollectionViewCell else { return }
        
        selectedCell.didSelected = !selectedCell.didSelected
        
        //0번째 셀(카메라모양)을 누르면 카메라가 열리도록
        if indexPath.row == 0 {
            present(imagePickerController, animated: true, completion: nil)
        }
        else {
            if selectedCell.didSelected {
                selectedCell.edgeView.layer.borderWidth = 7.0
                selectedCell.edgeView.layer.borderColor = #colorLiteral(red: 0.07500000298, green: 0.7609999776, blue: 0.7179999948, alpha: 1)
                selectedCell.numOfSelectedLabel.text = "0"
                selectedCell.numOfSelectedLabel.backgroundColor = #colorLiteral(red: 0.07500000298, green: 0.7609999776, blue: 0.7179999948, alpha: 1)
            }
            else {
                selectedCell.edgeView.layer.borderWidth = 0.0
                selectedCell.numOfSelectedLabel.text = ""
                selectedCell.numOfSelectedLabel.backgroundColor = .clear
            }
        }
    }
}

extension CameraRollPhotoListViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("didFinishPickingMediaWithInfo")
        dismiss(animated: true) {
            
            //TODO: - takenPhoto를 UploadCameraPhotoVC의 imageView에 전달해서 넣어야 함
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        dismiss(animated: true, completion: nil)
    }
}
