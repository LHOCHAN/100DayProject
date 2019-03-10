//
//  UploadCameraPhotoViewController.swift
//  100DayProject
//
//  Created by 공지원 on 05/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//
/* TODO
 네비바 버튼들 폰트 변경하기,
 날짜 달을 숫자가 아닌 문자로 변경,
 
 이미지뷰 탭시, 커스텀 카메라롤 뷰 모달로 띄우기,
 save 버튼 활성화 기준 논의하기(최소한 이미지는 있어야지 save 가능?),
 */

import UIKit

class UploadCameraPhotoViewController: UIViewController {
    
    //MARK : - Property
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        return imagePicker
    }()
    
    let date = Date()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    lazy var todayDate: String = {
        let todayDate = dateFormatter.string(from: self.date)
        return todayDate
    }()
    
    //MARK : - Outlet
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    func commonInit() {
        titleTextField.delegate = self
        descTextView.delegate = self
        
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        
        dateLabel.text = todayDate
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
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
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func contentViewDidTap(_ sender: UITapGestureRecognizer) {
        contentView.endEditing(true)
    }
}

//MARK : - Image Picker Delegate
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

