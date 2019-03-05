//
//  UploadCameraPhotoViewController.swift
//  100DayProject
//
//  Created by 공지원 on 05/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//

import UIKit

class UploadCameraPhotoViewController: UIViewController {
    //TODO : - 네비바 버튼 폰트 변경하기
    
    //MARK : - Property
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        return imagePicker
    }()
    
    //MARK : - Outlet
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
    
    func setDelegate() {
        titleTextField.delegate = self
    }
    
    //MARK : - Action
    @IBAction func imageViewDidTap(_ sender: Any) {
        //TODO : - imageView가 tap되면, 이미지 피커 컨트롤러를 present한다.
        print("imageViewDidTap")
        present(imagePicker, animated: true, completion: nil)
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
    //TODO : - return키 누르면 키보드가 내려가도록 구현
}

