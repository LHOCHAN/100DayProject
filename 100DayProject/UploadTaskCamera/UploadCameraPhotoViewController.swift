//
//  UploadCameraPhotoViewController.swift
//  100DayProject
//
//  Created by 공지원 on 05/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//

import UIKit

class UploadCameraPhotoViewController: UIViewController {
    
    //MARK : - Outlet
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dayLabel: UILabel!
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK : - Property
    var numOfSelectedPhotos = 1
    
    private let cellIdentifier = "UploadCameraPhotoCollectionViewCell"
    
    private let date = Date()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MMM. yyyy"
        return dateFormatter
    }()
    
    private lazy var todayDate: String = {
        let todayDate = dateFormatter.string(from: self.date)
        return todayDate
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        commonInit()
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width - 10, height: 327)
        }
    }
    
    private func commonInit() {
        titleTextField.delegate = self
        descTextView.delegate = self
        
        //imageView.layer.cornerRadius = 10.0
        //imageView.clipsToBounds = true
        /* 이미지 그림자 넣기
         imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
         imageView.layer.shadowColor = UIColor.black.cgColor
         imageView.layer.shadowOpacity = 1
         imageView.layer.shadowRadius = 6
         */
        
        dateLabel.text = todayDate
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Handle keyboard
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        
        view.frame.origin.y = -keyboardHeight
        scrollView.contentInset.top = keyboardHeight
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        view.frame.origin.y = 0
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    //MARK : - Action
    
    @IBAction func imageViewDidTap(_ sender: Any) {
    }
    
    @IBAction func contentViewDidTap(_ sender: UITapGestureRecognizer) {
        contentView.endEditing(true)
    }
}

//MARK : - Image Picker Delegate
/*
 extension UploadCameraPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 print("didFinishPickingMediaWithInfo")
 dismiss(animated: true) {
 let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
 self.imageView.image = selectedImage
 }
 }
 
 func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
 dismiss(animated: true, completion: nil)
 print("imagePickerControllerDidCancel")
 }
 }
 */

//MARK : - TextField Delegate
extension UploadCameraPhotoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - TextView Delegate
extension UploadCameraPhotoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Description"
        }
    }
}

//MARK: - CollectionView Data Source
extension UploadCameraPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? UploadCameraPhotoCollectionViewCell else { return UICollectionViewCell()
        }
        
        //cell.backgroundColor = .red
        cell.configure(image: #imageLiteral(resourceName: "image"))
        
        return cell
    }
}

//MARK: - CollectionView Delegate
extension UploadCameraPhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
}
