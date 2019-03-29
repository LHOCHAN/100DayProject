//
//  ViewController.swift
//  100DayProject
//
//  Created by 이호찬 on 02/03/2019.
//  Copyright © 2019 100DayTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    var documentController: UIDocumentInteractionController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func actionShareInstagram(_ sender: UIButton) {
        //        let goToStr = "instagram://camera"
        //        let urlformat = goToStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //        let url = URL(string: urlformat!)
        //
        //        UIApplication.shared.open(url!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        
        DispatchQueue.main.async {
            
            //Share To Instagram:
            let instagramURL = URL(string: "instagram://app")
            if UIApplication.shared.canOpenURL(instagramURL!) {
                
                let captionString = "caption"
                
                let image = #imageLiteral(resourceName: "image")
                let imageData = image.jpegData(compressionQuality: 100)
                let writePath = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagram.igo")
                
                do {
                    try imageData?.write(to: URL(fileURLWithPath: writePath), options: .atomic)
                } catch {
                    print(error)
                }
                
                let fileURL = URL(fileURLWithPath: writePath)
                self.documentController = UIDocumentInteractionController(url: fileURL)
                self.documentController.delegate = self
                self.documentController.uti = "com.instagram.exlusivegram"
                
                
                self.documentController.annotation = NSDictionary(object: captionString, forKey: "InstagramCaption" as NSCopying)
                self.documentController.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
//                if UIDevice.current.userInterfaceIdiom == .phone {
//                    self.documentController.presentOpenInMenu(from: self.view.bounds, in: self.view, animated: true)
//                } else {
//                    self.documentController.presentOpenInMenu(from: self.IGBarButton, animated: true)
//                }
            } else {
                print(" Instagram is not installed ")
            }
        }
        
    }
    
    
    
    fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
    }
    
}

