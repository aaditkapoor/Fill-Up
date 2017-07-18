//
//  ViewController.swift
//  Fill Up
//
//  Created by Aadit Kapoor on 6/1/17.
//  Copyright © 2017 Aadit Kapoor. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash



class ViewController: UIViewController, UITextViewDelegate {
    
    
    // MARK: OUTLETS
    
    @IBOutlet weak var textDataOutlet: UITextView!
    var videoGetter:VideoGetter!
    var videoId:UITextField!
    
    
    var captionData:String = ""
    
    
    var videoToCapture:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        textDataOutlet.delegate = self
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "analyse" {
            let vc = segue.destination as! AnalyseViewController
            
            if !textDataOutlet.text.isEmpty {
                vc.textToAnalyse = textDataOutlet.text!
            }
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    // MARK: DELEGATION (UITEXTVIEW)
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textDataOutlet.text == "Type Here" {
            textDataOutlet.text = ""
        }
    }
    

    
    
    // MARK: IBACTIONS
    
    
    func createUrl(id:String) -> String {
        return  "http://video.google.com/timedtext?lang=en&v=\(id)"
    }
    
    func getXml(url:String) {
        Alamofire.request(url).validate().responseString { response in
            
            if let x = response.result.value {
                let xml = SWXMLHash.parse(x)
                
                var to_grab = xml["transcript"]["text"]
                for e in xml["transcript"]["text"].all {
                    
                    self.captionData = self.captionData + " " + (e.element!.text)
                    self.createAlert(message: "Captions loading complete.")
                    self.textDataOutlet.text = self.captionData
                    
                }
                
                
            }
            else {
                print ("Error")
                self.createAlert(message: "Error in capturing captions from video.")
            }
        }
        
    }

    
    
    
    @IBAction func youtubeAction(_ sender: Any) {
        let alert = UIAlertController(title: "Import from Youtube", message: "Enter Video ID", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Capture", style: UIAlertActionStyle.default, handler: {alertArg -> Void in
            
            self.videoId = alert.textFields![0] as! UITextField
            
            
            if (self.videoId != nil ) {
                self.videoToCapture = self.videoId.text!
                
                
               let url = self.createUrl(id: self.videoToCapture)
                
               self.getXml(url: url)
        }
        })
        
        alert.addTextField(configurationHandler: {(textField:UITextField!) -> Void in
            
            textField.placeholder = "Enter Youtube Video ID"
        })
        
        alert.addAction(saveAction)
        
        
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
        
        
    }
    
    func createAlert() {
        let alert = UIAlertController(title: "No Input Provided!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Alright", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlert(message:String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Alright", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func analyseAction(_ sender: UIButton) {
        if (textDataOutlet.text == "Type Here") {
            createAlert()
        }
        if !textDataOutlet.text.isEmpty {
            let para = textDataOutlet.text!
            let words = para.components(separatedBy: " ")
            print (para)
            print (words)
        }
    }
    
}

