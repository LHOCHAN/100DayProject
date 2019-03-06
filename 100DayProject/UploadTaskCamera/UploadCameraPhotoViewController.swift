//
//  UploadCameraPhotoViewController.swift
//  100DayProject
//
//  Created by 공지원 on 05/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//
/* TODO
 네비바 버튼들 폰트 변경하기,
 이미지뷰 모서리를 둥글게 만들기,
 save 버튼 활성화 기준 논의하기(최소한 이미지는 있어야지 save 가능?),
 텍스트뷰 placeholder,
 이미지뷰 탭시, 커스텀 카메라롤 뷰 모달로 띄우기,
 키보드 높이 설정,
 오늘자 날짜 가져오기,
 
 
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
        
        setUp()
    }
    
    func setUp() {
        titleTextField.delegate = self
        
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
    }
    
    //MARK : - Action
    @IBAction func imageViewDidTap(_ sender: Any) {
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

