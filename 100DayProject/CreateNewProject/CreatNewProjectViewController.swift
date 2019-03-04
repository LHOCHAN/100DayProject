//
//  CreatNewProjectViewController.swift
//  100day's Project
//
//  Created by 이호찬 on 31/12/2018.
//  Copyright © 2018 EverydayPJ. All rights reserved.
//

import UIKit

class CreatNewProjectViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: CustomTextField!
    @IBOutlet weak var descriptionTextField: CustomTextField!
    
    @IBOutlet weak var dummyCameraView: UIView!
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var cameraBackgroundView: UIView!
    
    @IBOutlet weak var dummyNoteView: UIView!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteBackgroundView: UIView!
    
    @IBOutlet weak var dummySoundView: UIView!
    @IBOutlet weak var soundImageView: UIImageView!
    @IBOutlet weak var soundBackgroundView: UIView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    var selectedColor = UIColor(red: 19/255, green: 194/255, blue: 157/255, alpha: 0.1)
    
    var isCameraDisabled = true {
        didSet {
            if isCameraDisabled == true {
                cameraImageView.image = #imageLiteral(resourceName: "cameraDisabled")
                cameraBackgroundView.backgroundColor = .white
            } else {
                cameraImageView.image = #imageLiteral(resourceName: "camera")
                cameraBackgroundView.backgroundColor = selectedColor
            }
        }
    }
    
    var isNoteDisabled = true {
        didSet {
            if isNoteDisabled == true {
                noteImageView.image = #imageLiteral(resourceName: "noteDisabled")
                noteBackgroundView.backgroundColor = .white
            } else {
                noteImageView.image = #imageLiteral(resourceName: "note")
                noteBackgroundView.backgroundColor = selectedColor
            }
        }
    }
    
    var isSoundDisabled = true {
        didSet {
            if isSoundDisabled == true {
                soundImageView.image = #imageLiteral(resourceName: "soundDisabled")
                soundBackgroundView.backgroundColor = .white
            } else {
                soundImageView.image = #imageLiteral(resourceName: "sound")
                soundBackgroundView.backgroundColor = selectedColor
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmButton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionTapCameraView(_ sender: UITapGestureRecognizer) {
        if isCameraDisabled {
            isCameraDisabled = !isCameraDisabled
            isNoteDisabled = true
            isSoundDisabled = true
        }
    }
    
    @IBAction func actionTapNoteView(_ sender: UITapGestureRecognizer) {
        if isNoteDisabled {
            isNoteDisabled = !isNoteDisabled
            isSoundDisabled = true
            isCameraDisabled = true
        }
    }
    @IBAction func actionTapSoundView(_ sender: UITapGestureRecognizer) {
        if isSoundDisabled {
            isSoundDisabled = !isSoundDisabled
            isCameraDisabled = true
            isNoteDisabled = true
        }
    }
    
    
    @IBAction func actionDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CreatNewProjectViewController: TextFieldisMaxDelegate {
    func delegate(_ isMax: Bool) {
        if isMax == true {
            print("aAsdadasda")
        }
    }
}

extension CreatNewProjectViewController: UITextFieldDelegate {
    
}


