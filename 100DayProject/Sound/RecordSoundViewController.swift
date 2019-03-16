//
//  RecordSoundViewController.swift
//  100DayProject
//
//  Created by 이호찬 on 08/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController {
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var meterTimer: Timer?
    let audioSession = AVAudioSession.sharedInstance()

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = getCurrentDate()
        titleTextField.delegate = self
        checkRecordPermission()
        
        doneButton.isHidden = true
        cancelButton.isHidden = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MM. yyyy"
        return dateFormatter.string(from: Date())
    }
    
    func checkRecordPermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            settingAudioSession()
            
        case AVAudioSession.RecordPermission.denied:
            let alert = UIAlertController(title: "Please check your microphone setting", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction.init(title: "OK", style: .cancel)
            
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            
        case AVAudioSession.RecordPermission.undetermined:
            audioSession.requestRecordPermission { [weak self] isAllowed in
                DispatchQueue.main.async {
                    if isAllowed {
                        self?.recordButton.isEnabled = true
                    } else {
                        self?.recordButton.isEnabled = false
                    }
                }
            }
        default:
            break
        }
    }
    
    func settingAudioSession() {
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("100Day.recordSound")
    }
    
    func startRecording() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: getDocumentDirectory(), settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateAudioMeter(timer:)), userInfo: nil, repeats: true)
            
            recordButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } catch {
            finishRecording()
        }
    }
    
    @objc func updateAudioMeter(timer: Timer) {
        guard let audioRecorder = audioRecorder else { return }
        let min = Int(audioRecorder.currentTime / 60)
        let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
        let mSec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 1) * 100)
        let totalTimeString = String(format: "%02d:%02d.%02d", min, sec, mSec)
        recordTimeLabel.text = totalTimeString
//        print("peakPower: \(audioRecorder.peakPower(forChannel: 0))")
        audioRecorder.updateMeters()
    }
    
    func finishRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        meterTimer?.invalidate()
        
        doneButton.isHidden = false
        cancelButton.isHidden = false
        recordButton.setImage(#imageLiteral(resourceName: "recording"), for: .normal)
        playButton.setImage(#imageLiteral(resourceName: "playPurple"), for: .normal)
    }
    
    func preparePlayRecording() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: getDocumentDirectory())
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            print("asdasa")
        } catch {
            print("Error")
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -30
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @IBAction func actionRecordSound(_ sender: UIButton) {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording()
        }
    }
    
    @IBAction func actionPlayRecordSound(_ sender: UIButton) {
        preparePlayRecording()
        if FileManager.default.fileExists(atPath: getDocumentDirectory().path) {
            audioPlayer?.play()
        }
    }
}

extension RecordSoundViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording()
        }
    }
}

extension RecordSoundViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finishshshsh")
    }
}

extension RecordSoundViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}
